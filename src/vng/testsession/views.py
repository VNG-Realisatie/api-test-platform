
from django.shortcuts import render
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import Session, Session_type


class SessionListView(LoginRequiredMixin,ListView):
    template_name = 'sessions-list.html'
    context_object_name = 'sessions'
    paginate_by = 10

    def get_queryset(self):
        return Session.objects.filter(user=self.request.user)