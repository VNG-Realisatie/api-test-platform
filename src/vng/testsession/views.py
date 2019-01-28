import json
import os
import random
import logging
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
from django.conf import settings


from zds_client import ClientAuth

from vng.testsession.models import (
    ScenarioCase, Session, SessionLog, SessionType, VNGEndpoint, ExposedUrl, TestSession, Report
)

from .task import run_tests, bootstrap_session
from ..utils import choices
from ..utils.newman import NewmanManager
from ..utils.views import (
    ListAppendView, OwnerMultipleObjects, OwnerSingleObject, CSRFExemptMixin, PDFGenerator
)
from .serializers import (
    SessionSerializer, SessionTypesSerializer, ExposedUrlSerializer, ScenarioCaseSerializer
)

logger = logging.getLogger(__name__)


class SessionListView(LoginRequiredMixin, ListAppendView):
    template_name = 'testsession/sessions-list.html'
    context_object_name = 'sessions_list'
    paginate_by = 10
    model = Session
    fields = ['session_type']

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context.update({
            'stop': choices.StatusChoices.stopped,
        })
        return context

    def get_queryset(self):
        '''
        Group all the exposed url by the session in order to display later all related url together
        '''
        return Session.objects.filter(user=self.request.user).order_by('status', '-started')

    def get_success_url(self):
        return reverse('testsession:sessions')

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        form.instance.status = choices.StatusChoices.starting
        form.instance.name = "s{}{}".format(str(self.request.user.id), str(time.time()).replace('.', '-'))

        session = form.save()
        try:
            bootstrap_session(session, self.start_app)
        except Exception as e:
            logger.exception(e)
            session.delete()
            form.add_error('__all__', _('Something went wrong please try again later'))
            return self.form_invalid(form)

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
    paginate_by = 200
    field_name = 'session__user'

    def get_queryset(self):
        return SessionLog.objects.filter(session__pk=self.kwargs['session_id']).order_by('date')

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
        if session.status == choices.StatusChoices.stopped or session.status == choices.StatusChoices.shutting_down:
            return HttpResponseRedirect(reverse('testsession:sessions'))

        run_tests.delay(session.pk)
        session.status = choices.StatusChoices.shutting_down
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
        for case in scenario_case:
            is_in = False
            for rp in report:
                if rp.scenario_case == case:
                    is_in = True
                    break
            if not is_in:
                report.append(Report(scenario_case=case, result=choices.HTTPCallChoiches.not_called))

        context.update({
            'session': self.session,
            'object_list': report
        })

        if len(report) > 0:
            context.update({
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
        '''
        CHECK: not sure if it is needed any more, see prepare_file in newman.py
        '''
        parsed = json.loads(obj)
        for i, run in enumerate(parsed['run']['executions']):
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
