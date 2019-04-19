from django.conf.urls import url
from . import views, apps

app_name = apps.AppConfig.__name__

urlpatterns = [
    url('edit', views.UserUpdateView.as_view(), name='edit_profile'),
]
