from django.conf.urls import url, include

from . import apps

app_name = apps.AppConfig.__name__

urlpatterns = [
    url('', include('rest_auth.urls'), name='login-rest'),
]
