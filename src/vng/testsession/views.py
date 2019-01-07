import json
import os
import random
import re
import logging
import time
from collections import Iterable

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
from django.conf import settings

import requests
from rest_framework import generics, permissions, viewsets
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)
from weasyprint import HTML

from zds_client import ClientAuth

from vng.testsession.models import (
    ScenarioCase, Session, SessionLog, SessionType, VNGEndpoint, ExposedUrl, TestSession, Report
)

from ..utils import choices
from ..utils.newman import NewmanManager
from ..utils.views import (
    ListAppendView, OwnerMultipleObjects, OwnerSingleObject, CSRFExemptMixin
)
from .container_manager import K8S
from .serializers import SessionSerializer, SessionTypesSerializer, ExposedUrlSerializer

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

    def start_app(self, session, endpoint):
        kuber = K8S()
        kuber.deploy(session.name, endpoint.docker_image, endpoint.port)
        time.sleep(55)                      # Waiting for the load balancer to be loaded
        return kuber.status(session.name)

    def get_success_url(self):
        return reverse('testsession:sessions')

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        form.instance.status = choices.StatusChoices.starting
        form.instance.name = "s{}{}".format(str(self.request.user.id), str(time.time()).replace('.', '-'))

        endpoint = VNGEndpoint.objects.filter(session_type=form.instance.session_type)

        session = form.save()
        starting_docker = False

        try:
            for ep in endpoint:
                if ep.docker_image:
                    starting_docker = True
                    status = self.start_app(session, ep)
                else:
                    bind_url = ExposedUrl()
                    bind_url.session = session
                    bind_url.vng_endpoint = ep
                    bind_url.exposed_url = int(time.time()) * 100 + random.randint(0, 99)
                    bind_url.save()

        except Exception as e:
            logger.exception(e)
            session.delete()
            form.add_error('__all__', _('Something went wrong please try again later'))
            return self.form_invalid(form)

        if not starting_docker:
            session.status = choices.StatusChoices.running
            session.save()
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

    def run_tests(self, session):
        exposed_url = ExposedUrl.objects.filter(session=session,
                                                vng_endpoint__session_type=session.session_type)

        # stop the session for each exposed url, and eventually run the tests
        for eu in exposed_url:
            t = eu.vng_endpoint.test_session
            if not t or not t.test_file:
                continue
            ep = eu.vng_endpoint
            newman = NewmanManager(t.test_file, ep.url)
            result = newman.execute_test()

            t.save_test(result)
            result_json = newman.execute_test_json()
            t.save_test_json(result_json)
            result_json.close()

            t.save()

        session.status = choices.StatusChoices.stopped
        session.save()

        endpoint = VNGEndpoint.objects.filter(session_type=session.session_type)

        # if the endpoints is related to an online cluster image it is stopped
        for ep in endpoint:
            if ep.docker_image:
                kuber = K8S()
                kuber.delete(session.name)

    def post(self, request, *args, **kwargs):
        session = self.get_object()
        if session.status == choices.StatusChoices.stopped:
            return HttpResponseRedirect(reverse('testsession:sessions'))

        self.run_tests(session)

        return HttpResponseRedirect(reverse('testsession:sessions'))


