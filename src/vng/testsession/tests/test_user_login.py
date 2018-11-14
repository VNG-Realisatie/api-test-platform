from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
import factory
from ..models import SessionType, Session

class TestCaseBase(WebTest):

    def test(self):
        call = self.app.get('/')
        self.assertEqual(call.status,'200 OK')


class TestAuth(WebTest):

    def test(self):
        call = self.app.get('/session/sessions/')
        self.assertNotEqual(call.status,'200 OK')
        call = self.app.get('/session/sessions/',user='test')
        self.assertEqual(call.status,'200 OK')
        
class SessionTypeFactory(Dmf):

    class Meta:
        model = SessionType

    name = factory.sequence(lambda n:'testype %d' % n)
    docker_image = 'di'


class SessionCreation(WebTest):
    
    def test(self):
        SessionTypeFactory()
        call = self.app.get('/session/start-session/',user='admin')
        self.app.reset()
        form = call.forms[1]
        form['session_type'].select(value='1')
        response = form.submit(expect_errors=True)

    def test2(self):
        SessionTypeFactory()
        call = self.app.get('/session/start-session/',user='admin')
        form = call.forms[1]
        form['session_type'].select(value='1')
        response = form.submit()
        call = self.app.get('/session/sessions/',user='admin')
        assert 'no session' not in str(call.body)

    def test3(self):
        SessionTypeFactory()
        call = self.app.get('/session/start-session/',user='admin')
        form = call.forms[1]
        response = form.submit(expect_errors=True)

    def test4(self):
        SessionTypeFactory()
        call = self.app.get('/session/start-session/',user='admin')
        form = call.forms[1]
        form['session_type'].force_value('2')
        response = form.submit(expect_errors=True)
        

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
