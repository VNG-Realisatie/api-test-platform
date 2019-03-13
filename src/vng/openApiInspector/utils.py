import requests
import re

OpenAPIv = 2.0


def openAPIInspector(url):
    resp = requests.get(url)
    try:
        data = resp.json()
        version = float(data['swagger'])
    except:
        re.search('version: (([0-9]|.)+)', data)
        v = re.group(1)
        if len(v.split('.') > 1):
            version = float('{}.{}'.format(v.split[0], v.split[1]))
    return version
