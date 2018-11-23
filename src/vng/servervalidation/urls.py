from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from . import views


urlpatterns = [
    url('server-run_list', views.ServerRunView.as_view(), name='server-run_list'),
    url('stop_server-run/(?P<session_id>[0-9]+)', views.stop_session, name='stop_server-run'),
    url('start_server-run', views.ServerRunCreate.as_view(), name='start_server-run'),
]
