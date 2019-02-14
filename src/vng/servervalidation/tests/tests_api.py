import collections
import json

from django.utils import timezone
from django.test import TestCase
from django_webtest import WebTest

from vng.accounts.models import User

from .factories import ServerRunFactory, TestScenarioFactory, TestScenarioUrlFactory


def get_object(r):
    return json.loads(r.decode('utf-8'))


def get_username():
    return User.objects.all().first().username


class RetrieveCreationTest(WebTest):

    def setUp(self):
        self.test_scenario = TestScenarioFactory()
        self.server = ServerRunFactory()
        tsu1 = TestScenarioUrlFactory()
        tsu2 = TestScenarioUrlFactory()
        tsu1.test_scenario = self.test_scenario
        tsu2.test_scenario = self.test_scenario
        tsu1.save()
        tsu2.save()
        self.server_run = {
            'test_scenario': self.test_scenario.id,
            'client_id': 'client_id_field',
            'secret': 'secret_field',
            'endpoints': [
                {
                    'name': tsu1.name,
                    'url': 'https://google.com',
                }, {
                    'name': tsu2.name,
                    'url': 'https://google2.com',
                }
            ]
        }

    def get_user_key(self):
        call = self.app.post('/api/auth/login/', params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        return head

    def test_unauthenticated_user(self):
        call = self.app.get('/api/v1/sessiontypes', expect_errors=True)

    def test_creation_server_run(self):
        call = self.app.post_json('/api/v1/server-run/', self.server_run, headers=self.get_user_key())

    def test_retrieve_server_run(self):
        headers = self.get_user_key()
        call = self.app.post_json('/api/v1/server-run/', self.server_run, headers=headers)
        parsed = get_object(call.body)
        call = self.app.get('/api/v1/server-run/{}'.format(parsed['id']), headers=headers)

    def test_data_integrity(self):
        fake_pk = 999

        call = self.app.post_json('/api/v1/server-run/', self.server_run, headers=self.get_user_key())
        parsed = get_object(call.body)
        self.assertNotEqual(parsed['id'], fake_pk)

    def test_creation_server_run_auth(self):

        call = self.app.post_json('/api/v1/server-run/', self.server_run, expect_errors=True)
