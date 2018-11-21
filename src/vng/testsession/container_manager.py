import subprocess

def runCommand(command):
    print('running the command: {}'.format(command))
    subp = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return (subp.stdout.read(), subp.stderr.read()) 

class ContainerManagerHelper():

    def __init__(self, cluster, zone="europe-west4-a"):
        self.cluster = cluster
        self.zone = zone
    
    def poolList(self):
        command = "gcloud container node-pools list --cluster={} --zone={}".format(self.cluster,self.zone)
        res = runCommand(command)
        return res
    
    def createPool(self,pool_name):
        command = "gcloud container node-pools create {} --cluster={} --zone={}".format(pool_name, self.cluster, self.zone)
        res = runCommand(command)
        return res

    def deletePool(self,pool_name):
        command = "gcloud container node-pools delete {} --cluster={} --zone={} -q".format(pool_name, self.cluster, self.zone)
        res = runCommand(command)
        return res


class K8S():

    def deploy(self, app_name, image, port=None):
        if port is None:
            command = 'kubectl run {} --image={} --env="DOMAIN=cluster"'.format(app_name, image)
        else:
            command = 'kubectl run {} --image={} --port={} --env="DOMAIN=cluster"'.format(app_name, image, port)
        res = runCommand(command)
        return res
    
    def delete(self, app_name):
        command = 'kubectl delete -n default deployment {}'.format(app_name)
        res1 = runCommand(command)
        #load_balance = 'gcloud compute forwardin-rules list'
        #res2 = runCommand(load_balance)
        return res1 #res2)
