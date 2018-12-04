from django.utils import timezone
import collections
import json
from django.test import TestCase
from django_webtest import WebTest
from .test_factory import ServerRunFactory, TestScenarioFactory


def get_object(r):
    return json.loads(r.decode('utf-8'))


class RetrieveCreationTest(WebTest):

    def setUp(self):
        TestScenarioFactory()
        ServerRunFactory()

    def get_user_key(self):
        call = self.app.post('/api/auth/login/',params=collections.OrderedDict([
            ('username', 'test'),
            ('password', 'pippopippo')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        return head

    def test_unauthenticated_user(self):
        call = self.app.get('/api/v1/sessiontypes', expect_errors=True)

    def test_creation_server_run(self):
        server_run = {
            'session_type': 1,
            'started': str(timezone.now()),
            'api_endpoint': 'http://google.com'
        }
        call = self.app.post('/api/v1/server-run/', server_run, headers=self.get_user_key())


    def test_retrieve_server_run(self):
        server_run = {
            'session_type': 1,
            'started': str(timezone.now()),
            'api_endpoint': 'http://google.com'
        }
        call = self.app.post('/api/v1/server-run/', server_run, headers=self.get_user_key())
        parsed = get_object(call.body)
        call = self.app.get('/api/v1/server-run/{}'.format(parsed['pk']), headers=self.get_user_key())

    def test_data_integrity(self):
        fake_pk = 999
        server_run = {
            'pk': fake_pk,
            'session_type': 1,
            'started': str(timezone.now()),
            'api_endpoint': 'http://google.com'
        }
        call = self.app.post('/api/v1/server-run/', server_run, headers=self.get_user_key())
        parsed = get_object(call.body)
        self.assertNotEqual(parsed['pk'], fake_pk)




    def test_creation_server_run_auth(self):
        server_run = {
            'session_type': 1,
            'started': str(timezone.now()),
            'api_endpoint': 'http://google.com'
        }
        call = self.app.post('/api/v1/server-run/', server_run, expect_errors=True)


