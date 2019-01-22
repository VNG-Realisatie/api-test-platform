from django.db import models
from django.utils import timezone
from django.conf import settings

from vng.accounts.models import User

from ..utils import choices


class TestScenario(models.Model):
    name = models.CharField(max_length=200, unique=True)

    def __str__(self):
        return self.name


class TestScenarioUrl(models.Model):
    name = models.CharField(max_length=200, unique=True)
    test_scenario = models.ForeignKey(TestScenario)

    def __str__(self):
        return '{} {}'.format(self.name, self.test_scenario)


class PostmanTest(models.Model):
    test_scenario = models.ForeignKey(TestScenario)
    validation_file = models.FileField(settings.MEDIA_FOLDER_FILES['test_scenario'])


class ServerRun(models.Model):

    test_scenario = models.ForeignKey(TestScenario, on_delete=models.SET_NULL, null=True)
    started = models.DateTimeField(default=timezone.now)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    stopped = models.DateTimeField(null=True, default=None, blank=True)
    status = models.CharField(max_length=10, choices=choices.StatusChoices.choices, default=choices.StatusChoices.starting)
    client_id = models.TextField()
    secret = models.TextField()

    def __str__(self):
        return "{} - {}".format(self.started, self.status)

    def is_stopped(self):
        return self.status == choices.StatusChoices.stopped

    def get_fields_no_file(self):
        '''
        Used in server-run_detail
        '''
        res = []
        for field in self._meta.fields:
            if field.get_internal_type() not in ('FileField',):
                res.append((field.name, field.value_to_string(self)))
        return res

    def display_log(self):
        if self.log:
            with open(self.log.path) as fp:
                return fp.read().replace('\n', '<br>')


class PostmanTestResult(models.Model):
    postman_test = models.ForeignKey(PostmanTest)
    log = models.FileField(settings.MEDIA_FOLDER_FILES['servervalidation_log'], blank=True, null=True, default=None)
    server_run = models.ForeignKey(ServerRun)


class Endpoint(models.Model):
    test_scenario_url = models.ForeignKey(TestScenarioUrl)
    url = models.URLField(max_length=200)
    jwt = models.TextField(null=True, default=None)
    server_run = models.ForeignKey(ServerRun)
