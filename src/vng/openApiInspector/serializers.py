from rest_framework import serializers


class OpenApiInspectionSerializer(serializers.Serializer):
    url = serializers.URLField()


class OpenApiInspectionResponseSerializer(serializers.Serializer):
    version = serializers.IntegerField()
    satisfied = serializers.BooleanField()
