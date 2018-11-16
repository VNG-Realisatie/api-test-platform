from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url

urlpatterns = [
    url('',include('rest_auth.urls'),name='login-rest'),
]