
from django.utils import timezone
from django.contrib.auth.mixins import LoginRequiredMixin
from django.db.models import Prefetch

from rest_framework import permissions, viewsets
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)

from ..permissions.UserPermissions import *
from .serializers import ServerRunSerializer
from .models import (
    ServerRun, Endpoint, TestScenarioUrl, TestScenario, PostmanTest, PostmanTestResult, ExpectedPostmanResult
)


class ServerRunViewSet(LoginRequiredMixin, viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ServerRunSerializer

    def get_queryset(self):
        return ServerRun.objects.filter(user=self.request.user).prefetch_related(
            Prefetch('endpoint_set', to_attr='endpoints'),
            Prefetch('endpoint_set__test_scenario_url'))

    def perform_create(self, serializer):
        server = serializer.save(user=self.request.user, pk=None, started=timezone.now())
        for ep in serializer._kwargs['data']['endpoints']:
            name = ep['name']
            url = ep['url']
            # import pdb
            # pdb.set_trace()
            print(name, url)
            try:

                tsu = TestScenarioUrl.objects.get(name=name, test_scenario=server.test_scenario)
                Endpoint.objects.create(test_scenario_url=tsu, url=url, server_run=server)
            except Exception as e:
                print(e, name, url)
