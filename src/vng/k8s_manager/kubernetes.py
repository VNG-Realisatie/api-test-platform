import uuid
import yaml
import os
import random
from django.conf import settings

from ..utils.commands import run_command


class AutoAssigner(object):

    def __init__(self, *args, **kwargs):
        for k, v in kwargs.items():
            setattr(self, k, v)


class KubernetesObject(AutoAssigner):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.create_config = [
            'kubectl',
            'create',
            '-f'
        ]

    def requirements(self):
        pass

    def execute(self):
        self.requirements()
        filename = str(uuid.uuid4())
        self.dump(filename)
        self.create_config.append(filename)
        run_command(self.create_config)
        if not settings.DEBUG:
            os.remove(filename)
        return self

    def dump(self, filename):
        content = self.get_content()
        with open(filename, 'w') as out_file:
            out_file.write(yaml.dump(content))


class Ingress(KubernetesObject):
    '''
    name, paths
    paths: [{
        'path': '/api',
        'serviceName': 'serviceName'
        'servicePort': 8080,
    }]
    '''

    apiVersion = 'extensions/v1beta1'
    kind = 'Ingress'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.apply_config = [
            'kubectl',
            'apply',
            '-f'
        ]

    def execute(self):
        # TODO: use differnet commands
        self.requirements()
        filename = str(uuid.uuid4())
        self.dump(filename)
        self.create_config.append(filename)
        res = run_command(self.create_config)
        if not settings.DEBUG:
            os.remove(filename)
        return self

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
                    'http': {
                        'paths': _paths
                    }
                }]
            }
        }


class Container(AutoAssigner):
    '''
    name, image, public_port, private_port, variables
    '''

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.cpu_limit = '0.1'

    def exec_config(self):
        if len(self.variables) != 0:
            cm = ConfigMap(
                name='{}-configmap-{}'.format(self.name, random.randint(0, 1000)),
                labels=self.name,
                container=self
            )
            cm.execute()
            self.configMap = cm
        if hasattr(self, 'data'):
            data = ConfigMapData(
                name='{}-configmap-data-{}'.format(self.name, random.randint(0, 1000)),
                labels=self.name,
                container=self
            )
            data.execute()
            self.configMap_data = data

    def get_content(self):
        base = {
            'name': self.name,
            'image': self.image,
            'imagePullPolicy': 'Always',
            'resources': {
                'limits': {
                    'cpu': self.cpu_limit
                },
                'requests': {
                    'cpu': str(float(self.cpu_limit) / 2)
                }
            }
        }
        if self.public_port and self.private_port:
            base['ports'] = [{
                'containerPort': self.private_port
            }]
        if hasattr(self, 'configMap'):
            base['envFrom'] = [{
                'configMapRef': {
                    'name': self.configMap.name
                }
            }]
        if hasattr(self, 'configMap_data'):
            base['volumeMounts'] = [{
                'name': self.configMap_data.get_volume_name(),
                'mountPath': '/docker-entrypoint-initdb.d',
            }]
        if hasattr(self, 'command'):
            base['command'] = self.command
        if hasattr(self, 'command'):
            base['command'] = self.command[0]
            if len(self.command) != 0:
                base['args'] = self.command[1:]
        return base


class Service(KubernetesObject):
    '''
    name, app, containers
    '''

    apiVersion = 'v1'
    kind = 'Service'

    def get_base(self):
        return {
            'apiVersion': self.apiVersion,
            'kind': self.kind,
            'metadata': {
                'name': self.name,
                'labels': {
                    'app': self.app
                }
            },
            'spec': {
                'selector': {
                    'app': self.app
                }
            }
        }

    def get_content(self):
        base = self.get_base()
        base['spec']['ports'] = [{
            'name': 'port-{}'.format(c.private_port),
            'port': c.private_port
        } for c in self.containers]
        return base


class NodePort(Service):
    '''
    name, app, containers
    '''

    apiVersion = 'v1'
    kind = 'Service'

    def get_content(self):
        service = super().get_base()
        service['spec']['type'] = 'NodePort'
        service['ports'] = [{
            'name': 'http',
            'ports': c.public_port,
            'targetPort': c.private_port
        }for c in self.containers]
        return service


class ClusterIP(Service):
    '''
    name, app, containers
    '''

    apiVersion = 'v1'
    kind = 'Service'

    def get_content(self):
        service = super().get_base()
        service['spec']['type'] = 'ClusterIP'
        service['ports'] = [{
            'name': 'http',
            'ports': c.public_port,
            'targetPort': c.private_port
        }for c in self.containers]
        return service


class LoadBalancer(Service):

    def get_content(self):
        service = super().get_base()
        service['spec']['type'] = 'LoadBalancer'
        service['spec']['ports'] = [{
            'protocol': 'TCP',
            'name': 'httpport{}'.format(c.public_port),
            'port': c.public_port,
            'targetPort': c.private_port
        }for c in self.containers if c.public_port]
        return service


class Deployment(KubernetesObject):
    '''
    name, labels, containers
    '''

    kind = 'Deployment'
    apiVersion = 'extensions/v1beta1'

    def requirements(self):
        for c in self.containers:
            c.exec_config()

        to_service = [c for c in self.containers if c.public_port and c.private_port]

        if len(to_service) != 0:
            NodePort(
                name='{}-nodePort'.format(self.name),
                app=self.name,
                containers=to_service
            )

    def get_content(self):
        res = {
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
        to_volumize = [c for c in self.containers if hasattr(c, 'data')]
        res['spec']['template']['spec']['volumes'] = [c.configMap_data.get_volume() for c in to_volumize]
        return res


class ConfigMap(KubernetesObject):
    '''
    name, labels, container
    '''
    apiVersion = 'v1'
    kind = 'ConfigMap'

    def get_content(self):

        name = self.name
        res = {
            'apiVersion': self.apiVersion,
            'kind': self.kind,
            'metadata': {
                'name': name,
                'labels': {
                    'app': self.labels
                }
            },
        }
        if hasattr(self.container, 'variables') and len(self.container.variables) != 0:
            res['data'] = self.container.variables
        if hasattr(self.container, 'data'):
            res['data'] = self.container.variables
        return res


class ConfigMapData(ConfigMap):

    def get_volume_name(self):
        return '{}-volume'.format(self.container.name)

    def get_volume(self):
        return {
            'name': self.get_volume_name(),
            'configMap': {
                'name': self.name
            }
        }

    def get_content(self):

        name = self.name
        res = {
            'apiVersion': self.apiVersion,
            'kind': self.kind,
            'metadata': {
                'name': name,
                'labels': {
                    'app': self.labels
                }
            },
        }
        if hasattr(self.container, 'data'):
            res['data'] = {self.container.filename: '\n '.join(self.container.data)}
        return res
