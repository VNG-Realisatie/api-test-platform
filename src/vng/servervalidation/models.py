from django.db import models
from vng.accounts.models import User
from django.utils import timezone

class TestScenario(models.Model):
    name = name = models.CharField(max_length=200, unique=True)
    validation_file = models.FileField('/uploaded_files')

    def __str__(self):
        return self.name

class ServerRun(models.Model):
    test_scenario = models.ForeignKey(TestScenario, on_delete=models.SET_NULL, null=True)
    api_endpoint = models.URLField(max_length=200, blank=True, null=True, default=None)
    started = models.DateTimeField(default=timezone.now)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    stopped = models.DateTimeField(null=True, default=None, blank=True)
