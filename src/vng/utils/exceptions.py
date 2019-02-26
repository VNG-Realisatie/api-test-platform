import json
from rest_framework.exceptions import PermissionDenied
from rest_framework import status


class Error400(PermissionDenied):
    status_code = status.HTTP_400_BAD_REQUEST
    default_detail = "Custom Exception Message"
    default_code = 'invalid'

    def __init__(self, detail, api=False, status_code=None):
        self.detail = detail
        if api:
            self.detail = json.dumps({
                "error": detail
            })
        if status_code is not None:
            self.status_code = status_code
