from vng.accounts.models import User
from django.db import models

class Session_type(models.Model):
    name = models.CharField(max_length=200, unique=True)
    docker_image = models.CharField(max_length=200)


class Session(models.Model):
    status_choiches = [
        ('1','starting'),
        ('2','running'),
        ('3','stopped')
        ]
    started = models.DateTimeField()
    stopped = models.DateTimeField()
    status = models.CharField(max_length=10,choices=status_choiches)
    user = models.ForeignKey(User, on_delete=models.SET_NULL,null=True)
    API_endpoint = models.URLField(max_length=200)