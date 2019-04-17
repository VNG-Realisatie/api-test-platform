import json
import uuid
import re
import time

from django.conf import settings
from django.core.validators import RegexValidator
from django.core.files import File
from django.db import models
from django.utils import timezone
from django.urls import reverse

from ordered_model.models import OrderedModel

from filer.fields.file import FilerFileField

from vng.accounts.models import User

from ..utils import choices, postman


class SessionType(models.Model):

    name = models.CharField('Naam', max_length=200, unique=True)
    standard = models.CharField('Standaard', max_length=200, null=True)
    role = models.CharField('Rol', max_length=200, null=True)
    application = models.CharField('Applicatie', max_length=200, null=True)
    version = models.CharField('Versie', max_length=200, null=True)
    authentication = models.CharField(max_length=20, default=choices.AuthenticationChoices.no_auth, choices=choices.AuthenticationChoices.choices)
    client_id = models.TextField(default=None, null=True, blank=True)
    secret = models.TextField(default=None, null=True, blank=True)
    header = models.TextField(default=None, null=True, blank=True)

    class Meta:
        verbose_name = 'Sessie type'
        verbose_name_plural = 'Sessie type'

    def __str__(self):
        return self.name


class InjectHeader(models.Model):

    session_type = models.ForeignKey(SessionType, on_delete=models.CASCADE)
    key = models.CharField(max_length=200)
    value = models.TextField()

    class Meta:
        unique_together = ('session_type', 'key')


class TestSession(models.Model):

    test_result = models.FileField(settings.MEDIA_FOLDER_FILES['testsession_log'], blank=True, null=True, default=None)
    json_result = models.TextField(blank=True, null=True, default=None)

    class Meta:
        verbose_name = 'Test Sessie'
        verbose_name_plural = 'Test Sessie'

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

    def is_success_test(self):
        if self.json_result is not None:
            return postman.get_outcome_json(self.json_result) == choices.ResultChoices.success

    def get_json_obj(self):
        return postman.get_json_obj(self.json_result)


class VNGEndpoint(models.Model):

    port = models.PositiveIntegerField(default=8080)
    url = models.URLField(max_length=200, blank=True, null=True, default=None)
    name = models.CharField(
        max_length=200,
        validators=[
            RegexValidator(
                regex='^[^ ]*$',
                message='The name cannot contain spaces',
                code='Invalid_name'
            )
        ]
    )
    docker_image = models.CharField(max_length=200, blank=True, null=True, default=None)
    session_type = models.ForeignKey(SessionType, on_delete=models.CASCADE)
    test_file = FilerFileField(null=True, blank=True, default=None, on_delete=models.SET_NULL)

    def __str__(self):
        # To show the session type when adding a scenario case
        return self.name + " ({})".format(self.session_type)


class ScenarioCase(OrderedModel):

    url = models.CharField(max_length=200, help_text='''
    URL pattern that will be compared
    with the request and eventually matched.
    Wildcards can be added, e.g. '/test/{uuid}/stop'
    will match the URL '/test/c5429dcc-6955-4e22-9832-08d52205f633/stop'.
    ''')
    http_method = models.CharField(max_length=20, choices=choices.HTTPMethodChoiches.choices, default=choices.HTTPMethodChoiches.GET)
    vng_endpoint = models.ForeignKey(VNGEndpoint, on_delete=models.CASCADE)

    order_with_respect_to = 'vng_endpoint'

    def __str__(self):
        return '{} - {}'.format(self.http_method, self.url)


