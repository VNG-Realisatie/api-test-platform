from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.urls import path,re_path
from . import views



router=routers.DefaultRouter()
router.register(r'testsessions', views.SessionViewSet, 'Session')

urlpatterns = [
    path('sessions/', views.SessionListView.as_view(), name='sessions'),
    path('start-session/', views.SessionCreate.as_view(), name='start-session'),
    path('v1/',include(router.urls), name='sessionList'),
] 