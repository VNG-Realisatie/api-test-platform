from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.list import ListView
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.utils import timezone
from django.urls import reverse
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView
from rest_framework import routers, serializers, viewsets
from rest_framework.authentication import SessionAuthentication, BasicAuthentication,TokenAuthentication
from rest_framework import permissions, generics
from .serializers import TestScenarioSerializer, ServerRunSerializer
from .models import TestScenario, ServerRun


class ServerRunView(LoginRequiredMixin,ListView):
    template_name = 'server/server-run_list.html'
    context_object_name = 'server_run_list'
    paginate_by = 10

    def get_queryset(self):
        return ServerRun.objects.filter(user=self.request.user).order_by('-started')


class ServerRunOutput(DetailView):
    model = ServerRun
    template_name = 'server/server-run_detail.html'



@login_required
def stop_session(request,session_id):
    server = get_object_or_404(ServerRun,pk=session_id)
    if request.user != server.user:
        return HttpResponse('Unauthorized', status=401)
    server.stopped = timezone.now()
    server.save()
    return redirect(reverse('server-run_list'))


class ServerRunCreate(CreateView):
    template_name = 'server/start_server-run.html'
    model = ServerRun
    fields = ['test_scenario']

    def get_success_url(self):
        return reverse('server-run_list')

    def form_valid(self, form):
        if self.request.user.is_anonymous:
            return HttpResponse('Unauthorized', status=401)
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        return super().form_valid(form)


class ServerRunViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication, SessionAuthentication)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ServerRunSerializer

    def get_queryset(self):
        return ServerRun.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user,pk=None)
