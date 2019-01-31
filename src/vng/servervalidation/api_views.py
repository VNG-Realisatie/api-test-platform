
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
        return ServerRun.objects.filter(user=self.request.user).prefetch_related(Prefetch('endpoint_set', to_attr='endpoints'))

    def perform_create(self, serializer):
        serializer.save(user=self.request.user, pk=None)
