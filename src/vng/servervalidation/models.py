import json
import array

from datetime import datetime

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

    name = models.CharField(max_length=200)
    test_scenario = models.ForeignKey(TestScenario, on_delete=models.CASCADE)

    def __str__(self):
        return '{} {}'.format(self.name, self.test_scenario)


class PostmanTest(OrderedModel):
    order_with_respect_to = 'test_scenario'
    test_scenario = models.ForeignKey(TestScenario, on_delete=models.CASCADE)
    validation_file = models.FileField(settings.MEDIA_FOLDER_FILES['test_scenario'])

    def __str__(self):
        return '{} {}'.format(self.test_scenario, self.validation_file)


class ExpectedPostmanResult(OrderedModel):
    order_with_respect_to = 'postman_test'
    postman_test = models.ForeignKey(PostmanTest, on_delete=models.CASCADE)
    expected_response = models.CharField(max_length=20, choices=choices.HTTPResponseStatus.choices)

    def __str__(self):
        return '{} {}'.format(self.postman_test, self.expected_response)


class ServerRun(models.Model):

    test_scenario = models.ForeignKey(TestScenario, on_delete=models.SET_NULL, null=True)
    started = models.DateTimeField(default=timezone.now)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    stopped = models.DateTimeField(null=True, default=None, blank=True)
    status = models.CharField(max_length=20, choices=choices.StatusChoices.choices, default=choices.StatusChoices.starting)
    client_id = models.TextField()
    secret = models.TextField()
    percentage_exec = models.IntegerField(default=None, null=True, blank=True)
    status_exec = models.TextField(default=None, null=True, blank=True)

    def __str__(self):
        return "{} - {}".format(self.started, self.status)

    def is_stopped(self):
        return self.status == choices.StatusChoices.stopped

    def is_running(self):
        return self.status == choices.StatusChoices.running

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

    postman_test = models.ForeignKey(PostmanTest, on_delete=models.CASCADE)
    log = models.FileField(settings.MEDIA_FOLDER_FILES['servervalidation_log'], blank=True, null=True, default=None)
    log_json = models.FileField(settings.MEDIA_FOLDER_FILES['servervalidation_log'], blank=True, null=True, default=None)
    server_run = models.ForeignKey(ServerRun, on_delete=models.CASCADE)
    status = models.CharField(max_length=10, choices=choices.ResultChoices.choices, default=None, null=True)

    def __str__(self):
        if self.status is None:
            return '{}'.format(self.pk)
        else:
            return '{} - {}'.format(self.pk, self.status)

    def is_success(self):
        if self.status is None:
            return 0
        if self.status == choices.ResultChoices.success:
            return 1
        else:
            return -1

    def display_log(self):
        if self.log:
            with open(self.log.path) as fp:
                return fp.read().replace('\n', '<br>')

    def display_log_json(self):
        if self.log:
            with open(self.log_json.path) as fp:
                return fp.read()

    def get_json_obj_info(self):
        if hasattr(self, 'status_saved'):
            return self.status_saved

        with open(self.log_json.path) as jfile:
            f = json.load(jfile)
            del f['run']['executions']
            a = int(f['run']['timings']['started'])
            f['run']['timings']['started'] = (datetime.utcfromtimestamp(int(f['run']['timings']['started']) / 1000)
                                              .strftime('%I:%M %p'))

            self.status_saved = f
            return f

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
                if 'protocol' in req:
                    req['url'] = '{}://{}/{}'.format(req['protocol'], url, path)
                else:
                    req['url'] = '{}/{}'.format(url, path)

        return res

    def save_json(self, filename, file):
        content = json.load(file)
        for execution in content['run']['executions']:
            try:
                buffer = execution['response']['stream']['data']
                del execution['response']['stream']
                execution['response']['body'] = json.loads(array.array('B', buffer).tostring())
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

    def get_outcome_json(self):
        with open(self.log_json.path) as jfile:
            json_obj = json.load(jfile)
            if json_obj['run']['failures'] != []:
                return choices.ResultChoices.failed
            epr = ExpectedPostmanResult.objects.filter(postman_test=self.postman_test).order_by('order')
            for call, expected in zip(json_obj['run']['executions'], epr):
                if call['response']['code'] not in epr.expected_response:
                    return choices.ResultChoices.failed
            return choices.ResultChoices.success


class Endpoint(models.Model):

    test_scenario_url = models.ForeignKey(TestScenarioUrl, on_delete=models.CASCADE)
    url = models.URLField(max_length=200)
    jwt = models.TextField(null=True, default=None)
    server_run = models.ForeignKey(ServerRun, on_delete=models.CASCADE)
