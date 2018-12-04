from django.db import models
from django.utils import timezone
from cms.models.pluginmodel import CMSPlugin
from djchoices import DjangoChoices, ChoiceItem
from vng.accounts.models import User


class TextPluginModel(CMSPlugin):
    text = models.CharField(max_length=20000, unique=True)


class SessionType(models.Model):
    name = models.CharField(max_length=200, unique=True)
    docker_image = models.CharField(max_length=200)

    def __str__(self):
        return self.name


class Session(models.Model):
    class StatusChoices(DjangoChoices):
        starting = ChoiceItem("starting")
        running = ChoiceItem("running")
        stopped = ChoiceItem("stopped")

    name = models.CharField(max_length=20, unique=True, null=True)
    session_type = models.ForeignKey(SessionType, on_delete=models.SET_NULL, null=True)
    started = models.DateTimeField(default=timezone.now)
    stopped = models.DateTimeField(null=True, blank=True)
    status = models.CharField(max_length=10, choices=StatusChoices.choices, default=StatusChoices.starting)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    api_endpoint = models.URLField(max_length=200, blank=True, null=True, default=None)
   # kubernet_endpoint = models.URLField(max_length=200, blank=True, null=True, default=None)

    def __str__(self):
        if self.user:
            return "{} - {}".format(self.session_type, self.user.username)
        else:
            return "{}".format(self.session_type)

    def is_stopped(self):
        return self.status is self.StatusChoices.stopped
