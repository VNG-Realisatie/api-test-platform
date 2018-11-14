from datetime import datetime
from django.utils import timezone
from django.shortcuts import render
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.edit import CreateView
from django.http import HttpResponse
from rest_framework import routers, serializers, viewsets
from vng.testsession.models import Session, SessionType
from .serializers import SessionSerializer,SessionTypesSerializer

class SessionListView(LoginRequiredMixin,ListView):
    template_name = 'sessions-list.html'
    context_object_name = 'sessions_list'
    paginate_by = 10

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user)

class SessionCreate(CreateView):
    template_name = 'start-session.html'
    model = Session
    fields = ['session_type']

    def get_success_url(self):
        return '/session/sessions/'

    def form_valid(self, form):
        if self.request.user.is_anonymous:
            return HttpResponse('Unauthorized', status=401)
        form.instance.user = self.request.user
        form.instance.started = timezone.now()
        form.instance.status = 'started'
        form.instance.api_endpoint = 'http://www.google.com'
        return super().form_valid(form)

class SessionViewSet(viewsets.ModelViewSet):
    serializer_class = SessionSerializer

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user)


class SessionTypesViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = SessionTypesSerializer
    queryset = SessionType.objects.all()
