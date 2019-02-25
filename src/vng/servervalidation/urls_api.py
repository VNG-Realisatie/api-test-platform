
from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url

from . import views, api_views, apps
from ..utils.schema import schema_view

app_name = apps.AppConfig.__name__


router = routers.DefaultRouter()
router.register('provider-run', api_views.ServerRunViewSet, base_name='api_server-run')


urlpatterns = [
    url('schema', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    url('provider-run/(?P<pk>[0-9]+)/result', api_views.ResultServerView.as_view(), name='session'),
    url('', include((router.urls, 'session-api'), namespace='session')),
]
