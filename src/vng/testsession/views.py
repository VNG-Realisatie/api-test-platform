from datetime import datetime
from django.utils import timezone
from django.shortcuts import render
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.edit import CreateView
from vng.testsession.models import Session, SessionType


class SessionListView(LoginRequiredMixin,ListView):
    template_name = 'sessions-list.html'
    context_object_name = 'sessions_list'
    paginate_by = 10

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user)

class SessionCreate(CreateView):
    template_name = 'start-session.html'
    model = Session
    fields = ['sessionType']

    def get_success_url(self):
        return '/session/sessions/'

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        form.instance.status = 'started'
        form.instance.api_endpoint = 'http://www.google.com'
        return super().form_valid(form)