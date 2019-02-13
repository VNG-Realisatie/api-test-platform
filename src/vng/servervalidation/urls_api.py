
from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from django.conf.urls import url

from . import views, api_views, apps
from ..utils.schema_view import schema_view

app_name = apps.AppConfig.__name__


router = routers.DefaultRouter()
router.register('server-run', api_views.ServerRunViewSet, base_name='api_server-run')


urlpatterns = [
    url(r'^schema/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    url(r'^', include((router.urls, 'session-api'), namespace='session')),
]
