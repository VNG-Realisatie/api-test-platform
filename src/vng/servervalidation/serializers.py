from .models import *
from rest_framework import serializers

class TestScenarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestScenario
        fields = '__all__'

class ServerRunSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServerRun
        fields = ['test_scenario', 'api_endpoint', 'started', 'stopped']
