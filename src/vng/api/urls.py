from drf_yasg import openapi
from drf_yasg.views import get_schema_view
from rest_framework import permissions

from django.conf.urls import include, url

schema_view = get_schema_view(
    openapi.Info(
        title="Snippets API",
        default_version='v1',
        description="Test description",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email="contact@snippets.local"),
        license=openapi.License(name="BSD License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

app_name = 'api'
urlpatterns = [

    url(r'schema/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    url(r'^testsessions/', include('vng.testsession.urls_api', namespace='session')),
    url(r'^servervalidation/', include('vng.servervalidation.urls_api', namespace='server')),
]
