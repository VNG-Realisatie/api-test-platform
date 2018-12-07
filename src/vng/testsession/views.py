import time
import json
import time

import requests
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404
from django.urls import reverse
from django.utils import timezone
from django.views import View
from django.views.generic.edit import CreateView
from django.views.generic.list import ListView
from django.views.generic.detail import SingleObjectMixin
from rest_framework import permissions, generics
from rest_framework import viewsets
from rest_framework.authentication import SessionAuthentication, TokenAuthentication

from vng.testsession.models import Session, SessionType, SessionLog
from .container_manager import K8S
from .serializers import SessionSerializer, SessionTypesSerializer
from ..utils.views import ListAppendView, OwnerObjectMixin
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
        print(r)

    def get_success_url(self):
        return reverse('testsession:sessions')

    def form_valid(self, form):
        if self.request.user.is_anonymous:
            return HttpResponse('Unauthorized', status=401)
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


class StopSession(LoginRequiredMixin, OwnerObjectMixin, View):
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


class RunTest(LoginRequiredMixin, SingleObjectMixin, View):
    def get_queryset(self):
        return get_object_or_404(Session, exposed_api=self.kwargs['url'])

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

        r = requests.get(session.api_endpoint + relative_url)
        res_json = {
            "response": {
                "status_code": r.status_code,
                "body": r.text,
                "path": "{} {}".format(json.dumps(request.GET), request.build_absolute_uri()),
            }
        }
        res_json = json.dumps(res_json)
        session_log.response = res_json
        session_log.save()
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

        r = requests.post(session.api_endpoint + relative_url, data=request.body)
        res_json = res_json = {
            "response": {
                "status_code": r.status_code,
                "body": r.text,
                "path": "{} {}".format(json.dumps(request.GET), request.build_absolute_uri()),
            }
        }
        res_json = json.dumps(res_json)
        session_log.response = res_json
        session_log.save()
        return HttpResponse(r.text)


def update_status_session(session):
    session.status = K8S().status(session.name)
    session.save()
