from django.shortcuts import render
from django.views.generic.list import ListView
from models import Session, Session_type


class SessionListView(ListView):
    template_name = ''
    queryset=Session.objects.filter(user=request.user)
    context_object_name = 'sessions'
    paginate_by = 10