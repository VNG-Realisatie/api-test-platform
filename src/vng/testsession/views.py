from datetime import datetime
from django.utils import timezone
from django.shortcuts import render, get_object_or_404, redirect
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.decorators import login_required
from django.views.generic.edit import CreateView
from django.http import HttpResponse
from rest_framework import routers, serializers, viewsets
from rest_framework.authentication import SessionAuthentication, BasicAuthentication,TokenAuthentication
from rest_framework import permissions,generics
from vng.testsession.models import Session, SessionType
from .serializers import SessionSerializer,SessionTypesSerializer


class SessionListView(LoginRequiredMixin,ListView):
    template_name = 'sessions-list.html'
    context_object_name = 'sessions_list'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context.update({
            'stop': Session.StatusChoices.stopped
        })
        return context

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user)

@login_required
def stop_session(request,session_id):
    session = get_object_or_404(Session,pk=session_id)
    if request.user != session.user:
        return HttpResponse('Unauthorized', status=401)
    session.status = Session.StatusChoices.stopped
    session.save()
    return redirect('/session/sessions')


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

class SessionViewSet(generics.ListAPIView):
    serializer_class = SessionSerializer
    authentication_classes = (SessionAuthentication, TokenAuthentication,)
    permission_classes = (permissions.IsAuthenticated,) 

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user)


class SessionTypesViewSet(generics.ListAPIView):
    authentication_classes = ( SessionAuthentication, TokenAuthentication)
    permission_classes = (permissions.IsAuthenticated,) 
    serializer_class = SessionTypesSerializer
    queryset = SessionType.objects.all()
