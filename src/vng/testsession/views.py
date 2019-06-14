import json
import logging


from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse, HttpResponseRedirect
from django.views.generic.edit import FormView
from django.views.generic.detail import DetailView
from django.views.generic.list import ListView
from django.shortcuts import get_object_or_404
from django.urls import reverse
from django.utils import timezone
from django.views import View


from .models import (
    ScenarioCase, Session, SessionLog, ExposedUrl,
    TestSession, Report, SessionType
)

from .task import run_tests, bootstrap_session, stop_session
from .forms import SessionForm
from ..utils import choices
from ..utils.views import (
    ListAppendView, OwnerMultipleObjects, OwnerSingleObject, PDFGenerator
)


logger = logging.getLogger(__name__)


class SessionListView(LoginRequiredMixin, ListView):

    template_name = 'testsession/sessions-list.html'
    context_object_name = 'sessions_list'
    paginate_by = 10
    model = Session

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        _choices = dict(choices.StatusChoices.choices)
        context.update({
            'choices': _choices,
        })
        sessions_related = [(session, *session.get_report_stats()) for session in context['object_list']]
        context['object_list'] = sessions_related
        return context

    def get_queryset(self):
        '''
        Group all the exposed url by the session in order to display later all related url together
        '''
        return Session.objects.filter(user=self.request.user).order_by('-started')


class SessionFormView(FormView):

    template_name = 'testsession/session-form.html'
    form_class = SessionForm

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        form.instance.status = choices.StatusChoices.starting
        form.instance.assign_name(self.request.user.id)
        form.instance.name = Session.assign_name(self.request.user.id)
        session = form.save()
        bootstrap_session.delay(session.pk)
        return HttpResponseRedirect(self.get_success_url())


class SessionLogDetailView(OwnerSingleObject):

    template_name = 'testsession/session-log-detail.html'
    context_object_name = 'log_list'
    model = SessionLog
    pk_name = 'pk'
    user_field = 'session__user'


class SessionLogView(OwnerMultipleObjects):

    template_name = 'testsession/session-log.html'
    context_object_name = 'log_list'
    paginate_by = 200
    field_name = 'session__user'

    def get_queryset(self):
        return SessionLog.objects.filter(session__pk=self.kwargs['session_id']).order_by('date')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        session = get_object_or_404(Session, pk=self.kwargs['session_id'])
        stats = session.get_report_stats()

        context.update({
            'session': session,
            'success': stats[0],
            'failed': stats[1],
            'not_called': stats[2],
            'total': sum(stats)
        })
        return context


class StopSession(OwnerSingleObject, View):

    model = Session
    pk_name = 'session_id'

    def post(self, request, *args, **kwargs):
        session = self.get_object()
        if session.status == choices.StatusChoices.stopped or session.status == choices.StatusChoices.shutting_down:
            return HttpResponseRedirect(reverse('testsession:sessions'))

        session.status = choices.StatusChoices.shutting_down
        session.save()
        stop_session.delay(session.pk)
        return HttpResponseRedirect(reverse('testsession:sessions'))


class SessionReport(OwnerSingleObject):

    model = ScenarioCase
    template_name = 'testsession/session-report.html'

    def get_object(self):
        self.session = get_object_or_404(Session, pk=self.kwargs['session_id'])
        return self.session

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        scenario_case = self.model.objects.filter(vng_endpoint__session_type=self.session.session_type)
        report = list(Report.objects.filter(session_log__session=self.session))
        report_ordered = []
        for case in scenario_case:
            is_in = False
            for rp in report:
                if rp.scenario_case == case:
                    report_ordered.append(rp)
                    is_in = True
                    break
            if not is_in:
                report_ordered.append(Report(scenario_case=case, result=choices.HTTPCallChoiches.not_called))

        context.update({
            'session': self.session,
            'object_list': report_ordered,
            'session_type': self.session.session_type,
        })
        return context


class SessionReportPdf(PDFGenerator, SessionReport):

    template_name = 'testsession/session-report-PDF.html'


class SessionTestReport(OwnerSingleObject):

    model = TestSession
    template_name = 'testsession/session-test-report.html'
    pk_name = 'pk'
    user_field = 'exposedurl__session__user'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        session = ExposedUrl.objects.filter(test_session=self.object).first().session
        context.update({
            'session': session
        })
        return context


class SessionTestReportPDF(PDFGenerator, SessionTestReport):

    template_name = 'testsession/session-test-report-PDF.html'

    def parse_json(self, obj):
        parsed = json.loads(obj)
        for run in parsed['run']['executions']:
            url = run['request']['url']
            if 'protocol' in url:
                new_url = url['protocol'] + '://'
            else:
                new_url = 'https://'
            for k in run['request']['header']:
                if k['key'] == 'Host':
                    new_url += k['value']
            new_url += '/'
            if 'path' in url:
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


class PostmanDownloadView(View):

    def get(self, request, pk, *args, **kwargs):
        eu = get_object_or_404(ExposedUrl, pk=pk)
        with open(eu.vng_endpoint.test_file.path) as f:
            response = HttpResponse(f, content_type='Application/json')
            response['Content-Length'] = len(response.content)
            response['Content-Disposition'] = 'attachment;filename=test{}.json'.format(eu.vng_endpoint.name)
            return response


class SessionTypeDetail(DetailView):

    model = SessionType
    template_name = 'testsession/session_type-detail.html'
