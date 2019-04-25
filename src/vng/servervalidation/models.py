import json
import array
import itertools
import uuid

from datetime import datetime

from django.db import models
from django.utils import timezone
from django.conf import settings

from ordered_model.models import OrderedModel
from django.core.files.base import ContentFile
from filer.fields.file import FilerFileField

from vng.accounts.models import User

from ..utils import choices, postman


class TestScenario(models.Model):

    name = models.CharField('Naam', max_length=200, unique=True)
    authorization = models.CharField('Authorisatie', max_length=20, choices=choices.AuthenticationChoices.choices, default=choices.AuthenticationChoices.jwt)

    def __str__(self):
        return self.name

    def jwt_enabled(self):
        return self.authorization == choices.AuthenticationChoices.jwt

    def no_auth(self):
        return self.authorization == choices.AuthenticationChoices.no_auth

    def custom_header(self):
        return self.authorization == choices.AuthenticationChoices.header


class TestScenarioUrl(models.Model):

    name = models.CharField('Naam', max_length=200)
    test_scenario = models.ForeignKey(TestScenario, on_delete=models.CASCADE)

    def __str__(self):
        return '{} {}'.format(self.name, self.test_scenario)


class PostmanTest(OrderedModel):

    order_with_respect_to = 'test_scenario'
    test_scenario = models.ForeignKey(TestScenario, on_delete=models.CASCADE)
    validation_file = FilerFileField(null=True, blank=True, default=None, on_delete=models.SET_NULL)

    def __str__(self):
        return '{} {}'.format(self.test_scenario, self.validation_file)


class ExpectedPostmanResult(OrderedModel):

    order_with_respect_to = 'postman_test'
    postman_test = models.ForeignKey(PostmanTest, on_delete=models.CASCADE)
    expected_response = models.CharField(max_length=20, choices=choices.HTTPResponseStatus.choices)

    def __str__(self):
        return '{} {}'.format(self.postman_test, self.expected_response)


class ServerRun(models.Model):

    test_scenario = models.ForeignKey(TestScenario, on_delete=models.CASCADE)
    started = models.DateTimeField('Gestart op', default=timezone.now)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    stopped = models.DateTimeField('Gestopt op', null=True, default=None, blank=True)
    status = models.CharField(max_length=20, choices=choices.StatusWithScheduledChoices.choices, default=choices.StatusWithScheduledChoices.starting)
    client_id = models.TextField(default=None, null=True, blank=True)
    secret = models.TextField(default=None, null=True, blank=True)
    percentage_exec = models.IntegerField(default=None, null=True, blank=True)
    status_exec = models.TextField(default=None, null=True, blank=True)
    scheduled = models.BooleanField(default=False)
    uuid = models.UUIDField(default=uuid.uuid4, editable=True)

    def __str__(self):
        return "{} - {}".format(self.started, self.status)

    def is_stopped(self):
        return self.status == choices.StatusChoices.stopped

    def is_running(self):
        return self.status == choices.StatusChoices.running

    def get_execution_result(self):
        ptr_set = self.postmantestresult_set.all()
        if len(ptr_set) == 0:
            success = None
        else:
            success = True
            for ptr in ptr_set:
                if ptr.is_success() == 0:
                    success = None
                elif ptr.is_success() == -1 and success is not None:
                    success = False
        return success


class ServerHeader(models.Model):

    server_run = models.ForeignKey(ServerRun, on_delete=models.CASCADE)
    header_key = models.TextField()
    header_value = models.TextField()


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
        if self.status == choices.ResultChoices.success:
            return 1
        if self.status == choices.ResultChoices.failed:
            return -1
        else:
            return 0

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
        return postman.get_json_obj_file(self.log_json.path)

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
            # In case not all the expected result are specified just look at the response status
            for call, expected in itertools.zip_longest(json_obj['run']['executions'], epr):
                if expected is not None:
                    if str(call['response']['code']) not in expected.expected_response:
                        return choices.ResultChoices.failed
                else:
                    if not postman.get_call_result(call):
                        return choices.ResultChoices.failed
            return choices.ResultChoices.success


class Endpoint(models.Model):

    test_scenario_url = models.ForeignKey(TestScenarioUrl, on_delete=models.CASCADE)
    url = models.URLField(max_length=200)
    jwt = models.TextField(null=True, default=None)
    server_run = models.ForeignKey(ServerRun, on_delete=models.CASCADE)
