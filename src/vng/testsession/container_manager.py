from ..utils.commands import run_command
import re


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

    def deploy(self, app_name, image, port=8080):
        create_cluster = [
            'gcloud',
            'container',
            'clusters',
            'create',
            app_name,
            '--num-nodes=1',
        ]
        get_credentials = [
            'gcloud',
            'container',
            'clusters',
            'get-credentials',
            app_name,
        ]
        deploy_image = [
            'kubectl',
            'run',
            '{}'.format(app_name),
            '--image={}'.format(image),
            '--port',
            '{}'.format(port),
        ]
        auto_balancer = [
            'kubectl',
            'expose',
            'deployment',
            '{}'.format(app_name),
            '--type=LoadBalancer',
        ]
        run_command(create_cluster)
        run_command(get_credentials)
        run_command(deploy_image)
        run_command(auto_balancer)

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

        res1 = run_command(delete_service)
        res1 = run_command(clean_up)

    def status(self, app_name):
        NAMES = ['type', 'cluster_ip', 'external_ip', 'port', 'age']
        staus_command = [
            'kubectl',
            'get',
            'service',
        ]
        res1 = run_command(staus_command).decode('utf-8')

        # extract the information from the output of the command
        reg = re.search(r'.*{} *(\S+) *(\S+) *(\S+) *(\S+) *(\S+).*\n'.format(app_name), res1, re.M)
        if reg:
            status = {'app_name': app_name}
            for i, name in zip(range(1, len(NAMES) + 1), NAMES):
                status[name] = reg.group(i)

            # extract the port from the format 8080:32741/TCP
            port = re.match('[0-9]+', status['port']).group(0)
            status['port'] = port
            return status
        else:
            raise Exception('Application {} not found in the deployed cluster'.format(app_name))
