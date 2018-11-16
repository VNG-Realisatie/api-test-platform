from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from . import views




urlpatterns = [
    url('sessions/', views.SessionListView.as_view(), name='sessions'),
    url('start-session/', views.SessionCreate.as_view(), name='start-session'),
    #path('v1/',include(router.urls), name='sessionList'),
    url('testsessions/', views.SessionViewSet.as_view(), name='SessionTypesViewSet'),
    url('testsessions/<pk>/', views.SessionEditViewSet.as_view(), name='testSession'),
    url('sessiontypes/', views.SessionTypesViewSet.as_view(), name='sessionTypes'),
    url('stop-session/<int:session_id>/', views.stop_session, name='stop-session')
]  