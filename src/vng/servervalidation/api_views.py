
import json
from itertools import zip_longest

from django.utils import timezone
from django.db import transaction
from django.contrib.auth.mixins import LoginRequiredMixin
from django.db.models import Prefetch
from django.shortcuts import get_object_or_404
from django.http import HttpResponse

from rest_framework import permissions, viewsets, mixins, views
from rest_framework.exceptions import bad_request
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)

from ..utils.exceptions import Error400
from ..permissions.UserPermissions import *
from .serializers import ServerRunSerializer
from .models import (
    ServerRun, Endpoint, TestScenarioUrl, TestScenario, PostmanTest, PostmanTestResult, ExpectedPostmanResult
)


class ServerRunViewSet(
        LoginRequiredMixin,
        mixins.CreateModelMixin,
        mixins.ListModelMixin,
        mixins.RetrieveModelMixin,
        viewsets.GenericViewSet):
    """
    retrieve:
    Provider-run detail.

    Return the given provider-run.

    list:
    Provider-run list.

    Return a list of all the existing provider-run.

    create:
    Create a provider-run.

    Create a new provider-run instance.
    """
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ServerRunSerializer

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
        epr = ExpectedPostmanResult.objects.filter(postman_test__test_scenario=server_run.test_scenario)
        postman_res = PostmanTestResult.objects.filter(server_run=server_run)
        response = []
        for postman in postman_res:
            epr = ExpectedPostmanResult.objects.filter(postman_test=postman.postman_test).order_by('order')
            postman.json = postman.get_json_obj()
            success = True
            postman_res_output = {
                'calls': []
            }
            for call, ep in zip_longest(postman.json, epr):

                _call = {
                    'time': postman.get_json_obj_info()['run']['timings']['started'],
                    'name': call['item']['name'],
                    'request': call['request']['method'],
                    'response': call['response']['code'],
                }
                # if
                if ep is None:
                    _call['status'] = 'Expected response not specified'
                elif call['response']['code'] in ep.expected_response:
                    _call['status'] = 'As expected'
                else:
                    success = False
                postman_res_output['calls'].append({
                    'call': _call})

            if success:
                postman_res_output['status'] = 'Succeeded'
            else:
                postman_res_output['status'] = 'Failed'
            response.append(postman_res_output)
        response = HttpResponse(json.dumps(response))
        response['Content-Type'] = 'application/json'
        return response
