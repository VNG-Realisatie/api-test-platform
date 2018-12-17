import json
import uuid

from django.conf import settings
from django.core.files import File
from django.db import models
from django.utils import timezone

from ordered_model.models import OrderedModel

from vng.accounts.models import User

from ..utils import choices


class SessionType(models.Model):

    name = models.CharField(max_length=200, unique=True)
    docker_image = models.CharField(max_length=200, blank=True, null=True, default=None)

    def __str__(self):
        return self.name


class Scenario(models.Model):

    standard = models.CharField(max_length=200, null=True)
    role = models.CharField(max_length=200, null=True)
    application = models.CharField(max_length=200, null=True)
    version = models.CharField(max_length=200, null=True)
    created = models.DateTimeField(default=timezone.now)
    performed = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return '{}-{}'.format(self.application, self.version)


class ScenarioCase(OrderedModel):

    url = models.CharField(max_length=200)
    HTTP_method = models.CharField(max_length=20, choices=choices.HTTPMethodChoiches.choices, default=choices.HTTPMethodChoiches.GET)
    result = models.CharField(max_length=20, choices=choices.HTTPCallChoiches.choices, default=choices.HTTPCallChoiches.not_called)
    scenario = models.ForeignKey(Scenario, on_delete=models.SET_NULL, null=True, default=None)

    def __str__(self):
        if self.scenario:
            return '{} - {} - {}'.format(self.scenario.application, self.url, self.result)
        else:
            return '{} - {}'.format(self.url, self.result)

    def is_success(self):
        return self.result == choices.HTTPCallChoiches.success

    def is_failed(self):
        return self.result == choices.HTTPCallChoiches.failed

    def is_not_called(self):
        return self.result == choices.HTTPCallChoiches.not_called


class TestSession(models.Model):
    name = name = models.CharField(max_length=200, unique=True)
    test_file = models.FileField(settings.MEDIA_FOLDER_FILES['test_session'])

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
    port = models.PositiveIntegerField(default=8080)
    exposed_api = models.CharField(max_length=200, blank=True, null=True, default=None)
    scenario = models.ForeignKey(Scenario, blank=True, null=True, default=None)
    test = models.ForeignKey(TestSession, blank=True, null=True, default=None)
    test_result = models.FileField(settings.MEDIA_FOLDER_FILES['testsession_log'], blank=True, null=True, default=None)
    json_result = models.TextField(blank=True, null=True, default=None)

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

    def save_test(self, file):
        name_file = str(uuid.uuid4())
        django_file = File(file)
        self.test_result.save(name_file, django_file)

    def save_test_json(self, file):
        text = file.read().replace('\n', '')
        self.json_result = text

    def display_test_result(self):
        if self.test_result:
            with open(self.test_result.path) as fp:
                return fp.read().replace('\n', '<br>')


class SessionLog(models.Model):

    date = models.DateTimeField(default=timezone.now)
    request = models.CharField(max_length=20000, null=True)
    response = models.CharField(max_length=20000, null=True)
    session = models.ForeignKey(Session, on_delete=models.SET_NULL, null=True)
