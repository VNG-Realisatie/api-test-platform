import requests
import re

OpenAPIv = 3.0


def openAPIInspector(url):
    resp = requests.get(url)
    try:
        data = resp.json()
        version = float(data['openapi'][:3])
    except Exception as e:
        re.search('version: (([0-9]|.)+)', resp.text)
        v = re.group(1)
        if len(v.split('.') > 1):
            version = float('{}.{}'.format(v.split[0], v.split[1]))
    return version
