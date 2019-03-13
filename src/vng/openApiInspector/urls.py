from django.conf.urls import url
from django.contrib.auth.decorators import login_required
from django.views.generic import TemplateView

from . import views, apps

app_name = apps.AppConfig.__name__

urlpatterns = [
    url('openapi-inspection_result', TemplateView.as_view(
        template_name="openApiInspector/openapi-inspection_result.html"), name='openapi-inspection_result'),
    url('openapi-inspection', views.OpenApiInspection.as_view(), name='openapi-inspection'),
]
