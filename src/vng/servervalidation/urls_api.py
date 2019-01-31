from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url

from . import views, api_views


server_run_list = api_views.ServerRunViewSet.as_view({
    'get': 'list',
    'post': 'create',
})

server_run_create = api_views.ServerRunViewSet.as_view({
    'get': 'retrieve',
})

urlpatterns = [
    url(r'server-run/(?P<pk>[0-9]+)', server_run_create, name='api_server-run'),
    url(r'server-run', server_run_list, name='api_server-run_list'),
]
