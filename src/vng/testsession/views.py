import time
import json
import time
import re
import pdfkit
import uuid
import io
import os
import requests
import logging

from weasyprint import HTML

from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse, HttpResponseRedirect, FileResponse
from django.shortcuts import get_object_or_404
from django.urls import reverse, resolve
from django.utils import timezone
from django.conf import settings
from django.views import View
from django.views.generic.edit import CreateView
from django.views.generic.list import ListView
from django.views.generic.detail import SingleObjectMixin, DetailView
from django.template.loader import render_to_string

from rest_framework import permissions, generics
from rest_framework import viewsets
from rest_framework.authentication import SessionAuthentication, TokenAuthentication

from vng.testsession.models import Session, SessionType, SessionLog, Scenario, ScenarioCase
from .container_manager import K8S
from .serializers import SessionSerializer, SessionTypesSerializer
from ..utils.views import ListAppendView, OwnerObjectMixin, SingleOwnerObject, OwnerMultipleObjects
from ..utils import choices
from ..permissions import UserPermissions


class SessionListView(LoginRequiredMixin, ListAppendView):
    template_name = 'testsession/sessions-list.html'
    context_object_name = 'sessions_list'
    paginate_by = 10
    model = Session
    fields = ['session_type']

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context.update({
            'stop': choices.StatusChoices.stopped
        })
        return context

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user).order_by('-started')

    def start_app(self, form):
        kuber = K8S()
        r = kuber.deploy(form.name, form.session_type.docker_image)

    def get_success_url(self):
        return reverse('testsession:sessions')

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        form.instance.status = 'started'
        form.instance.name = str(self.request.user.id) + str(time.time()).replace('.', '-')
        self.start_app(form.instance)
        return super().form_valid(form)


class SessionLogView(LoginRequiredMixin, ListView):
    template_name = 'testsession/session-log.html'
    context_object_name = 'log_list'
    paginate_by = 20

    def get_queryset(self):
        return SessionLog.objects.filter(session__pk=self.kwargs['session_id']).order_by('-date')


class StopSession(OwnerObjectMixin, View):
    model = Session
    pk_name = 'session_id'

    def post(self, request, *args, **kwargs):
        session = self.get_object()
        session.status = choices.StatusChoices.stopped
        session.save()
        return HttpResponseRedirect(reverse('testsession:sessions'))


class SessionViewSet(viewsets.ModelViewSet):
    serializer_class = SessionSerializer
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user, pk=None)


class SessionTypesViewSet(generics.ListAPIView):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = SessionTypesSerializer
    queryset = SessionType.objects.all()


class SessionReport(OwnerMultipleObjects):

    model = ScenarioCase
    template_name = 'testsession/session-report.html'
    field_name = 'scenario__session__user'

    def get_queryset(self):
        self.session = get_object_or_404(Session, pk=self.kwargs['session_id'])
        return self.model.objects.filter(scenario__pk=self.session.scenario.pk)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context.update({
            'session': self.session
        })
        return context


def get_static_css(folder=None):
    print(folder)
    res = []
    static = os.path.abspath(os.path.join(folder, os.pardir))
    for root, dirs, files in os.walk(folder):
        print(root, dirs, files)
        for file in files:
            rp = os.path.relpath(root, static)
            res.append('{}/{}/{}'.format(static, rp, file))
    res.append("https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css")
    return res


class SessionReportPdf(SessionReport):

    template_name = 'testsession/session-report-pdf.html'

    def get(self, request, *args, **kwargs):
        response = super().get(request, *args, **kwargs).render().content.decode('utf-8')
        base_url = 'http://' + request.get_host()
        print(base_url)
        pdf = HTML(string=response, base_url=base_url).write_pdf()
        # return HttpResponse(response)
        response = HttpResponse(pdf, content_type='application/pdf')
        return response


class RunTest(SingleObjectMixin, View):
    error_codes = [(400, 500)]

    def get_queryset(self):
        return get_object_or_404(Session, exposed_api=self.kwargs['url'])

    def match_url(self, url, compare):
        '''
        Return True if the url matches the compare url.
        The compare url contains the parameter matching group {param}
        '''
        # casting of the reference url into a regex
        param_pattern = '{[^/]+}'
        any_c = '[^/]+'
        parsed_url = '( |/)*' + re.sub(param_pattern, any_c, compare)
        return re.search(parsed_url, url) is not None

    def save_call(self, request, url, relative_url, session, status_code):
        '''
        Find the matching scenario case with the same url and method, if one match is found,
        the result of the call is overrided
        '''
        scenario_cases = ScenarioCase.objects.filter(scenario__pk=session.scenario.pk)
        for case in scenario_cases:
            if case.HTTP_method == request.method:
                if self.match_url(request.build_absolute_uri(), case.url):
                    is_failed = False
                    for a, b in self.error_codes:
                        if status_code > a and status_code < b:
                            case.result = choices.HTTPCallChoiches.failed
                            is_failed = True
                            break
                    if not is_failed:
                        case.result = choices.HTTPCallChoiches.success
                    case.save()

    def get(self, request, url, relative_url):
        session = self.get_queryset()
        session_log = SessionLog()
        session_log.session = session

        req_json = {
            "request": {
                "path": "GET {}".format(request.build_absolute_uri()),
            }
        }
        req_json = json.dumps(req_json)
        session_log.request = req_json

        request_url = session.api_endpoint + relative_url
        r = requests.get(request_url)
        res_json = {
            "response": {
                "status_code": r.status_code,
                "body": r.text,
                "path": "{} {}".format(request.method, request_url),
            }
        }
        res_json = json.dumps(res_json)
        session_log.response = res_json
        session_log.save()
        self.save_call(request, url, relative_url, session, r.status_code)
        return HttpResponse(r.text)

    def post(self, request, url, relative_url):
        session = self.get_queryset()
        session_log = SessionLog()
        session_log.session = session

        req_json = {
            "request": {
                "path": "POST {}".format(request.build_absolute_uri()),
                "body": request.body
            }
        }
        req_json = json.dumps(req_json)
        session_log.request = req_json

        request_url = session.api_endpoint + relative_url
        r = requests.get(request_url, data=request.body)
        res_json = res_json = {
            "response": {
                "status_code": r.status_code,
                "body": r.text,
                "path": "{} {}".format(request.method, request_url),
            }
        }
        res_json = json.dumps(res_json)
        session_log.response = res_json
        session_log.save()
        self.save_call(request, url, relative_url, session, r.status_code)
        return HttpResponse(r.text)
