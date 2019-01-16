import uuid

from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.files import File
from django.http import HttpResponse, HttpResponseForbidden
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.utils import timezone
from django.views import View
from django.core.exceptions import PermissionDenied
from django.views.generic import DetailView, CreateView, FormView
from django.views.generic.list import MultipleObjectMixin, MultipleObjectTemplateResponseMixin, ListView

from rest_framework import permissions, viewsets
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)

from ..permissions.UserPermissions import *
from ..utils import choices
from ..utils.newman import DidNotRunException, NewmanManager
from ..utils.views import OwnerSingleObject
from .forms import CreateServerRunForm, CreateEndpointForm
from .models import ServerRun, Endpoint, TestScenarioUrl, TestScenario
from .serializers import ServerRunSerializer


class TestScenarioSelect(FormView, MultipleObjectMixin, MultipleObjectTemplateResponseMixin):
    template_name = 'servervalidation/server-run_list.html'
    form_class = CreateServerRunForm
    context_object_name = 'server_run_list'
    paginate_by = 10
    model = ServerRun

    def get_queryset(self):
        return self.model.objects.filter(user=self.request.user).order_by('-started')

    def form_valid(self, form):
        ts_id = form.instance.test_scenario.id
        return redirect(reverse('server_run:server-run_create', kwargs={
            "test_id": ts_id
        }))

    def get(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        return super().get(request, *args, **kwargs)


class CreateEndpoint(CreateView):
    template_name = 'servervalidation/server-run_create.html'
    form_class = CreateEndpointForm
    url_field_name = 'Url'

    def get_success_url(self):
        return reverse('server_run:server-run_list')

    def fetch_server(self):
        ts = get_object_or_404(TestScenario, pk=self.kwargs['test_id'])
        self.server = ServerRun(user=self.request.user, test_scenario=ts)

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        ts = get_object_or_404(TestScenario, pk=self.kwargs['test_id'])
        self.fetch_server()

        data['test_scenario'] = TestScenarioUrl.objects.filter(test_scenario=ts)
        data['zipped'] = zip(data['form'], data['test_scenario'])
        data['form'] = CreateEndpointForm(quantity=len(data['test_scenario']) - 1, field_name=self.url_field_name)
        return data

    # def execute_test(self, )

    def form_valid(self, form):
        self.fetch_server()
        self.server.save()
        for key, value in form.data.items():
            if self.url_field_name in key:
                ep = Endpoint(url=value, server_run=self.server)
                ep.save()
                # execute_test()
        form.instance.server_run = self.server

        return super().form_valid(form)


class ServerRunOutput(LoginRequiredMixin, DetailView):
    model = ServerRun
    template_name = 'servervalidation/server-run_detail.html'


class StopServer(OwnerSingleObject, View):
    model = ServerRun
    pk_name = 'server_id'

    def post(self, request, *args, **kwargs):
        server = self.get_object()
        server.stopped = timezone.now()
        server.status = choices.StatusChoices.stopped
        server.save()
        return redirect(reverse('server_run:server-run_list'))


class ServerRunViewSet(LoginRequiredMixin, viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ServerRunSerializer

    def get_queryset(self):
        return ServerRun.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user, pk=None)


class ServerRunLogView(LoginRequiredMixin, View):
    def get(self, request, pk):
        server_run = get_object_or_404(ServerRun, pk=pk)
        if not isOwner(server_run, request.user):
            return HttpResponseForbidden()
        else:
            return render(request, 'servervalidation/server-run_log.html', {'server': server_run})
