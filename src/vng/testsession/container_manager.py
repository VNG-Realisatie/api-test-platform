import json

from ..utils.commands import run_command


class K8S():

    def __init__(self):
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
        run_command(set_zone)
        run_command(set_project)

    def deploy(self, app_name, image, port=8080, access_port=8080):
        create_cluster = [
            'gcloud',
            'container',
            'clusters',
            'create',
            'test-sessions',
            '--num-nodes=1',
        ]
        get_credentials = [
            'gcloud',
            'container',
            'clusters',
            'get-credentials',
            'test-sessions',
        ]
        deploy_image = [
            'kubectl',
            'run',
            '{}'.format(app_name),
            '--image={}'.format(image),
            '--port={}'.format(port),
        ]
        load_balancer = [
            'kubectl',
            'expose',
            'deployment',
            '{}'.format(app_name),
            '--type=LoadBalancer',
            '--port={}'.format(access_port),
            '--target-port={}'.format(port)
        ]

        # Create a general cluster (will error if it already exists)
        run_command(create_cluster)

        # Get the credentials to use kubectl for the correct cluster
        run_command(get_credentials)

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
