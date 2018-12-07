import uuid
from django.db import models
from django.utils import timezone
from django.core.files import File
from vng.accounts.models import User
from ..utils import choices


class SessionType(models.Model):
    name = models.CharField(max_length=200, unique=True)
    docker_image = models.CharField(max_length=200)

    def __str__(self):
        return self.name


class Session(models.Model):

    name = models.CharField(max_length=20, unique=True, null=True)
    session_type = models.ForeignKey(SessionType, on_delete=models.SET_NULL, null=True)
    started = models.DateTimeField(default=timezone.now)
    stopped = models.DateTimeField(null=True, blank=True)
    status = models.CharField(max_length=10, choices=choices.StatusChoices.choices, default=choices.StatusChoices.starting)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    api_endpoint = models.URLField(max_length=200, blank=True, null=True, default=None)
    exposed_api = models.CharField(max_length=200, unique=True, null=True)

    def create_empty_log(self):
        filename = str(uuid.uuid4())
        file = open("/files/log/{}".format(filename))
        self.log.save(filename, File(file))

    def __str__(self):
        if self.user:
            return "{} - {}".format(self.session_type, self.user.username)
        else:
            return "{}".format(self.session_type)

    def is_stopped(self):
        return self.status == choices.StatusChoices.stopped

    def is_running(self):
        return self.status == choices.StatusChoices.running

    def is_starting(self):
        return self.status == choices.StatusChoices.starting


class SessionLog(models.Model):
    date = models.DateTimeField(default=timezone.now)
    request = models.CharField(max_length=20000, null=True)
    response = models.CharField(max_length=20000, null=True)
    session = models.ForeignKey(Session, on_delete=models.SET_NULL, null=True)
