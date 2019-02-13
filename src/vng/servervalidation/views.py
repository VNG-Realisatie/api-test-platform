import uuid

from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.files import File
from django.http import HttpResponse, HttpResponseForbidden, HttpResponseRedirect
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.utils import timezone
from django.views import View
from django.core.exceptions import PermissionDenied
from django.views.generic import DetailView, CreateView, FormView
from django.views.generic.list import MultipleObjectMixin, MultipleObjectTemplateResponseMixin, ListView


from ..permissions.UserPermissions import *
from ..utils import choices
from ..utils.newman import DidNotRunException, NewmanManager
from ..utils.views import OwnerSingleObject, PDFGenerator
from .forms import CreateServerRunForm, CreateEndpointForm
from .models import (
    ServerRun, Endpoint, TestScenarioUrl, TestScenario, PostmanTest, PostmanTestResult, ExpectedPostmanResult
)
from .task import execute_test


class TestScenarioSelect(LoginRequiredMixin, FormView, MultipleObjectMixin, MultipleObjectTemplateResponseMixin):
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

    def post(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        return super().post(request, *args, **kwargs)


class CreateEndpoint(LoginRequiredMixin, CreateView):
    template_name = 'servervalidation/server-run_create.html'
    form_class = CreateEndpointForm

    def get_success_url(self):
        return reverse('server_run:server-run_list')

    def fetch_server(self):
        ts = get_object_or_404(TestScenario, pk=self.kwargs['test_id'])
        self.server = ServerRun(user=self.request.user, test_scenario=ts)

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        ts = get_object_or_404(TestScenario, pk=self.kwargs['test_id'])
        self.fetch_server()

        data['ts'] = ts
        data['test_scenario'] = TestScenarioUrl.objects.filter(test_scenario=ts)
        test_scenario_url = TestScenarioUrl.objects.filter(test_scenario=self.server.test_scenario)
        url_names = [tsu.name for tsu in test_scenario_url]
        data['form'] = CreateEndpointForm(
            quantity=len(data['test_scenario']) - 1,
            field_name=url_names[1:],
            text_area=['Client ID', 'Secret']
        )
        data['form'].set_labels(url_names)
        return data

    def form_valid(self, form):
        self.fetch_server()
        self.server.client_id = form.data['Client ID']
        self.server.secret = form.data['Secret']
        self.server.save()
        self.endpoints = []
        tsu = list(TestScenarioUrl.objects.filter(test_scenario=self.server.test_scenario))
        for key, value in form.data.items():
            entry = list(filter(lambda x: x.name == key, tsu))
            if len(entry) == 1:
                entry = entry[0]
                tsu.remove(entry)
                ep = Endpoint(url=value, server_run=self.server, test_scenario_url=entry)
                ep.save()
                self.endpoints.append(ep)
        form.instance.server_run = self.server
        if len(tsu) > 0:
            form.instance.test_scenario_url = tsu[0]
        self.endpoints.append(form.instance)
        self.server.status = choices.StatusChoices.running
        self.server.save()
        execute_test.delay(self.server.pk)

        return HttpResponseRedirect(self.get_success_url())


class ServerRunOutput(OwnerSingleObject, DetailView):
    model = ServerRun
    template_name = 'servervalidation/server-run_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        server_run = context['object']
        ptr = PostmanTestResult.objects.filter(server_run=server_run)
        context["postman_result"] = ptr
        return context


class StopServer(OwnerSingleObject, View):
    model = ServerRun
    pk_name = 'server_id'

    def post(self, request, *args, **kwargs):
        server = self.get_object()
        server.stopped = timezone.now()
        server.status = choices.StatusChoices.stopped
        server.save()
        return redirect(reverse('server_run:server-run_list'))


class ServerRunLogView(LoginRequiredMixin, DetailView):
    model = PostmanTestResult
    template_name = 'servervalidation/server-run_log.html'


class ServerRunLogJsonView(LoginRequiredMixin, DetailView):
    model = PostmanTestResult
    template_name = 'servervalidation/server-run_log_json.html'


class ServerRunPdfView(PDFGenerator, ServerRunOutput):
    template_name = 'servervalidation/server-run-PDF.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        server_run = context['object']
        epr = ExpectedPostmanResult.objects.filter(postman_test__test_scenario=server_run.test_scenario)
        for postman in context['postman_result']:
            epr = ExpectedPostmanResult.objects.filter(postman_test=postman.postman_test).order_by('order')
            postman.json = postman.get_json_obj()
            for calls, ep in zip(postman.json, epr):
                calls['ep'] = ep
                calls['response']['code'] = str(calls['response']['code'])

        context['expect_result'] = epr
        self.filename = 'Server run {} report.pdf'.format(server_run.pk)
        return context


class PostmanDownloadView(View):

    def get(self, request, pk, *args, **kwargs):
        pmt = get_object_or_404(PostmanTest, pk=pk)
        with open(pmt.validation_file.path) as f:
            response = HttpResponse(f, content_type='Application/json')
            response['Content-Length'] = len(response.content)
            response['Content-Disposition'] = 'attachment;filename={}.json'.format(pmt.test_scenario.name)
            return response
