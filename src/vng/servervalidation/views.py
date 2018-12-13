import uuid

from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.files import File
from django.http import HttpResponse, HttpResponseForbidden
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.utils import timezone
from django.views import View
from django.views.generic import DetailView

from rest_framework import permissions, viewsets
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)

from ..permissions.UserPermissions import *
from ..utils import choices
from ..utils.newman import DidNotRunException, NewmanManager
from ..utils.views import ListAppendView, OwnerSingleObject
from .forms import CreateServerRunForm
from .models import ServerRun
from .serializers import ServerRunSerializer


class ServerRunView(LoginRequiredMixin, ListAppendView):
    template_name = 'servervalidation/server-run_list.html'
    context_object_name = 'server_run_list'
    paginate_by = 10
    model = ServerRun
    form_class = CreateServerRunForm

    def get_queryset(self):
        return self.model.objects.filter(user=self.request.user).order_by('-started')

    def get_success_url(self):
        return reverse('server_run:server-run_list')

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        if form.is_valid():
            file_name = str(uuid.uuid4())
            try:
                file = NewmanManager(form.instance.test_scenario.validation_file, form.instance.api_endpoint) \
                    .execute_test()
            except DidNotRunException:
                return HttpResponse(status=500)
            form.instance.log.save(file_name, File(file))
            form.instance.status = choices.StatusChoices.stopped
            form.instance.stopped = timezone.now()

        redirect = super().form_valid(form)
        return redirect


class ServerRunOutput(LoginRequiredMixin, DetailView):
    model = ServerRun
    template_name = 'servervalidation/server-run_detail.html'


class StopServer(OwnerSingleObject, View):
    model = ServerRun
    pk_name = 'server_id'

    def post(self, request, *args, **kwargs):
        server = self.get_object()
        server.stopped = timezone.now()
        server.status = choices.StatusChoices.stopped
        server.save()
        return redirect(reverse('server_run:server-run_list'))


class ServerRunViewSet(LoginRequiredMixin, viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ServerRunSerializer

    def get_queryset(self):
        return ServerRun.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user, pk=None)


class ServerRunLogView(LoginRequiredMixin, View):
    def get(self, request, pk):
        server_run = get_object_or_404(ServerRun, pk=pk)
        if not isOwner(server_run, request.user):
            return HttpResponseForbidden()
        else:
            return render(request, 'servervalidation/server-run_log.html', {'server': server_run})
