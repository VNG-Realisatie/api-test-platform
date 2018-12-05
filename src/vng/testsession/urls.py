from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.contrib.auth.decorators import login_required
from django.conf.urls import url
from . import views

urlpatterns = [
    url('$', views.SessionListView.as_view(), name='sessions'),
    url('(?P<session_id>[0-9]+)', views.SessionLogView.as_view(), name='session_log'),
    url('(?P<session_id>[0-9]+)/stop', login_required(views.stop_session), name='stop_session'),
    url(r'runtest/(?P<url>([^/])+)/(?P<relative_url>(.)*)$', views.RunTest.as_view(), name='sessionTypes'),
]
