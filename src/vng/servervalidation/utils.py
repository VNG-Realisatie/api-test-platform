import requests

OpenAPIv = 2.0


def openAPIInspector(url):
    resp = requests.get(url)
    data = resp.json()
    version = float(data['swagger'])
    return version
