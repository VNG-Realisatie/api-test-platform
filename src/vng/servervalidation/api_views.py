
import json
from itertools import zip_longest

from json.decoder import JSONDecodeError

from django.shortcuts import get_object_or_404
from django.http import HttpResponse
from django.utils import timezone
from django.utils.encoding import force_text
from django.db import transaction
from django.db.models import Prefetch
from django.contrib.auth.mixins import LoginRequiredMixin

from rest_framework import permissions, viewsets, mixins, views, status
from rest_framework.exceptions import bad_request, APIException
from rest_framework.response import Response
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)
from drf_yasg.utils import swagger_auto_schema

from ..permissions.UserPermissions import *
from .serializers import ServerRunSerializer, ServerRunPayloadExample, OpenApiInspectionSerializer
from .models import (
    ServerRun, Endpoint, TestScenarioUrl, TestScenario, PostmanTest, PostmanTestResult, ExpectedPostmanResult
)
from .utils import openAPIInspector


class OpenAPIValidationException(APIException):
    status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
    default_detail = 'A server error occurred.'

    def __init__(self, detail, field, status_code):
        if status_code is not None:
            self.status_code = status_code
        if detail is not None:
            self.detail = {field: force_text(detail)}
        else:
            self.detail = {'detail': force_text(self.default_detail)}


class OpenApiInspectionAPIView(views.APIView):

    def post(self, request):
        serializer = OpenApiInspectionSerializer(data=request.data)
        if serializer.is_valid():
            try:
                version = openAPIInspector(serializer.data['url'])
            except Exception as e:
                print(e)
                if isinstance(e, JSONDecodeError):
                    raise OpenAPIValidationException('The link provided does not contain a json schema', 'url', status_code=status.HTTP_400_BAD_REQUEST)
                else:
                    raise OpenAPIValidationException('The link provided is not reachable', 'url', status_code=status.HTTP_400_BAD_REQUEST)

            return Response({
                'version': version,
                'satisfied': True if version >= 2 else False
            })
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ServerRunViewSet(
        LoginRequiredMixin,
        mixins.CreateModelMixin,
        mixins.ListModelMixin,
        mixins.RetrieveModelMixin,
        viewsets.GenericViewSet):
    """
    create:
    Create a provider-run.

    Create a new provider-run instance.


    retrieve:
    Provider-run detail.

    Return the given provider-run.

    list:
    Provider-run list.

    Return a list of all the existing provider-run.
    """
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ServerRunSerializer

    @swagger_auto_schema(request_body=ServerRunPayloadExample)
    def create(self, *args, **kwargs):
        return super().create(*args, **kwargs)

    def get_queryset(self):
        return ServerRun.objects.filter(user=self.request.user).prefetch_related(
            Prefetch('endpoint_set', to_attr='endpoints'),
            Prefetch('endpoint_set__test_scenario_url'))

    @transaction.atomic
    def perform_create(self, serializer):
        if 'endpoints' in serializer._kwargs['data']:
            server = serializer.save(user=self.request.user, pk=None, started=timezone.now(), endpoint_list=serializer._kwargs['data'].pop('endpoints'))
        else:
            server = serializer.save(user=self.request.user, pk=None, started=timezone.now())


class ResultServerView(LoginRequiredMixin, views.APIView):
    """
    Result of a Session

    Return for each scenario case related to the session, if that call has been performed and the global outcome.
    """
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)

    def get_object(self):
        self.server_run = get_object_or_404(ServerRun, pk=self.kwargs['pk'])
        return self.server_run

    def get(self, request, pk, *args, **kwargs):
        server_run = self.get_object()
        if not server_run.is_stopped():
            res = {
                'Information': 'The tests against the provider-run is undergoing.'
            }
            response = HttpResponse(json.dumps(res))
            response['Content-Type'] = 'application/json'
            return response
        epr = ExpectedPostmanResult.objects.filter(postman_test__test_scenario=server_run.test_scenario)
        postman_res = PostmanTestResult.objects.filter(server_run=server_run)
        response = []
        for postman in postman_res:
            epr = ExpectedPostmanResult.objects.filter(postman_test=postman.postman_test).order_by('order')
            postman.json = postman.get_json_obj()
            postman_res_output = {
                'time': postman.get_json_obj_info()['run']['timings']['started'],
                'calls': []
            }
            for call, ep in zip_longest(postman.json, epr):

                _call = {
                    'name': call['item']['name'],
                    'request': call['request']['method'],
                    'response': call['response']['code'],
                }
                if 'assertions' in call:
                    for _assertion in call['assertions']:
                        _assertion['result'] = 'failed' if 'error' in _assertion else 'success'
                    _call['assertions'] = call['assertions']
                else:
                    _call['assertions'] = []
                if ep is None:
                    _call['status'] = 'Expected response not specified'
                elif str(call['response']['code']) in ep.expected_response:
                    _call['status'] = 'As expected'
                postman_res_output['calls'].append(_call)

            postman_res_output['status'] = postman.status
            response.append(postman_res_output)
        response = HttpResponse(json.dumps(response))
        response['Content-Type'] = 'application/json'
        return response