class QueryParamsScenario(models.Model):

    scenario_case = models.ForeignKey(ScenarioCase, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    expected_value = models.CharField(max_length=50, default='*')

    def __str__(self):
        if self.expected_value:
            return '{} - {}: {}'.format(self.scenario_case, self.name, self.expected_value)
        else:
            return '{} {}'.format(self.scenario_case, self.name)


class Session(models.Model):

    name = models.CharField('Naam', max_length=30, unique=True, null=True)
    session_type = models.ForeignKey(SessionType, verbose_name='Sessie type', on_delete=models.CASCADE)
    started = models.DateTimeField('Gestart op', default=timezone.now)
    stopped = models.DateTimeField('Gestopt op', null=True, blank=True)
    status = models.CharField(max_length=20, choices=choices.StatusChoices.choices, default=choices.StatusChoices.starting)
    user = models.ForeignKey(User, verbose_name='Gebruiker', on_delete=models.SET_NULL, null=True)
    build_version = models.TextField(blank=True, null=True, default=None)
    error_message = models.TextField(blank=True, null=True, default=None)
    deploy_status = models.TextField(blank=True, null=True, default=None)
    deploy_percentage = models.IntegerField(default=None, null=True, blank=True)
    sandbox = models.BooleanField(default=False)

    class Meta:
        verbose_name = 'Sessie'
        verbose_name_plural = 'Sessie'

    @staticmethod
    def assign_name(id):
        return "s{}{}".format(str(id), str(time.time()).replace('.', '-'))

    def __str__(self):
        if self.user:
            return "{} - {} - #{}".format(self.session_type, self.user.username, str(self.id))
        else:
            return "{} - #{}".format(self.session_type, str(self.id))

    def get_absolute_request_url(self, request):
        test_session_url = 'https://{}{}'.format(request.get_host(),
                                                 reverse('testsession:session_log', args=[self.id]))
        return test_session_url

    def is_stopped(self):
        return self.status == choices.StatusChoices.stopped

    def is_running(self):
        return self.status == choices.StatusChoices.running

    def is_starting(self):
        return self.status == choices.StatusChoices.starting

    def is_shutting_down(self):
        return self.status == choices.StatusChoices.shutting_down


class ExposedUrl(models.Model):

    subdomain = models.CharField(max_length=200, unique=True, null=True)
    session = models.ForeignKey(Session, on_delete=models.CASCADE)
    vng_endpoint = models.ForeignKey(VNGEndpoint, on_delete=models.CASCADE)
    test_session = models.ForeignKey(TestSession, blank=True, null=True, default=None, on_delete=models.CASCADE)
    docker_url = models.CharField(max_length=200, blank=True, null=True, default=None)

    def get_uuid_url(self):
        return re.search('([^/]+)', self.subdomain).group(1)

    def __str__(self):
        return '{} {}'.format(self.session, self.vng_endpoint)


class SessionLog(models.Model):

    date = models.DateTimeField(default=timezone.now)
    session = models.ForeignKey(Session, on_delete=models.SET_NULL, null=True)
    request = models.TextField(blank=True, null=True, default=None)
    response = models.TextField(blank=True, null=True, default=None)
    response_status = models.PositiveIntegerField(blank=True, null=True, default=None)

    def __str__(self):
        return '{} - {} - {}'.format(str(self.date), str(self.session),
                                     str(self.response_status))

    def request_path(self):
        return json.loads(self.request)['request']['path']

    def request_headers(self):
        return json.loads(self.request)['request']['header']

    def request_body(self):
        try:
            return json.loads(self.request)['request']['body']
        except:
            return ""

    def response_body(self):
        try:
            return json.loads(self.response)['response']['body']
        except:
            return ""


class Report(models.Model):

    class Meta:
        unique_together = ('scenario_case', 'session_log')

    scenario_case = models.ForeignKey(ScenarioCase, on_delete=models.CASCADE)
    session_log = models.ForeignKey(SessionLog, on_delete=models.CASCADE)
    result = models.CharField(max_length=20, choices=choices.HTTPCallChoiches.choices, default=choices.HTTPCallChoiches.not_called)

    def is_success(self):
        return self.result == choices.HTTPCallChoiches.success

    def is_failed(self):
        return self.result == choices.HTTPCallChoiches.failed

    def is_not_called(self):
        return self.result == choices.HTTPCallChoiches.not_called

    def __str__(self):
        return 'Case: {} - Log: {} - Result: {}'.format(self.scenario_case, self.session_log, self.result)
