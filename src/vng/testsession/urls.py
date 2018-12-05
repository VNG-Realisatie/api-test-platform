from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.contrib.auth.decorators import login_required
from django.conf.urls import url
from . import views

urlpatterns = [
    url('sessions/', views.SessionListView.as_view(), name='sessions'),
    url('start-session/', views.SessionCreate.as_view(), name='start_session'),
    url('session/(?P<session_id>[0-9]+)/log', views.SessionLogView.as_view(), name='session_log'),
    url('stop-session/(?P<session_id>[0-9]+)', login_required(views.stop_session), name='stop_session'),
    url(r'runtest/(?P<url>([^/])+)/(?P<relative_url>(.)*)$', views.RunTest.as_view(), name='sessionTypes'),
]
