import collections
import json
import factory
from django.utils import timezone
from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
import factory
from ..models import SessionType, Session
from vng.accounts.models import User

def get_object(r):
    return json.loads(r.decode('utf-8'))


class SessionTypeFactory(Dmf):

    class Meta:
        model = SessionType

    name = factory.sequence(lambda n:'testype %d' % n)
    docker_image = 'di'


class SessionFactory(Dmf):

    class Meta:
        model = Session

    session_type = 1
    started = timezone.now()
    status = Session.StatusChoices.starting
    user = 1
    api_endpoint = 'http://google.com'

class UserFactory(Dmf):

    class Meta:
        model = User

    username = 'test'
    password = factory.PostGenerationMethodCall('set_password', 'pippopippo')

class RetrieveSessionType(WebTest):
    
    def setUp(self):
        SessionTypeFactory()

    def test(self):
        call = self.app.get('/api/v1/sessiontypes/',user='admin')
        t = get_object(call.body)
        self.assertEqual(t[0]['id'],1)
    
    def test2(self):
        for i in range(10):
            SessionTypeFactory()
        call = self.app.get('/api/v1/sessiontypes/',user='admin')
        t = json.loads(call.body.decode('utf-8'))
        self.assertEqual(t[9]['id'],10)

class AuthorizationTests(WebTest):
  
    def setUp(self):
        UserFactory()

    def test(self):
        self.app.get('/session/v1/testsessions/',expect_errors=True)

    def test2(self):
        print(User.objects.all()[0].password)
        call = self.app.post('/api/v1/login/',params=collections.OrderedDict([
            ('username', 'test'),
            ('password', 'pippopippo')]))
        print(call.body.decode('utf-8'))
        t = get_object(call.body)
    
    def test3(self):
        call = self.app.post('/api/v1/login',{
            'username': 'test',
            'password': 'wrong'
        },expect_errors=True)
        
class CreationAndDeletion(WebTest):

    def test(self):
        pass


    
        


