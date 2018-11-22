from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.list import ListView
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.utils import timezone
from .models import TestScenario, ServerRun

class ServerRunView(LoginRequiredMixin,ListView):
    template_name = 'server/server-run-list.html'
    context_object_name = 'server_run_list'
    paginate_by = 10

    def get_queryset(self):
        return ServerRun.objects.filter(user=self.request.user).order_by('-started')


@login_required
def stop_session(request,session_id):
    server = get_object_or_404(ServerRun,pk=session_id)
    if request.user != server.user:
        return HttpResponse('Unauthorized', status=401)
    server.stopped = timezone.now()
    server.save()
    return redirect('/server/server-run')