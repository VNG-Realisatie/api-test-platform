import json
import os
import random
import re
import time

from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import (
    Http404, HttpResponse, HttpResponseRedirect, HttpResponseServerError
)
from django.shortcuts import get_object_or_404
from django.urls import reverse
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _
from django.views import View
from django.views.generic.detail import SingleObjectMixin
from django.views.generic.list import ListView
from django.views.generic import DetailView

import requests
from rest_framework import generics, permissions, viewsets
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)
from weasyprint import HTML

from vng.testsession.models import (
    ScenarioCase, Session, SessionLog, SessionType, VNGEndpoint
)

from ..utils import choices
from ..utils.newman import NewmanManager
from ..utils.views import (
    ListAppendView, OwnerMultipleObjects, OwnerSingleObject
)
from .container_manager import K8S
from .serializers import SessionSerializer, SessionTypesSerializer


class SessionListView(LoginRequiredMixin, ListAppendView):
    template_name = 'testsession/sessions-list.html'
    context_object_name = 'sessions_list'
    paginate_by = 10
    model = Session
    fields = ['session_type']

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        # for session in context['object_list']:
        #    session.endpoint = VNGEndpoint.objects.filter(session_type__session__pk=session.pk)
        # print(context['object_list'])
        context.update({
            'stop': choices.StatusChoices.stopped,
            # 'vng_endpoint': VNGEndpoint.objects.filter(sessi)
        })
        return context

    def get_queryset(self):
        # VNGEndpoint.objects.filter(session_type__session__user=self.request.user)
        return Session.objects.filter(user=self.request.user).order_by('-started')

    def start_app(self, session):
        kuber = K8S()
        kuber.deploy(session.name, session.session_type.docker_image, session.port)
        time.sleep(55) # Waiting for the load balancer to be loaded
        return kuber.status(session.name)

    def get_success_url(self):
        return reverse('testsession:sessions')

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        form.instance.status = 'started'
        form.instance.name = "s{}{}".format(str(self.request.user.id), str(time.time()).replace('.', '-'))
        session = form.save()

        try:
            status = self.start_app(session)
        except Exception:
            session.delete()
            form.add_error('__all__', _('Something went wrong please try again later'))
            return self.form_invalid(form)
        session.api_endpoint = 'http://{}:{}'.format(status, session.port)
        session.exposed_api = int(time.time()) * 100 + random.randint(0, 99)

        return super().form_valid(form)


class SessionLogDetailView(OwnerSingleObject):
    template_name = 'testsession/session-log-detail.html'
    context_object_name = 'log_list'
    model = SessionLog
    pk_name = 'pk'
    user_field = 'session__user'


class SessionLogView(OwnerMultipleObjects):
    template_name = 'testsession/session-log.html'
    context_object_name = 'log_list'
    paginate_by = 20
    field_name = 'session__user'

    def get_queryset(self):
        return SessionLog.objects.filter(session__pk=self.kwargs['session_id']).order_by('-date')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        session = get_object_or_404(Session, pk=self.kwargs['session_id'])
        context.update({
            'session': session,
        })
        return context


class StopSession(OwnerSingleObject, View):
    model = Session
    pk_name = 'session_id'

    def post(self, request, *args, **kwargs):
        session = self.get_object()

        # running the test
        if session.test:
            try:
                newman = NewmanManager(session.test.test_file, session.api_endpoint)
                result = newman.execute_test()
                session.save_test(result)
                result_json = newman.execute_test_json()
                session.save_test_json(result_json)
                result_json.close()
            except Exception:
                return HttpResponse(str(Exception))
                return HttpResponseServerError()
        session.status = choices.StatusChoices.stopped
        session.save()
        kuber = K8S()
        kuber.delete(session.name)
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


class SessionReport(OwnerSingleObject):

    model = ScenarioCase
    template_name = 'testsession/session-report.html'

    def get_object(self):
        self.session = get_object_or_404(Session, pk=self.kwargs['session_id'])
        return self.session

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        scenario_case = self.model.objects.filter(vng_endpoint__session_type=self.session.session_type)
        context.update({
            'session': self.session,
            'object_list': scenario_case,
            'session_type': scenario_case[0].vng_endpoint.session_type
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


class PDFGenerator():

    def get(self, request, *args, **kwargs):
        response = super().get(request, *args, **kwargs).render().content.decode('utf-8')
        base_url = 'http://' + request.get_host()
        pdf = HTML(string=response, base_url=base_url).write_pdf()
        response = HttpResponse(pdf, content_type='application/pdf')
        return response


class SessionReportPdf(PDFGenerator, SessionReport):

    template_name = 'testsession/session-report-PDF.html'


class RunTest(View):
    error_codes = [(400, 500)]

    def get_queryset(self):
        return get_object_or_404(Session, exposed_api=self.kwargs['exposed_api'])

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
        scenario_cases = ScenarioCase.objects.filter(vng_endpoint__session_type=session.session_type)
        for case in scenario_cases:
            if case.http_method == request.method:
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

    def get(self, request, *args, **kwargs):
        session_log, session = self.build_session_log(request)

        request_url = '{}/{}'.format(session.api_endpoint, self.kwargs['relative_url'])
        response = requests.get(request_url)

        self.add_response(response, session_log, request_url, request)

        self.save_call(request, self.kwargs['exposed_api'], self.kwargs['relative_url'], session, response.status_code)
        return HttpResponse(response.text)

    def post(self, request, *args, **kwargs):
        session_log, session = self.build_session_log(request)

        request_url = '{}/{}'.format(session.api_endpoint, self.kwargs['relative_url'])
        response = requests.post(request_url, data=request.body)

        self.add_response(response, session_log, request_url, request)

        self.save_call(request, self.kwargs['exposed_api'], self.kwargs['relative_url'], session, response.status_code)
        return HttpResponse(response.text)

    def build_session_log(self, request):
        session = self.get_queryset()
        session_log = SessionLog(session=session)

        request_dict = {
            "request": {
                "path": "{} {}".format(request.method, request.build_absolute_uri()),
                "body": request.body.decode('utf-8')
            }
        }
        session_log.request = json.dumps(request_dict)

        return session_log, session

    def add_response(self, response, session_log, request_url, request):
        response_dict = {
            "response": {
                "status_code": response.status_code,
                "body": response.text,
                "path": "{} {}".format(request.method, request_url),
            }
        }
        session_log.response_status = response.status_code
        session_log.response = json.dumps(response_dict)
        session_log.save()


class SessionTestReport(OwnerSingleObject):

    model = Session
    template_name = 'testsession/session-test-report.html'
    pk_name = 'session_id'


class SessionTestReportPDF(PDFGenerator, SessionTestReport):

    template_name = 'testsession/session-test-report-PDF.html'

    def parse_json(self, obj):
        parsed = json.loads(obj)
        # parsed = munchify(parsed)
        for i, run in enumerate(parsed['run']['executions']):
            print(run)
            url = run['request']['url']
            new_url = url['protocol'] + '://'
            for k in run['request']['header']:
                if k['key'] == 'Host':
                    new_url += k['value']
            new_url += '/'
            for p in url['path']:
                new_url += p + '/'

            run['request']['url'] = new_url

        return parsed

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        session = kwargs['object']

        context.update({
            'report': self.parse_json(session.json_result)
        })
        return context
