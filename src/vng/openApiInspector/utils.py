import requests
import re

OpenAPIv = 3.0


def openAPIInspector(url):
    resp = requests.get(url)
    data = resp.json()
    version = float(data['openapi'][:3])
    return version
