from vng.accounts.models import User
from django.db import models

class Session_type(models.Model):
    name = models.CharField(max_length=200, unique=True)
    docker_image = models.CharField(max_length=200)

    def __str__(self):
        return self.name


class Session(models.Model):
    status_choiches = [
        ('1','starting'),
        ('2','running'),
        ('3','stopped')
        ]
    type_session = models.ForeignKey(Session_type, on_delete=models.SET_NULL,null=True)
    started = models.DateTimeField()
    stopped = models.DateTimeField(null=True,blank=True)
    status = models.CharField(max_length=10,choices=status_choiches)
    user = models.ForeignKey(User, on_delete=models.SET_NULL,null=True)
    api_endpoint = models.URLField(max_length=200)

    def __str__(self):
        if self.user:
            return "{} - {}".format(self.type_session,self.user.username)
        else:
            return "{}".format(self.type_session)