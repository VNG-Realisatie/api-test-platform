from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from . import views

urlpatterns = [
    url('server-run/', views.ServerRunView.as_view(), name='serverRun-list'),
    url('stop-server/(?P<session_id>[0-9]+)', views.stop_session, name='stop_server')
]  