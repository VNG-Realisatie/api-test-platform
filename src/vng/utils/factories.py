import factory
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User


class UserFactory(Dmf):

    class Meta:
        model = User

    username = factory.Sequence(lambda n: 'test{}'.format(n))
    password = factory.PostGenerationMethodCall('set_password', 'password')
