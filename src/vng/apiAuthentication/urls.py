from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.urls import path,re_path

urlpatterns = [
    path('',include('rest_auth.urls'),name='login-rest'),
]