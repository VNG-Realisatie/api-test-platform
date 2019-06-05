import uuid
import yaml
import os

from ..utils.commands import run_command


class AutoAssigner(object):

    def __init__(self, *args, **kwargs):
        for k, v in kwargs.items():
            setattr(self, k, v)


class KubernetesObject(AutoAssigner):

    create_config = [
        'kubectl',
        'create',
        '-f'
    ]

    def requirements(self):
        pass

    def execute(self):
        self.requirements()
        filename = uuid.uuid4()
        self.dump(str(filename))
        self.create_config.append(str(filename))
        run_command(self.create_config)
        os.remove(filename)

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

    def exec_config(self):
        if len(self.variables) != 0:
            cm = ConfigMap(
                name='{}-configMap'.format(self.name),
                labels=self.name,
                container=self
            )
            cm.execute()
            self.configMap = cm

    def get_content(self):
        base = {
            'name': self.name,
            'image': self.image,
            'imagePullPolicy': 'ifNotPresent'
        }
        if hasattr(self, 'configMap'):
            base['envFrom'] = [{
                'configMapRef': {
                    'name': self.configMap.name
                }
            }]
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
                'selector': {
                }
            }
        }


class NodePort(Service):
    '''
    name, app, containers
    '''

    apiVersion = 'v1'
    kind = 'Service'

    def get_content(self):
        service = super().get_content()
        service['spec']['selector']['app'] = self.app
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
        service = super().get_content()
        service['spec']['selector']['app'] = self.app
        service['spec']['type'] = 'ClusterIP'
        service['ports'] = [{
            'name': 'http',
            'ports': c.public_port,
            'targetPort': c.private_port
        }for c in self.containers]
        return service


class LoadBalancer(Service):

    def get_content(self):
        service = super().get_content()
        service['spec']['selector']['app'] = self.app
        service['spec']['type'] = 'LoadBalancer'
        service['ports'] = [{
            'name': 'http',
            'ports': c.public_port,
            'targetPort': c.private_port
        }for c in self.containers]


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

        NodePort(
            name='{}-nodePort'.format(self.name),
            app=self.name,
            containers=to_service
        )

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
    name, labels, container
    '''
    apiVersion = 'v1'
    kind = 'configMap'

    '''
    def execute(self):
        if len(self.container.variables) != 0:
            super().get_content()
    '''

    def get_content(self):

        name = self.name
        self.container.configMap = name
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
        return res
