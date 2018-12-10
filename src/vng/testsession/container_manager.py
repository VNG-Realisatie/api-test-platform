from ..utils.commands import run_command
import re


class ContainerManagerHelper():
    '''
    Not used yet but it can be used in order to get a feedback by the server
    '''

    def __init__(self, cluster, zone="europe-west4-a"):
        self.cluster = cluster
        self.zone = zone

    def poolList(self):
        COMMAND = "gcloud container node-pools list --cluster={} --zone={}".format(self.cluster, self.zone)
        res = run_command(COMMAND)
        return res

    def createPool(self, pool_name):
        COMMAND = "gcloud container node-pools create {} --cluster={} --zone={}".format(pool_name, self.cluster, self.zone)
        res = run_command(COMMAND)
        return res

    def deletePool(self, pool_name):
        COMMAND = "gcloud container node-pools delete {} --cluster={} --zone={} -q".format(pool_name, self.cluster, self.zone)
        res = run_command(COMMAND)
        return res


class K8S():

    def deploy(self, app_name, image, port=None):

        COMMAND = ['kubectl',
                   'run',
                   app_name,
                   '--image=',
                   image,
                   '--env="DOMAIN=cluster"']
        if port is not None:
            COMMAND += [
                'port',
                port
            ]
        res = run_command(COMMAND)
        return res

    def delete(self, app_name):
        COMMAND = 'kubectl delete -n default deployment {}'.format(app_name)
        res1 = run_command(COMMAND)
        return res1

    def status(self, app_name):
        NAMES = ['namespace', 'desired', 'current', 'up-to-date', 'available', 'age']
        COMMAND = ['kubectl',
                   'get',
                   'deployments',
                   '--all-namespaces']
        res1 = run_command(COMMAND)[0].decode('utf-8')
        reg = re.search(r'(\S*) *{} *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *\n'.format(app_name), res1, re.M)
        if reg:
            status = {'app_name': app_name}
            for i, name in zip(range(1, 7), NAMES):
                status[name] = reg.group(i)
            return status
        else:
            return None
