from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, redirect
from django.urls import reverse
from django.utils import timezone
from django.views import View
from django.views.generic import DetailView, CreateView, FormView
from django.views.generic.list import MultipleObjectMixin, MultipleObjectTemplateResponseMixin

from ..utils import choices
from ..utils.views import OwnerSingleObject, PDFGenerator
from .forms import CreateServerRunForm, CreateEndpointForm
from .models import (
    ServerRun, Endpoint, TestScenarioUrl, TestScenario, PostmanTest, PostmanTestResult, ExpectedPostmanResult,
    ServerHeader
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
        self.request.session['server_run_scheduled'] = form.instance.scheduled
        return redirect(reverse('server_run:server-run_create', kwargs={
            "test_id": ts_id
        }))

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        server_list = self.get_queryset()
        for sr in data['server_run_list']:
            ptr_set = sr.postmantestresult_set.all()
            if len(ptr_set) == 0:
                sr.success = None
            else:
                success = True
                for ptr in ptr_set:
                    if ptr.is_success() == 0:
                        success = None
                    elif ptr.is_success() == -1 and success is not None:
                        success = False

                sr.success = success
        return data

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
        if self.request.session['server_run_scheduled']:
            self.server = ServerRun(user=self.request.user, test_scenario=ts, scheduled=True, status=choices.StatusWithScheduledChoices.scheduled)
        else:
            self.server = ServerRun(user=self.request.user, test_scenario=ts, scheduled=False)

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
            field_name=url_names[1:]
        )
        if ts.jwt_enabled():
            data['form'].add_text_area(['Client ID', 'Secret'])
        elif ts.custom_header():
            data['form'].add_text_area(['Authorization header'])
        else:
            pass
        data['form'].set_labels(url_names)
        return data

    def form_valid(self, form):
        self.fetch_server()
        if self.server.test_scenario.jwt_enabled():
            self.server.client_id = form.data['Client ID']
            self.server.secret = form.data['Secret']
            self.server.save()
        elif self.server.test_scenario.custom_header():
            self.server.save()
            server_header = ServerHeader(server_run=self.server, header_key='Authorization', header_value=form.data['Authorization header'])
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
        if self.server.scheduled:
            self.server.status = choices.StatusWithScheduledChoices.scheduled
        else:
            self.server.status = choices.StatusWithScheduledChoices.running
        self.server.save()

        ep = form.instance
        ep.server_run = self.server
        ep.save()
        self.endpoints.append(ep)
        if not self.server.scheduled:
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


class TriggerServerRun(OwnerSingleObject, View):

    model = ServerRun
    pk_name = 'server_id'

    def get(self, request, *args, **kwargs):
        server = self.get_object()
        execute_test(server.pk, stop=False)
        return redirect(reverse('server_run:server-run_list'))


class StopServer(OwnerSingleObject, View):

    model = ServerRun
    pk_name = 'server_id'

    def post(self, request, *args, **kwargs):
        server = self.get_object()
        server.stopped = timezone.now()
        server.status = choices.StatusWithScheduledChoices.stopped
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
                if 'response' in calls:
                    calls['response']['code'] = str(calls['response']['code'])
                else:
                    calls['response'] = 'Error occurred call the resource'

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
