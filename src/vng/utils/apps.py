from django.apps import AppConfig


class UtilsConfig(AppConfig):
    name = 'vng.utils'

    def ready(self):
        from . import checks  # noqa
