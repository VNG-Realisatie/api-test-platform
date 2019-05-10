
from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url

from . import api_views, apps
from ..utils.schema import schema_view

app_name = apps.AppConfig.__name__


router = routers.DefaultRouter()
router.register('provider-run', api_views.ServerRunViewSet, base_name='api_server-run')
router.register('provider-run-shield', api_views.ResultServerViewShield, base_name='api_server-run-shield')


urlpatterns = [
    url('schema', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    url('provider-run/(?P<pk>[0-9]+)/trigger', api_views.TriggerServerRunView.as_view({'put': 'update'}), name='provider'),
    url('provider-run/(?P<pk>[0-9]+)/result', api_views.ResultServerView.as_view(), name='provider_result'),
    url('', include((router.urls, 'server-api'), namespace='provider')),
]
