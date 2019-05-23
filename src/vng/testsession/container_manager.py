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
        self.app_name = app_name

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
        with open('kubernetes/general-service.yaml', 'r') as infile:
            service = yaml.safe_load(infile)
            service['metadata']['name'] = self.app_name
            service['spec']['selector']['app'] = self.app_name
            service['spec']['ports'][0]['port'] = in_port
            service['spec']['ports'][0]['targetPort'] = in_port
        with open('kubernetes/{}'.format(filename), 'w') as outfile:
            outfile.write(yaml.dump(service))
        create_config = [
            'kubectl',
            'create',
            '-f',
            'kubernetes/{}'.format(filename)
        ]
        run_command(create_config)
        return filename

    def deploy_postgres_no_persistent(self, cluster):
        if self.db_deployed:
            return
        create_config = [
            'kubectl',
            'create',
            '-f',
            'postgres-configmap.yaml'
        ]
        create_deployment = [
            'kubectl',
            'create',
            '-f',
            'postgres-deployment.yaml'
        ]
        create_service = [
            'kubectl',
            'create',
            '-f',
            'postgres-service.yaml'
        ]
        run_command(create_config)
        run_command(create_deployment)
        run_command(create_service)
        # fetching the IP
        resource = self.fetch_resource('svc postgres')
        self.db_deployed = True
        return resource['spec']['clusterIp'], resource['spec']['ports']['nodePort']

    def deploy(self, app_name, image, port=8080, access_port=8080, env_variables={}):
        deploy_image = [
            'kubectl',
            'run',
            '{}'.format(app_name),
            '--image={}'.format(image),
            '--port={}'.format(port),
        ]
        for k, v in env_variables.items():
            deploy_image.append('--env="{}={}"'.format(k, v))
        load_balancer = [
            'kubectl',
            'expose',
            'deployment',
            '{}'.format(app_name),
            '--type=LoadBalancer',
            '--port={}'.format(access_port),
            '--target-port={}'.format(port)
        ]

        # Create a workload with pods
        run_command(deploy_image)

        # Create a load balancer to expose the cluster
        run_command(load_balancer)

    def delete(self, app_name):
        delete_service = [
            'kubectl',
            'delete',
            'service',
            '{}'.format(app_name),
        ]
        clean_up = [
            'kubectl',
            'delete',
            'deployment',
            '{}'.format(app_name),
        ]

        # Delete the load balancer
        run_command(delete_service)

        # Delete the workload
        run_command(clean_up)

    def get_pods_status(self, app_name):
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
            if metadata and app_name in metadata.get('name'):
                status = item.get('status').get('containerStatuses')[0]
                if item.get('status').get('phase') == 'Pending':
                    return False, status.get('state').get('waiting').get('message')
                elif item.get('status').get('phase') == 'Running':
                    return True, None
        raise Exception('Application {} not found in the deployed cluster'.format(app_name))

    def status(self, app_name):
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
            if metadata and metadata.get('name') == app_name:
                ip_list = item.get('status').get('loadBalancer').get('ingress')
                if ip_list:
                    return ip_list[0].get('ip')
        raise Exception('Application {} not found in the deployed cluster'.format(app_name))

    def exec(self, app_name, command):
        exec_command = [
            'kubectl',
            'exec',
            app_name,
            *command
        ]
        run_command(exec_command)
