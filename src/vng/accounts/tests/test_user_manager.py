from django_webtest import WebTest

from django.test import TestCase
from django.urls import reverse

from ..models import User
from ...utils.factories import UserFactory


class UserManagerTests(TestCase):

    def test_create_superuser(self):
        user = User.objects.create_superuser('god', 'god@heaven.com', 'praisejebus')
        self.assertIsNotNone(user.pk)
        self.assertTrue(user.is_staff)
        self.assertTrue(user.is_superuser)
        self.assertEqual(user.username, 'god')
        self.assertEqual(user.email, 'god@heaven.com')
        self.assertTrue(user.check_password('praisejebus'))
        self.assertNotEqual(user.password, 'praisejebus')

    def test_create_user(self):
        user = User.objects.create_user('infidel')
        self.assertIsNotNone(user.pk)
        self.assertFalse(user.is_superuser)
        self.assertFalse(user.is_staff)
        self.assertFalse(user.has_usable_password())


class TestUserUpdate(WebTest):

    def setUp(self):
        self.user = UserFactory()

    def test_update_info(self):
        call = self.app.get(reverse('user_edit:edit_profile'), user=self.user)
        form = call.forms[0]
        form['first_name'] = 'dummyname'
        form['last_name'] = 'dummylastname'
        form['email'] = 'dummyemail@gmail.com'
        call = form.submit().follow()
        self.assertIn('dummyname', call.text)
        self.assertIn('dummylastname', call.text)
        self.assertIn('dummyemail@gmail.com', call.text)

        user = User.objects.get(id=self.user.id)
        self.assertEqual(user.first_name, 'dummyname')
        self.assertEqual(user.last_name, 'dummylastname')
        self.assertEqual(user.email, 'dummyemail@gmail.com')
