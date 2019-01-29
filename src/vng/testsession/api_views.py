import json
import re
import logging
import requests

from django.shortcuts import get_object_or_404
from django.urls import reverse
from django.views import View
from django.conf import settings
from django.http import (
    Http404, HttpResponse, HttpResponseRedirect, HttpResponseServerError
)

from rest_framework import generics, permissions, viewsets, views
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)
from vng.testsession.models import (
    ScenarioCase, Session, SessionLog, SessionType, VNGEndpoint, ExposedUrl, TestSession, Report
)

from ..utils import choices
from ..utils.views import (
    ListAppendView, OwnerMultipleObjects, OwnerSingleObject, CSRFExemptMixin
)
from .permission import IsOwner
from .serializers import (
    SessionSerializer, SessionTypesSerializer, ExposedUrlSerializer, ScenarioCaseSerializer
)
from .views import bootstrap_session, StopSession

logger = logging.getLogger(__name__)


class SessionViewSet(viewsets.ModelViewSet):
    serializer_class = SessionSerializer
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated, IsOwner)

    def get_queryset(self):
        return Session.objects.filter(id=self.kwargs['pk']).prefetch_related('exposedurl_set')

    def perform_create(self, serializer):
        session = serializer.save(user=self.request.user, pk=None)
        try:
            bootstrap_session(session.id)
        except Exception as e:
            logger.exception(e)
            session.delete()


class StopSessionView(generics.ListAPIView):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated, IsOwner)
    serializer_class = ScenarioCaseSerializer

    def perform_operations(self, session):
        if session.status != choices.StatusChoices.stopped:
            session.status = choices.StatusChoices.stopped
            StopSession.run_tests(session)

    def get_queryset(self):
        scenarios = ScenarioCase.objects.filter(vng_endpoint__session_type__session=self.kwargs['pk'])
        session = get_object_or_404(Session, id=self.kwargs['pk'])
        self.perform_operations(session)
        return scenarios


class ResultSessionView(views.APIView):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)

    def get(self, request, pk, *args, **kwargs):
        res = None
        session = self.get_object()
        scenario_cases = ScenarioCase.objects.filter(vng_endpoint__session_type=session.session_type)
        report = list(Report.objects.filter(session_log__session=session))

        def check():
            nonlocal res
            for rp in report:
                if rp.scenario_case == sc:
                    if rp.result == choices.HTTPCallChoiches.success:
                        return
            res = {'result': 'failed'}

        for sc in scenario_cases:
            check()
        if len(scenario_cases) == 0:
            res = {'result': 'No scenario cases available'}
        if res is None:
            res = {'result': 'success'}

        res['report'] = []
        for case in scenario_cases:
            is_in = False
            for rp in report:
                if rp.scenario_case == case:
                    is_in = True
                    break
            if not is_in:
                report.append(Report(scenario_case=case))

        for rp in report:
            call = {
                'scenario_case': ScenarioCaseSerializer(rp.scenario_case).data
            }

            call['result'] = rp.result

            res['report'].append(call)

        res['test_session_url'] = session.get_absolute_request_url(request)

        response = HttpResponse(json.dumps(res))
        response['Content-Type'] = 'application/json'
        return response

    def get_object(self):
        self.session = get_object_or_404(Session, pk=self.kwargs['pk'])
        return self.session


class SessionTypesViewSet(generics.ListAPIView):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated, )
    serializer_class = SessionTypesSerializer

    def get_queryset(self):
        return SessionType.objects.all()


class ExposedUrlView(generics.ListAPIView):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated, IsOwner)
    serializer_class = ExposedUrlSerializer
    user_path = ['session']

    def get_queryset(self):
        qs = ExposedUrl.objects.filter(session=self.kwargs['pk'])
        self.check_object_permissions(self.request, qs)
        return qs


