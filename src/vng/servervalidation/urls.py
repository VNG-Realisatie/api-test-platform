from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from django.contrib.auth.decorators import login_required
from . import views


urlpatterns = [
    url('server-run_list', login_required(views.ServerRunView.as_view()), name='server-run_list'),
    url('stop_server-run/(?P<session_id>[0-9]+)', login_required(views.stop_session), name='stop_server-run'),
    url('server-run_detail/(?P<pk>[0-9]+)/log', login_required(views.ServerRunLogView.as_view()), name='server-run_detail_log'),
    url('server-run_detail/(?P<pk>[0-9]+)', login_required(views.ServerRunOutput.as_view()), name='server-run_detail'),
    url('start_server-run', login_required(views.ServerRunCreate.as_view()), name='start_server-run'),
]
