from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from django.contrib.auth.decorators import login_required
from . import api_views, apps

app_name = apps.AppConfig.__name__

session_detail = api_views.SessionViewSet.as_view({
    'get': 'retrieve',
    'put': 'update',
    'delete': 'destroy'
})

session_list = api_views.SessionViewSet.as_view({
    'get': 'list',
    'post': 'create'
})

urlpatterns = [
    url(r'testsessions/(?P<pk>[0-9]+)', session_detail, name='api_sessions'),
    url(r'stop-session/(?P<pk>[0-9]+)', api_views.StopSessionView.as_view(), name='stop_session'),
    url(r'result-session/(?P<pk>[0-9]+)', api_views.ResultSessionView.as_view(), name='result_session'),
    url(r'testsessions/', session_list, name='test_session_list'),
    url(r'sessiontypes/', api_views.SessionTypesViewSet.as_view(), name='sessionTypes'),
    url(r'exposed_url/(?P<pk>[0-9]+)', api_views.ExposedUrlView.as_view(), name='sessionTypes'),
    url(r'runtest/(?P<url>([^/])+)/$', login_required(api_views.RunTest.as_view()), name='sessionTypes'),
]
