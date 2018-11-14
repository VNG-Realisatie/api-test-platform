from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.urls import path,re_path
from . import views




urlpatterns = [
    path('sessions/', views.SessionListView.as_view(), name='sessions'),
    path('start-session/', views.SessionCreate.as_view(), name='start-session'),
    #path('v1/',include(router.urls), name='sessionList'),
    path('v1/testsessions', views.SessionViewSet.as_view(), name='SessionTypesViewSet'),
    path('v1/testsession/<pk>', views.SessionViewSet.as_view(), name='testSession'),
    path('v1/sessiontypes', views.SessionTypesViewSet.as_view(), name='sessionTypes'),
    path('v1/',include('rest_auth.urls'),name='login-rest'),
    path('stop-session/<int:session_id>', views.stop_session, name='stop-session')
] 