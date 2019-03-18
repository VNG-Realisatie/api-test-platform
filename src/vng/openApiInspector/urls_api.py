
from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url

from . import api_views, apps

app_name = apps.AppConfig.__name__

urlpatterns = [
    url('openAPIinspector', api_views.OpenApiInspectionAPIView.as_view(), name='openAPIinspection'),
]
