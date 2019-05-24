import json
import yaml
import uuid
import os

from ..utils.commands import run_command


class K8S():

    def __init__(self, cluster='test-sessions', app_name=None):
        self.initialized = False
        self.cluster = cluster
        self.db_deployed = False
        self.db_to_deploy = False
        self.app_name = app_name
        self.containers = []
        self.script_folder = os.path.dirname(__file__)

    def initialize(self):
        if self.initialized:
            return
        set_zone = [
            'gcloud',
            'config',
            'set',
            'compute/zone',
            'europe-west4-a'
        ]
        set_project = [
            'gcloud',
            'config',
            'set',
            'core/project',
            'vng-test-platform'
        ]
        create_cluster = [
            'gcloud',
            'container',
            'clusters',
            'create',
            self.cluster,
            '--num-nodes=1',
        ]
        get_credentials = [
            'gcloud',
            'container',
            'clusters',
            'get-credentials',
            self.cluster,
        ]
        run_command(set_zone)
        run_command(set_project)
        # Create a general cluster (will error if it already exists)
        run_command(create_cluster)
        # Get the credentials to use kubectl for the correct cluster
        run_command(get_credentials)

        self.initialized = True

    def fetch_resource(self, resource):
        fetch = [
            'kubectl',
            'get',
            resource,
            '--output=json'
        ]
        res = run_command(fetch).decode('utf-8')
        return json.loads(res)

    def create_service(self, in_port, out_port):
        filename = uuid.uuid4()
        with open(os.path.join(self.script_folder, 'kubernetes/general-service.yaml'), 'r') as infile:
            service = yaml.safe_load(infile)
            service['metadata']['name'] = self.app_name
            service['spec']['selector']['app'] = self.app_name
            service['spec']['ports'][0]['port'] = in_port
            service['spec']['ports'][0]['targetPort'] = in_port
        with open(os.path.join(self.script_folder, 'kubernetes/{}'.format(filename)), 'w') as outfile:
            outfile.write(yaml.dump(service))
        create_config = [
            'kubectl',
            'create',
            '-f',
            os.path.join(self.script_folder, 'kubernetes/{}'.format(filename))
        ]
        run_command(create_config)
        return filename

    def deploy_postgres_no_persistent_lazy(self, db_name='postgres', db_user='postgres', db_pwd='k8spwd'):
        if self.db_deployed:
            return
        else:
            self.db_name = db_name
            self.db_user = db_user
            self.db_pwd = db_pwd
            self.containers.append((
                0,
                'mdillon/postgis:11', None, None, {
                    'POSTGRES_DB': db_name,
                    'POSTGRES_USER': db_user,
                    'POSTGRES_PASSWORD': db_pwd
                }
            ))

    def create_configmap(self, name, variables, i):
        filename = uuid.uuid4()
        config_file_path = 'kubernetes/general-configmap.yaml'
        with open(os.path.join(self.script_folder, config_file_path), 'r') as infile:
            config = yaml.safe_load(infile)
            name = '{}-{}-{}'.format(self.app_name, 'config', i)
            config['metadata']['name'] = name
            config['metadata']['labels']['app'] = self.app_name
            config['data'] = variables
        with open(os.path.join(self.script_folder, 'kubernetes/{}'.format(filename)), 'w') as outfile:
            outfile.write(yaml.dump(config))
        create_config = [
            'kubectl',
            'create',
            '-f',
            os.path.join(self.script_folder, 'kubernetes/{}'.format(filename))
        ]
        run_command(create_config)
        # TODO: remove file afterward
        return name

    def flush(self):
        filename = uuid.uuid4()

        with open(os.path.join(self.script_folder, 'kubernetes/general-deployment.yaml'), 'r') as infile:
            deploy = yaml.safe_load(infile)
            deploy['metadata']['name'] = self.app_name
            deploy['spec']['template']['metadata']['labels']['app'] = self.app_name
            deploy['spec']['template']['spec']['containers'] = []
            for i, (id, image, in_port, out_port, env) in enumerate(self.containers):
                # Create ConfigMap object in order to pass the variable to the deployment
                if len(env) != 0:
                    name = self.create_configmap(image, env, i)
                container = {
                    'name': '{}-{}'.format(self.app_name, id),
                    'image': image,
                    'imagePullPolicy': "IfNotPresent",
                    'ports': [{
                        'containerPort': 8080
                    }],
                }
                # Link the ConfigMap to the deployment object
                if len(env) != 0:
                    container['envFrom'] = [{
                        'configMapRef': {
                            'name': name
                        }
                    }]
                args_vars = []

                if len(args_vars) != 0:
                    args = []
                    for k, v in args_vars.items():
                        args.append('"{}={}"'.format(k, v))
                    container['args'] = args
                deploy['spec']['template']['spec']['containers'].append(container)

        with open(os.path.join(self.script_folder, 'kubernetes/{}'.format(filename)), 'w') as outfile:
            outfile.write(yaml.dump(deploy))
        create_config = [
            'kubectl',
            'create',
            '-f',
            os.path.join(self.script_folder, 'kubernetes/{}'.format(filename))
        ]
        run_command(create_config)

        for id, image, in_port, out_port, env in self.containers:
            if not (in_port is None or out_port is None):
                self.create_service(in_port, out_port)
            # Enable external access via LoadBalancer
            load_balancer = [
                'kubectl',
                'expose',
                'deployment',
                self.app_name,
                '--type=LoadBalancer',
                '--port={}'.format(8080),
                '--target-port={}'.format(8000),
                '--name={}-loadbalancer-{}'.format(self.app_name, id)
            ]
        run_command(load_balancer)

    def deploy(self, id, image, port=8080, access_port=8080, env_variables={}):
        self.containers.append((
            id, image, port, access_port, env_variables
        ))

    def delete(self):
        clean_up = [
            'kubectl',
            'delete',
            'deployment',
            '{}'.format(self.app_name),
        ]

        # Delete the workload
        run_command(clean_up)
        # TODO: remove unused resources, remember that Kubernetes has a Garbage Collector integrated

    def get_pods_status(self):
        # TODO: filter through the command the resource
        status_command = [
            'kubectl',
            'get',
            'pods',
            '--output=json'
        ]
        res1 = run_command(status_command).decode('utf-8')
        pods = json.loads(res1)
        items = pods.get('items')
        for item in items:
            metadata = item.get('metadata')
            if metadata and self.app_name in metadata.get('name'):
                status = item.get('status').get('containerStatuses')[0]
                if item.get('status').get('phase') == 'Pending':
                    return False, status.get('state').get('waiting').get('message')
                elif item.get('status').get('phase') == 'Running':
                    return True, None
        raise Exception('Application {} not found in the deployed cluster'.format(self.app_name))

    def status(self, id):
        # TODO: filter through the command the resource
        status_command = [
            'kubectl',
            'get',
            'service',
            '--output=json'
        ]
        res1 = run_command(status_command).decode('utf-8')
        services = json.loads(res1)
        items = services.get('items')
        for item in items:
            metadata = item.get('metadata')
            if metadata and metadata.get('name') == '{}-loadbalancer-{}'.format(self.app_name, id):
                ip_list = item.get('status').get('loadBalancer').get('ingress')
                if ip_list:
                    return ip_list[0].get('ip')
        raise Exception('Application {} not found in the deployed cluster'.format(self.app_name))

    def exec(self, app_name, command):
        exec_command = [
            'kubectl',
            'exec',
            app_name,
            *command
        ]
        run_command(exec_command)