class RunTest(CSRFExemptMixin, View):
    """ Proxy-view between clients and servers """
    error_codes = [(400, 599)]  # boundaries considered as errors

    def get_exposed_url(self):
        exposed_url = '{}/{}'.format(self.kwargs['exposed_url'], self.kwargs['name'])
        return exposed_url

    def get_queryset(self):
        return get_object_or_404(ExposedUrl, exposed_url=self.get_exposed_url()).session

    def match_url(self, url, compare):
        '''
        Return True if the url matches the compare url.
        The compare url contains the parameter matching group {param}
        '''
        # casting of the reference url into a regex
        param_pattern = '{[^/]+}'
        any_c = '[^/]+'
        parsed_url = '( |/)*' + re.sub(param_pattern, any_c, compare)
        check_url = url.replace('/api/v1//', '/api/v1/')
        logger.info("Parsed: {}".format(parsed_url))
        logger.info("URL: {}".format(check_url))
        return re.search(parsed_url, check_url) is not None

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

    def save_call(self, request, request_method_name, url, relative_url, session, status_code, session_log):
        '''
        Find the matching scenario case with the same url and method, if one match is found,
        the result of the call is overrided
        '''
        logger.info("Saving call")
        logger.info(request_method_name)
        logger.info(url)
        logger.info(relative_url)
        scenario_cases = ScenarioCase.objects.filter(vng_endpoint__session_type=session.session_type)
        for case in scenario_cases:
            logger.info(case)
            if case.http_method.lower() == request_method_name.lower():
                if self.match_url(request.build_absolute_uri(), case.url):
                    pre_exist = Report.objects.filter(scenario_case=case).filter(session_log=session_log)
                    if len(pre_exist) == 0:
                        report = Report(scenario_case=case, session_log=session_log)
                    else:
                        report = pre_exist[0]
                    is_failed = False
                    for a, b in self.error_codes:
                        if status_code >= a and status_code <= b:
                            report.result = choices.HTTPCallChoiches.failed
                            is_failed = True
                            break
                    if not is_failed and not report.is_failed():
                        report.result = choices.HTTPCallChoiches.success
                    logger.info("Saving report: {}".format(report.result))
                    report.save()

    def parse_response(self, response, request, base_url, endpoints):
        """
        Rewrites the VNG Reference responses to make use of ATV URL endpoints:
        https://ref.tst.vng.cloud/zrc/api/v1/zaken/123
        ->
        https://testplatform/runtest/XXXX/api/v1/zaken/123
        """
        parsed = response.text
        if settings.DEBUG:
            host = 'http://{}'.format(request.get_host())
        else:
            host = 'https://{}'.format(request.get_host())
        for ep in endpoints:
            sub = '{}{}'.format(
                host,
                reverse('testsession:run_test', kwargs={
                    'exposed_url': ep.get_uuid_url(),
                    'name': ep.vng_endpoint.name,
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
                    'name': ep.vng_endpoint.name,
                    'relative_url': ''
                })
            )
            parsed = re.sub(sub, ep.vng_endpoint.url, parsed)
        return parsed

    def build_method(self, request_method_name, request, body=False):
        request_header = self.get_http_header(request)
        session_log, session = self.build_session_log(request, request_header)
        if session.is_stopped():
            raise Http404
        eu = get_object_or_404(ExposedUrl, session=session, exposed_url=self.get_exposed_url())
        endpoints = ExposedUrl.objects.filter(session=session)
        arguments = request.META['QUERY_STRING']

        if eu.vng_endpoint.url.endswith('/'):
            request_url = '{}{}?{}'.format(eu.vng_endpoint.url, self.kwargs['relative_url'], arguments)
        else:
            request_url = '{}/{}?{}'.format(eu.vng_endpoint.url, self.kwargs['relative_url'], arguments)
        method = getattr(requests, request_method_name)

        if body:
            logger.info("Request body before rewrite: {}".format(request.body))
            rewritten_body = self.rewrite_request_body(request, endpoints)
            logger.info("Request body after rewrite: {}".format(rewritten_body))
            response = method(request_url, data=rewritten_body, headers=request_header)
        else:
            response = method(request_url, headers=request_header)

        self.add_response(response, session_log, request_url, request)

        self.save_call(request, request_method_name, self.get_exposed_url(),
                       self.kwargs['relative_url'], session, response.status_code, session_log)

        response = HttpResponse(self.parse_response(response, request, eu.vng_endpoint.url, endpoints), status=response.status_code)
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
