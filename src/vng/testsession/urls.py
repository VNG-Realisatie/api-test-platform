from django.urls import path,re_path
from . import views

urlpatterns = [
    path('sessions/', views.SessionListView.as_view(), name='sessions'),
] 