from vng.accounts.models import User
from django.db import models
from djchoices import DjangoChoices, ChoiceItem

class SessionType(models.Model):
    name = models.CharField(max_length=200, unique=True)
    docker_image = models.CharField(max_length=200)

    def __str__(self):
        return self.name


class Session(models.Model):
    class StatusChoices(DjangoChoices):
        starting = ChoiceItem("1")
        running = ChoiceItem("2")
        stopped = ChoiceItem("3")

    session_type = models.ForeignKey(SessionType, on_delete=models.SET_NULL,null=True)
    started = models.DateTimeField()
    stopped = models.DateTimeField(null=True,blank=True)
    status = models.CharField(max_length=10,choices=StatusChoices.choices,default=StatusChoices.starting)
    user = models.ForeignKey(User, on_delete=models.SET_NULL,null=True)
    api_endpoint = models.URLField(max_length=200)

    def __str__(self):
        if self.user:
            return "{} - {}".format(self.type_session,self.user.username)
        else:
            return "{}".format(self.type_session)