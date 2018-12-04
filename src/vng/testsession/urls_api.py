from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from . import views

session_detail = views.SessionViewSet.as_view({
    'get': 'retrieve',
    'put': 'update',
    'delete': 'destroy'
})

session_list = views.SessionViewSet.as_view({
    'get': 'list',
    'post': 'create'
})

urlpatterns = [
    url(r'testsessions/(?P<pk>[0-9]+)', session_detail, name='api_sessions'),
    url(r'testsessions/', session_list, name='api_testSession_list'),
    url(r'sessiontypes/', views.SessionTypesViewSet.as_view(), name='sessionTypes'),
]
