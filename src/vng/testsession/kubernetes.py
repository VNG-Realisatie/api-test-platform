import uuid
import yaml

from ..utils.commands import run_command


class AutoAssigner(object):

    def __init__(self, *args, **kwargs):
        for k, v in kwargs:
            setattr(self, k, v)


class KubernetesObject(AutoAssigner):

    create_config = [
        'kubectl',
        'create',
        '-f'
    ]

    def execute(self):
        filename = uuid.uuid4()
        self.dump(filename)
        self.create_config.append(str(filename))
        run_command(self.create_config)

    def dump(self, filename):
        content = self.get_content()
        with open(filename, 'w') as out_file:
            out_file.write(yaml.dump(content))


class Ingress(KubernetesObject):
    '''
    '''

    apiVersion = 'extensions/v1beta1'
    kind = 'Ingress'

    def get_content(self):
        _paths = []
        for p in self.paths:
            _paths.append({
                'path': p['path'],
                'backend': {
                    'serviceName': p['serviceName'],
                    'servicePort': p['servicePort']
                }
            })

        return {
            'apiVersion': self.apiVersion,
            'kind': self.kind,
            'metadata': {
                'name': self.name,
            },
            'spec': {
                'rules': [{
                    'http': _paths
                }]
            }
        }


class Container(AutoAssigner):
    '''
    name, image, public_port, private_port, variables
    '''

    def get_content(self):
        base = {
            'name': self.name,
            'image': self.image
        }
        if hasattr(self, 'command'):
            base['command'] = self.command
        return base


class Service(KubernetesObject):
    '''
    name, labels, public_port, private_port,
    '''

    apiVersion = 'v1'
    kind = 'Service'

    def get_content(self):
        return {
            'apiVersion': self.apiVersion,
            'kind': self.kind,
            'metadata': {
                'name': self.name,
                'labels': {
                    'app': self.labels
                }
            },
            'spec': {
                'type': 'NodePort',
                'ports': {
                    'ports': self.public_port,
                    'targetPort': self.private_port
                }
            }
        }


class Deployment(KubernetesObject):
    '''
    name, labels, containers
    '''

    kind = 'Deployment'
    apiVersion = 'extensions/v1beta1'

    def get_content(self):
        return {
            'apiVersion': self.apiVersion,
            'kind': self.kind,
            'metadata': {
                'name': self.name,
            },
            'spec': {
                'replicas': 1,
                'template': {
                    'metadata': {
                        'name': self.name,
                        'labels': {
                            'app': self.labels
                        }
                    },
                    'spec': {
                        'containers': [c.get_content() for c in self.containers]
                    }
                }
            }
        }


class ConfigMap(KubernetesObject):
    '''
    name, labels, data
    '''
    apiVersion = 'v1'
    kind = 'configMap'

    def get_content(self):
        return {
            'apiVersion': self.apiVersion,
            'kind': self.kind,
            'metadata': {
                'name': self.name,
                'labels': {
                    'app': self.labels
                }
            },
            'data': self.data
        }
