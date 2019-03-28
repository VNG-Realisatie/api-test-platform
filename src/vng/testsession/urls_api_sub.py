from django.conf.urls import include, url
from django.contrib.auth.decorators import login_required

from rest_framework import routers, serializers, viewsets

from . import views
from . import api_views, apps

app_name = apps.AppConfig.__name__

urlpatterns = [
    url(r'^runtest/(?P<relative_url>[-\w|/|.]*)$', api_views.RunTest.as_view(), name='run_test'),
]
