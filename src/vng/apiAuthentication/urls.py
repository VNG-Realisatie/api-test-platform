from django.conf.urls import url, include

urlpatterns = [
    url('', include('rest_auth.urls'), name='login-rest'),
]
