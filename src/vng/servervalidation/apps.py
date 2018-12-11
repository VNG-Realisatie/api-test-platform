import os

from django.apps import AppConfig
from django.conf import settings

from .newman import NewmanManager


class ServervalidationConfig(AppConfig):
    name = 'vng.servervalidation'

    def create_folder(self, folder):
        if not os.path.exists(folder):
            os.makedirs(folder)

    def ready(self):
        print(NewmanManager.REPORT_FOLDER)
        self.create_folder(NewmanManager.REPORT_FOLDER)
