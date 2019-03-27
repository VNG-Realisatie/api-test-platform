import requests
import re

OpenAPIv = 3.0


def openAPIInspector(url):
    resp = requests.get(url)
    data = resp.json()
    try:
        version = float(data['openapi'][:3])
    except Exception as e:
        version = 0
    return version
