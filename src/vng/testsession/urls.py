from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url
from . import views

urlpatterns = [
    url('sessions/', views.SessionListView.as_view(), name='sessions'),
    url('start-session/', views.SessionCreate.as_view(), name='start_session'),
    url('stop-session/<int:session_id>/', views.stop_session, name='stop_session')
]  