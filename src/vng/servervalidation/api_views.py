
import json

from django.utils import timezone
from django.db import transaction
from django.contrib.auth.mixins import LoginRequiredMixin
from django.db.models import Prefetch

from rest_framework import permissions, viewsets, mixins
from rest_framework.exceptions import bad_request
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)

from .exceptions import Error400
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
        server = serializer.save(user=self.request.user, pk=None, started=timezone.now())
        if 'endpoints' in serializer._kwargs['data']:
            for ep in serializer._kwargs['data']['endpoints']:
                name = ep['name']
                url = ep['url']
                try:
                    tsu = TestScenarioUrl.objects.get(name=name, test_scenario=server.test_scenario)
                    Endpoint.objects.create(test_scenario_url=tsu, url=url, server_run=server)
                except Exception as e:
                    raise Error400("The urls names provided do not match")
