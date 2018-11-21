import subprocess
import logging
import re

logger = logging.getLogger(__name__)


def runcommand(COMMAND):
    print('running the COMMAND: {}'.format(COMMAND))
    subp = subprocess.Popen(COMMAND, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    err =subp.stderr.read()
    if len(err) > 1:
        logger.error(err)
    return (subp.stdout.read(), err) 

class ContainerManagerHelper():

    def __init__(self, cluster, zone="europe-west4-a"):
        self.cluster = cluster
        self.zone = zone
    
    def poolList(self):
        COMMAND = "gcloud container node-pools list --cluster={} --zone={}".format(self.cluster,self.zone)
        res = runcommand(COMMAND)
        return res
    
    def createPool(self,pool_name):
        COMMAND = "gcloud container node-pools create {} --cluster={} --zone={}".format(pool_name, self.cluster, self.zone)
        res = runcommand(COMMAND)
        return res

    def deletePool(self,pool_name):
        COMMAND = "gcloud container node-pools delete {} --cluster={} --zone={} -q".format(pool_name, self.cluster, self.zone)
        res = runcommand(COMMAND)
        return res


class K8S():

    def deploy(self, app_name, image, port=None):
        if port is None:
            COMMAND = 'kubectl run {} --image={} --env="DOMAIN=cluster"'.format(app_name, image)
        else:
            COMMAND = 'kubectl run {} --image={} --port={} --env="DOMAIN=cluster"'.format(app_name, image, port)
        res = runcommand(COMMAND)
        return res
    
    def delete(self, app_name):
        COMMAND = 'kubectl delete -n default deployment {}'.format(app_name)
        res1 = runcommand(COMMAND)
        return res1 

    def status(self, app_name):
        NAMES = ['namespace','desired','current','up-to-date','available','age']
        COMMAND = 'kubectl get deployments --all-namespaces'
        res1 = runcommand(COMMAND)[0].decode('utf-8')
        reg = re.search(r'(\S*) *{} *(\S*) *(\S*) *(\S*) *(\S*) *(\S*) *\n'.format(app_name), res1, re.M)
        if reg:
            status = {'app_name': app_name}
            for i,name in zip(range(1,7),NAMES):
                status[name]=reg.group(i)
            return status
        else:
            return None
