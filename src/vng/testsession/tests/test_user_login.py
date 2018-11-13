from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
import factory
from rest_framwork import viewsets, generics
from ..models import SessionType, Session

class TestCaseBase(WebTest):

    def test(self):
        index = self.app.get('/')
        assert index.status == '200 OK'


class TestAuth(WebTest):

    def test(self):
        call = self.app.get('/session/sessions/')
        assert call.status != '200 OK'
        call = self.app.get('/session/sessions/',user='test')
        assert call.status == '200 OK'
        
class SessionTypeFactory(Dmf):

    class Meta:
        model = SessionType

    name = factory.sequence(lambda n:'testype %d' % n)
    docker_image = 'di'


class SessionCreation(WebTest):

    def test(self):
        SessionTypeFactory()
        call = self.app.get('/session/start-session/',user='admin')
        form = call.forms[1]
        form['session_type'].select(value='1')
        response = form.submit()
        call = self.app.get('/session/sessions/',user='admin')
        assert 'no session' not in str(call.body)
        

class MultipleSessionCreation(WebTest):

    def test(self):
        n_sess = 10
        for i in range(n_sess):
            SessionTypeFactory()
            call = self.app.get('/session/start-session/',user='admin')
            form = call.forms[1]
            form['session_type'].select(value='1')
            response = form.submit()
        call = self.app.get('/session/sessions/',user='admin')
        assert str(call.body).count('<tr>') == n_sess+1
