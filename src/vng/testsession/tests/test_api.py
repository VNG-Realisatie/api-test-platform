import collections
import json
from django.utils import timezone
from django_webtest import WebTest
from django.urls import reverse
from vng.accounts.models import User
from ..models import SessionType, Session
from .test_factory import SessionTypeFactory, SessionFactory, UserFactory


def get_object(r):
    return json.loads(r.decode('utf-8'))

class RetrieveSessionType(WebTest):
    
    def setUp(self):
        SessionTypeFactory()

    def test_retrieve_single_session_types(self):
        call = self.app.get('/api/v1/sessiontypes/',user='admin')
        t = get_object(call.body)
        self.assertEqual(t[0]['id'],1)
    
    def test_retrieve_multiple_session_types(self):
        for i in range(10):
            SessionTypeFactory()
        call = self.app.get('/api/v1/sessiontypes/',user='admin')
        t = json.loads(call.body.decode('utf-8'))
        self.assertEqual(t[9]['id'],10)

class AuthorizationTests(WebTest):
  
    def setUp(self):
        UserFactory()

    def test_check_unauthenticated_testsessions(self):
        self.app.get('/session/v1/testsessions/',expect_errors=True)

    def test_right_login(self):
        call = self.app.post('/api/auth/login/',params=collections.OrderedDict([
            ('username', 'test'),
            ('password', 'pippopippo')]))
        t = get_object(call.body)
    
    def test_wrong_login(self):
        call = self.app.post('/api/v1/login',{
            'username': 'test',
            'password': 'wrong'
        },expect_errors=True)
        
class CreationAndDeletion(WebTest):

    def setUp(self):
        SessionTypeFactory()
        UserFactory()

    def test_session_creation(self):
        session = {
            'session_type': 1,
            'started': str(timezone.now()),
            'status': Session.StatusChoices.running,
            'api_endpoint': 'http://google.com'
        }
        call = self.app.post('/api/auth/login/',params=collections.OrderedDict([
            ('username', 'test'),
            ('password', 'pippopippo')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        call = self.app.post('/api/v1/testsessions/', session, headers=head)

    def test_session_creation_permission(self):
        Session.objects.all().delete()
        session = {
            'session_type': 1,
            'started': str(timezone.now()),
            'status': Session.StatusChoices.running,
            'api_endpoint': 'http://google.com',
            'user': 1
        }

        call = self.app.post('/api/auth/login/',params=collections.OrderedDict([
            ('username', 'test'),
            ('password', 'pippopippo')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        call = self.app.post('/api/v1/testsessions/', session, headers=head)
        response_parsed = get_object(call.body)
        session = Session.objects.filter(pk=response_parsed['pk'])[0]
        user = User.objects.all()[0]
        print('#######')
        print(session.user)

        print('#######')

        self.assertEqual(session.user.username,user.username)




    
        


