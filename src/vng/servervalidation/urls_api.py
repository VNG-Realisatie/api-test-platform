from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from . import views



server_run_list = views.ServerRunViewSet.as_view({
    'get': 'list',
})

server_run_create = views.ServerRunViewSet.as_view({
    'post': 'create',
})

urlpatterns = [
    url(r'server-run/(?P<pk>[0-9]+)/', server_run_create, name='api_server-run'),
    url(r'server-run/', server_run_list, name='api_server-run_list'),
]  