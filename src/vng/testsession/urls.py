from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.urls import path,re_path
from . import views




urlpatterns = [
    path('sessions/', views.SessionListView.as_view(), name='sessions'),
    path('start-session/', views.SessionCreate.as_view(), name='start-session'),
    #path('v1/',include(router.urls), name='sessionList'),
    path('testsessions/', views.SessionViewSet.as_view(), name='SessionTypesViewSet'),
    path('testsessions/<pk>/', views.SessionEditViewSet.as_view(), name='testSession'),
    path('sessiontypes/', views.SessionTypesViewSet.as_view(), name='sessionTypes'),
    path('stop-session/<int:session_id>/', views.stop_session, name='stop-session')
] 