class ExposedUrlView(generics.ListAPIView):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ExposedUrlSerializer

    def get_queryset(self):
        return ExposedUrl.objects.filter(session=self.kwargs['pk'])


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
        report = list(Report.objects.filter(session_log__session=self.session))
        for case in scenario_case:
            is_in = False
            for rp in report:
                if rp.scenario_case == case:
                    is_in = True
                    break
            if not is_in:
                report.append(Report(scenario_case=case))

        context.update({
            'session': self.session,
            'object_list': report
        })
        if len(report) > 0:
            context.update({
                'session_type': self.session.session_type
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


class RunTest(CSRFExemptMixin, View):
    """ Proxy-view between clients and servers """
    error_codes = [(400, 500)]

    def get_queryset(self):
        return get_object_or_404(ExposedUrl, exposed_url=self.kwargs['exposed_url']).session

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

    def get_http_header(self, request):
        '''
        Extracts the http header from the request and add the authorization header for
        gemma platform
        '''
        regex = [
            re.compile(r'^HTTP_.+$'),
            re.compile(r'^CONTENT_TYPE$'),
            re.compile(r'^CONTENT_LENGTH$'),
            re.compile(r'^Accept-Crs$'),
            re.compile(r'^Content-Type$'),
        ]

        request_headers = {}
        for header in request.META:
            cond = False
            for reg in regex:
                cond = cond or reg.match(header)
            if cond:
                request_headers[header] = request.META[header]

        if 'HTTP_AUTHORIZATION' in request_headers:
            request_headers['Authorization'] = request_headers.pop('HTTP_AUTHORIZATION')
        if 'HTTP_ACCEPT_CRS' in request_headers:
            request_headers['Accept-Crs'] = request_headers.pop('HTTP_ACCEPT_CRS')
        if 'CONTENT_TYPE' in request_headers:
            request_headers['Content-Type'] = request_headers.pop('CONTENT_TYPE')

        return request_headers

    def save_call(self, request, url, relative_url, session, status_code, session_log):
        '''
        Find the matching scenario case with the same url and method, if one match is found,
        the result of the call is overrided
        '''
        scenario_cases = ScenarioCase.objects.filter(vng_endpoint__session_type=session.session_type)
        for case in scenario_cases:
            if case.http_method == request.method:
                if self.match_url(request.build_absolute_uri(), case.url):
                    report = Report(scenario_case=case, session_log=session_log)
                    is_failed = False
                    for a, b in self.error_codes:
                        if status_code > a and status_code < b:
                            report.result = choices.HTTPCallChoiches.failed
                            is_failed = True
                            break
                    if not is_failed:
                        report.result = choices.HTTPCallChoiches.success
                    case.save()
                    report.save()

    def parse_response(self, response, request, base_url, endpoints):
        """
        Rewrites the VNG Reference responses to make use of ATV URL endpoints:
        https://ref.tst.vng.cloud/zrc/api/v1/zaken/123
        ->
        https://testplatform/runtest/XXXX/api/v1/zaken/123
        """
        parsed = response.text
        host = 'https://{}'.format(request.get_host())
        for ep in endpoints:
            sub = '{}{}'.format(
                host,
                reverse('testsession:run_test', kwargs={
                    'exposed_url': ep.exposed_url,
                    'relative_url': ''
                })
            )
            parsed = re.sub(ep.vng_endpoint.url, sub, parsed)
        return parsed

    def rewrite_request_body(self, request, endpoints):
        """
        Rewrites the request body's to replace the ATV URL endpoints to the VNG Reference endpoints
        https://testplatform/runtest/XXXX/api/v1/zaken/123
        ->
        https://ref.tst.vng.cloud/zrc/api/v1/zaken/123
        """
        parsed = request.body.decode('utf-8')
        if settings.DEBUG:
            host = 'http://{}'.format(request.get_host())
        else:
            host = 'https://{}'.format(request.get_host())
        for ep in endpoints:
            sub = '{}{}'.format(
                host,
                reverse('testsession:run_test', kwargs={
                    'exposed_url': ep.exposed_url,
                    'relative_url': ''
                })
            )
            parsed = re.sub(sub, ep.vng_endpoint.url, parsed)
        return parsed

    def build_method(self, name, request, body=False):
        request_header = self.get_http_header(request)
        session_log, session = self.build_session_log(request, request_header)

        eu = get_object_or_404(ExposedUrl, session=session, exposed_url=self.kwargs['exposed_url'])  # ExposedUrl.objects.filter(session=session).filter(exposed_url=self.kwargs['exposed_url'])
        endpoints = ExposedUrl.objects.filter(vng_endpoint__session_type=eu.vng_endpoint.session_type)

        request_url = '{}/{}'.format(eu.vng_endpoint.url, self.kwargs['relative_url'])

        method = getattr(requests, name)
        if body:
            rewritten_body = self.rewrite_request_body(request, endpoints)
            response = method(request_url, data=rewritten_body, headers=request_header)
        else:
            response = method(request_url, headers=request_header)

        self.add_response(response, session_log, request_url, request)

        self.save_call(request, self.kwargs['exposed_url'], self.kwargs['relative_url'], session, response.status_code, session_log)

        response = HttpResponse(self.parse_response(response, request, eu.vng_endpoint.url, endpoints))
        response['Content-Type'] = 'application/json'
        return response

    def get(self, request, *args, **kwargs):
        return self.build_method('get', request)

    def post(self, request, *args, **kwargs):
        return self.build_method('post', request, body=True)

    def put(self, request, *args, **kwargs):
        return self.build_method('put', request, body=True)

    def delete(self, request, *args, **kwargs):
        return self.build_method('delete', request)

    def patch(self, request, *args, **kwargs):
        return self.build_method('patch', request)

    def build_session_log(self, request, header):
        session = self.get_queryset()
        session_log = SessionLog(session=session)

        request_dict = {
            "request": {
                "path": "{} {}".format(request.method, request.build_absolute_uri()),
                "body": request.body.decode('utf-8'),
                "header": header
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

    model = TestSession
    template_name = 'testsession/session-test-report.html'
    pk_name = 'pk'
    user_field = 'vngendpoint__exposedurl__session__user'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        session = ExposedUrl.objects.filter(vng_endpoint__test_session=self.object).first().session
        context.update({
            'session': session
        })
        return context


class SessionTestReportPDF(PDFGenerator, SessionTestReport):

    template_name = 'testsession/session-test-report-PDF.html'

    def parse_json(self, obj):
        parsed = json.loads(obj)
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
