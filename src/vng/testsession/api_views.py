import json
import re
import logging
import requests

from urllib import parse
from zds_client import ClientAuth
from subdomains.utils import reverse as reverse_sub
from django.shortcuts import get_object_or_404
from django.urls import reverse
from django.views import View
from django.utils import timezone
from django.conf import settings
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import PermissionDenied
from django.http import (
    Http404, HttpResponse, HttpResponseForbidden
)

from rest_framework import generics, permissions, viewsets, views, mixins
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)
from vng.testsession.models import (
    ScenarioCase, Session, SessionLog, SessionType, ExposedUrl, Report
)

from ..utils import choices
from ..utils.views import CSRFExemptMixin

from .permission import IsOwner
from .serializers import (
    SessionSerializer, SessionTypesSerializer, ExposedUrlSerializer, ScenarioCaseSerializer,
    SessionStatusSerializer
)
from .views import bootstrap_session
from .task import run_tests, stop_session

logger = logging.getLogger(__name__)


def get_jwt(session):

    return ClientAuth(
        client_id=session.client_id,
        secret=session.secret,
        scopes=['zds.scopes.zaken.lezen',
                'zds.scopes.zaaktypes.lezen',
                'zds.scopes.zaken.aanmaken',
                'zds.scopes.statussen.toevoegen',
                'zds.scopes.zaken.bijwerken'],
        zaaktypes=['*']
    )


class SessionViewStatusSet(
        mixins.RetrieveModelMixin,
        viewsets.GenericViewSet):
    serializer_class = SessionStatusSerializer
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated, IsOwner)

    queryset = Session.objects.all()


class SessionViewSet(
        LoginRequiredMixin,
        mixins.CreateModelMixin,
        mixins.ListModelMixin,
        mixins.RetrieveModelMixin,
        viewsets.GenericViewSet):
    """
    retrieve:
    Session detail.

    Return the given session's detail.

    list:
    Session list

    Return the list of all the sessions created by the user.

    create:
    Session create.

    Create a new session instance.
    """
    serializer_class = SessionSerializer
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated, IsOwner)

    def get_queryset(self):
        return Session.objects.all().prefetch_related('exposedurl_set')

    def perform_create(self, serializer):
        session = serializer.save(
            user=self.request.user,
            pk=None,
            status=choices.StatusChoices.starting,
            name=Session.assign_name(self.request.user.id),
            started=timezone.now()
        )
        try:
            bootstrap_session(session.id)
        except Exception as e:
            logger.exception(e)
            session.delete()


class StopSessionView(generics.ListAPIView):
    """
    Stop Session

    Stop the session and retrieve all the scenario cases related to it.
    """
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ScenarioCaseSerializer

    def perform_operations(self, session):
        if session.status == choices.StatusChoices.stopped or session.status == choices.StatusChoices.shutting_down:
            return
        stop_session.delay(session.pk)
        session.status = choices.StatusChoices.shutting_down
        session.save()
        run_tests.delay(session.pk)

    def get_queryset(self):
        scenarios = ScenarioCase.objects.filter(vng_endpoint__session_type__session=self.kwargs['pk'])
        session = get_object_or_404(Session, id=self.kwargs['pk'])
        if session.user != self.request.user:
            return HttpResponseForbidden()
        self.perform_operations(session)
        return scenarios


class ResultSessionView(LoginRequiredMixin, views.APIView):
    """
    Result of a Session

    Return for each scenario case related to the session, if that call has been performed and the global outcome.
    """
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)

    def get(self, request, pk, *args, **kwargs):
        res = None
        session = self.get_object()
        if session.user != request.user:
            raise PermissionDenied
        scenario_cases = ScenarioCase.objects.filter(vng_endpoint__session_type=session.session_type)
        report = list(Report.objects.filter(session_log__session=session))

        def check(sc):
            nonlocal res
            for rp in report:
                if rp.scenario_case == sc:
                    if rp.result == choices.HTTPCallChoiches.success:
                        return
            res = {'result': 'failed'}

        for sc in scenario_cases:
            check(sc)
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


class SessionTypesViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    Session types

    Return all the session types
    """
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated, )
    serializer_class = SessionTypesSerializer

    def get_queryset(self):
        return SessionType.objects.all()


class ExposedUrlView(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    Exposed url

    Return a list of all the exposed url of a certain session.
    """
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

    def get_queryset(self):
        return get_object_or_404(ExposedUrl, subdomain=self.request.subdomain).session

    def match_url(self, url, compare):
        '''
        Return True if the url matches the compare url.
        The compare url contains the parameter matching group {param}
        '''
        # casting of the reference url into a regex
        param_pattern = '{[^/]+}'
        any_c = '[^/]+'
        parsed_url = '( |/)*' + re.sub(param_pattern, any_c, compare) + '$'
        check_url = url.replace('/api/v1//', '/api/v1/')
        logger.info("Parsed: %s", parsed_url)
        logger.info("URL: %s", check_url)
        return re.search(parsed_url, check_url) is not None

    def get_http_header(self, request, endpoint, session):
        '''
        Extracts the http header from the request and add the authorization header for
        gemma platform
        '''
        whitelist = ['host', 'cookie', 'content-length']
        request_headers = {}
        for header, value in request.headers.items():
            if header.lower() not in whitelist:
                request_headers[header] = value

        if session.session_type.authentication == choices.AuthenticationChoices.jwt:
            jwt_auth = get_jwt(session.session_type).credentials()
            for k, i in jwt_auth.items():
                request_headers[k] = i
        elif session.session_type.authentication == choices.AuthenticationChoices.header:
            request_headers['authorization'] = session.session_type.header

        # request_headers['host'] = parse.urlparse(endpoint.url).netloc
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
                    pre_exist = Report.objects.filter(scenario_case=case).filter(session_log__session=session)
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
                    logger.info("Saving report: %s", report.result)
                    report.save()

    def sub_url_response(self, content, host, endpoint):
        '''
        Replace the url of the response body

        Arguments:
            content Str -- Body of the response
            host Str -- Host of the webservice
            endpoint ExposedUrl -- ExposedUrl corresponding the call

        Returns:
            Str -- The body after the rewrite
        '''

        sub = host
        if endpoint.vng_endpoint.url is not None:
            if not endpoint.vng_endpoint.url.endswith('/'):
                if sub.endswith('/'):
                    sub = sub[:-1]
            else:
                if not sub.endswith('/'):
                    sub = sub + '/'
            return re.sub(endpoint.vng_endpoint.url, sub, content)
        else:
            query = parse.urlparse(sub)
            return re.sub(
                '{}://{}:{}/'.format(query.scheme, endpoint.docker_url, 8080),
                sub,
                content
            )

    def sub_url_request(self, content, host, endpoint):
        '''
        Replace the url of the request body

        Arguments:
            content Str -- Body of the request
            host Str -- Host of the webservice
            endpoint ExposedUrl -- ExposedUrl corresponding the call

        Returns:
            Str -- The body after the rewrite
        '''
        sub = host

        if endpoint.vng_endpoint.url is not None:
            if not endpoint.vng_endpoint.url.endswith('/'):
                if sub.endswith('/'):
                    sub = sub[:-1]
            else:
                if not sub.endswith('/'):
                    sub = sub + '/'
            return re.sub(sub, endpoint.vng_endpoint.url, content)
        else:
            query = parse.urlparse(sub)
            return re.sub(
                sub,
                '{}://{}:{}/'.format(query.scheme, endpoint.docker_url, 8080),
                content
            )

    def parse_response(self, response, request, base_url, endpoints):
        """
        Rewrites the VNG Reference responses to make use of ATV URL endpoints:
        https://ref.tst.vng.cloud/zrc/api/v1/zaken/123
        ->
        https://testplatform/runtest/XXXX/api/v1/zaken/123
        """
        parsed = response.text
        protocol = settings.DEFAULT_URL_SCHEME
        host = '{}://{}'.format(protocol, request.get_host())
        for ep in endpoints:
            logger.info("Rewriting response body:")
            parsed = self.sub_url_response(parsed, host, ep)
        return parsed

    def rewrite_request_body(self, request, exposed):
        """
        Rewrites the request body's to replace the ATV URL endpoints to the VNG Reference endpoints
        https://testplatform/runtest/XXXX/api/v1/zaken/123
        ->
        https://ref.tst.vng.cloud/zrc/api/v1/zaken/123
        """
        parsed = request.body.decode('utf-8')
        protocol = settings.DEFAULT_URL_SCHEME
        host = '{}://{}'.format(protocol, request.get_host())
        for eu in exposed:
            logger.info("Rewriting request body:")
            parsed = self.sub_url_request(parsed, host, eu)
        return parsed

    def build_url(self, eu, arguments):
        ru = self.kwargs['relative_url']
        if eu.vng_endpoint.url is not None:
            # sperimental
            # TODO: check if required or not
            path = parse.urlparse(eu.vng_endpoint.url).path
            if path.startswith('/'):
                path = path[1:]
            if ru.startswith(path):
                self.kwargs['relative_url'] = self.kwargs['relative_url'].strip(path)
            # endsperimental
            if eu.vng_endpoint.url.endswith('/'):
                request_url = '{}{}?{}'.format(eu.vng_endpoint.url, self.kwargs['relative_url'], arguments)
            else:
                request_url = '{}/{}?{}'.format(eu.vng_endpoint.url, self.kwargs['relative_url'], arguments)
        else:
            request_url = 'http://{}:{}/{}?{}'.format(eu.docker_url, 8080, self.kwargs['relative_url'], arguments)
        if arguments == '':
            request_url = request_url[:-1]
        return request_url

    def build_method(self, request_method_name, request, body=False):
        self.session = self.get_queryset()
        eu = get_object_or_404(ExposedUrl, session=self.session, subdomain=request.subdomain)
        request_header = self.get_http_header(request, eu.vng_endpoint, self.session)
        session_log, session = self.build_session_log(request, request_header)
        if session.is_stopped():
            raise Http404
        endpoints = ExposedUrl.objects.filter(session=session)
        arguments = request.META['QUERY_STRING']

        request_url = self.build_url(eu, arguments)
        method = getattr(requests, request_method_name)

        def make_call():
            if body:
                rewritten_body = self.rewrite_request_body(request, endpoints)
                logger.info("Request body after rewrite: %s", rewritten_body)
                response = method(request_url, data=rewritten_body, headers=request_header)
            else:
                response = method(request_url, headers=request_header)
            return response

        try:
            response = make_call()
        except Exception as e:
            try:
                request_header['Host'] = '{}:{}'.format(eu.docker_url, 8080)
                response = make_call()
            except Exception as e:
                logger.exception(e)
                raise Http404()

        self.add_response(response, session_log, request_url, request)

        self.save_call(request, request_method_name, request.subdomain,
                       self.kwargs['relative_url'], session, response.status_code, session_log)
        reply = HttpResponse(self.parse_response(response, request, eu.vng_endpoint.url, endpoints), status=response.status_code)
        if 'Content-type' in response.headers:
            reply['Content-type'] = response.headers['Content-type']
        return reply

    def get(self, request, *args, **kwargs):
        return self.build_method('get', request)

    def post(self, request, *args, **kwargs):
        return self.build_method('post', request, body=True)

    def put(self, request, *args, **kwargs):
        return self.build_method('put', request, body=True)

    def delete(self, request, *args, **kwargs):
        return self.build_method('delete', request)

    def patch(self, request, *args, **kwargs):
        return self.build_method('patch', request, body=True)

    def build_session_log(self, request, header):
        session = self.session
        session_log = SessionLog(session=session)
        if 'host' in header:
            if type(header['host']) != str:
                header['host'] = header['host'].decode('utf-8')

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
