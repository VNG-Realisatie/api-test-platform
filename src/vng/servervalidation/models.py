import json

from django.db import models
from django.utils import timezone
from django.conf import settings

from ordered_model.models import OrderedModel
from django.core.files.base import ContentFile

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


class PostmanTest(OrderedModel):
    order_with_respect_to = 'test_scenario'
    test_scenario = models.ForeignKey(TestScenario)
    validation_file = models.FileField(settings.MEDIA_FOLDER_FILES['test_scenario'])

    def __str__(self):
        return '{} {}'.format(self.test_scenario, self.validation_file)


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


class PostmanTestResult(models.Model):

    postman_test = models.ForeignKey(PostmanTest)
    log = models.FileField(settings.MEDIA_FOLDER_FILES['servervalidation_log'], blank=True, null=True, default=None)
    log_json = models.FileField(settings.MEDIA_FOLDER_FILES['servervalidation_log'], blank=True, null=True, default=None)
    server_run = models.ForeignKey(ServerRun)
    status = models.CharField(max_length=10, choices=choices.ResultChoices.choices, default=None, null=True)

    def display_log(self):
        if self.log:
            with open(self.log.path) as fp:
                return fp.read().replace('\n', '<br>')

    def display_log_json(self):
        if self.log:
            with open(self.log_json.path) as fp:
                return fp.read()

    def get_json_obj(self):
        with open(self.log_json.path) as jfile:
            f = json.load(jfile)
            res = f['run']['executions']
            for execution in res:
                req = execution['request']['url']
                url = '.'.join(req['host'])
                path = ''
                if 'path' in req:
                    path = '/'.join(req['path'])
                req['url'] = '{}://{}/{}'.format(req['protocol'], url, path)

        return res

    def save_json(self, filename, file):
        content = json.load(file)
        try:
            for execution in content['run']['executions']:
                del execution['response']['stream']['data']
        except:
            pass
        self.log_json.save(filename, ContentFile(json.dumps(content)))

    def get_outcome_html(self):
        with open(self.log.path) as f:
            for line in f:
                if 'Total failed tests' in line:
                    if '0' in line:
                        return choices.ResultChoices.success
        return choices.ResultChoices.failed


class Endpoint(models.Model):

    test_scenario_url = models.ForeignKey(TestScenarioUrl)
    url = models.URLField(max_length=200)
    jwt = models.TextField(null=True, default=None)
    server_run = models.ForeignKey(ServerRun)
