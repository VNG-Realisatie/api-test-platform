from .models import *
from rest_framework import serializers

class SessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Session
        fields = ('session_type','started','stopped','status','api_endpoint')

class SessionTypesSerializer(serializers.ModelSerializer):
    class Meta:
        model = SessionType
        fields = '__all__'