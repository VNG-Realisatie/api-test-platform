import os

from django.apps import AppConfig
from django.conf import settings


class TestsessionConfig(AppConfig):
    name = 'vng.testsession'

    def ready(self):
        pass
