from .models import *
from rest_framework import serializers


class TestScenarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestScenario
        fields = ['name', 'validation_file']


class ServerRunSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServerRun
        fields = ['id', 'test_scenario', 'started', 'stopped', 'client_id', 'client_id']
