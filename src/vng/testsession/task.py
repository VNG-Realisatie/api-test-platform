import time
import random
import copy

from datetime import timedelta, datetime
from celery.utils.log import get_task_logger

from django.utils.timezone import make_aware

from ..celery.celery import app
from .models import ExposedUrl, Session, TestSession, VNGEndpoint, EnvironmentBoostrap
from ..utils import choices
from ..utils.newman import NewmanManager
from .container_manager import K8S
from .gemma_containers import *
from .kubernetes import *

logger = get_task_logger(__name__)


def get_app_name(session, bind_url):
    return '{}{}'.format(session.name, str(bind_url.pk))


@app.task
def stop_session(session_pk):
    session = Session.objects.get(pk=session_pk)
    if session.status == choices.StatusChoices.stopped:
        return
    run_tests.delay(session.pk)
    eu = ExposedUrl.objects.filter(session=session)
    for e_url in eu:
        if e_url.vng_endpoint.url is None:
            app_name = get_app_name(session, e_url)
            kuber = K8S(app_name=app_name)
            kuber.delete()
    session.status = choices.StatusChoices.stopped
    session.save()


def update_session_status(session, message, percentage=None):
    session.deploy_status = message
    if percentage is not None:
        if percentage >= 100:
            percentage = 100
        session.deploy_percentage = percentage
    session.save()


def align_sessions_data():
    data = K8S().fetch_resource('services')
    for session in Session.objects.all():
        for item in data.get('items'):
            metadata = item.get('metadata')
            if metadata and session.name in metadata.get('name'):
                continue
        session.status = choices.StatusChoices.stopped
        session.save()


@app.task
def purge_sessions():
    align_sessions_data()
    purged = False
    for session in Session.objects.filter(started__lte=make_aware(datetime.now()) - timedelta(days=1)).filter(status=choices.StatusChoices.running):
        purged = True
        stop_session(session.pk)
    return purged


def ZGW_deploy(session):

    # create deployment DB
    db = copy.deepcopy(postgis)
    db.name = 'db-{}'.format(session.name)
    d_db = Deployment(
        name='db-{}'.format(session.name),
        labels='db-{}'.format(session.name),
        containers=[db]
    )
    d_db.execute()
    db_k8s = K8S(app_name='db-{}'.format(session.name))
    k8s = K8S(app_name=session.name)
    for i in range(10):
        time.sleep(3)
        # Visualize the new pod can be not immediate, pooling is the way :(
        try:
            db_IP_address = db_k8s.get_pod_status()['status']['podIP']
            break
        except:
            pass

    # group all the other containers in the same pod
    containers = [
        # copy.deepcopy(NRC),
        # copy.deepcopy(ZTC),
        copy.deepcopy(ZRC),
        # copy.deepcopy(BRC),
        # copy.deepcopy(DRC),
        # copy.deepcopy(AC),
        # copy.deepcopy(rabbitMQ),
        # copy.deepcopy(celery)
    ]
    exposed_urls = []
    for c in containers:
        bind_url = ExposedUrl.objects.create(
            session=session,
            vng_endpoint=VNGEndpoint.objects.filter(session_type=session.session_type).filter(name__icontains=c.name)[0],
            subdomain='{}'.format(int(time.time()) * 100 + random.randint(0, 99)),
            port=c.public_port
        )
        exposed_urls.append(bind_url)
        c.name = '{}-{}'.format(session.name, c.name)
        c.variables['DB_HOST'] = db_IP_address

    deployment = Deployment(
        name=session.name,
        labels=session.name,
        containers=containers
    )
    deployment.execute()

    # Crete the service forwarding the right ports
    lb = LoadBalancer(
        name='{}-loadbalancer'.format(session.name),
        app=session.name,
        containers=containers
    )
    lb.execute()
    ip = external_ip_pooling(k8s)
    for ex in exposed_urls:
        ex.docker_url = ip
        ex.save()


def external_ip_pooling(k8s, n_trial=10):
    for i in range(n_trial):
        time.sleep(10)
        res, message = k8s.get_pod_status_deployment()
        if res:
            break

    for i in range(n_trial):
        time.sleep(10)
        ip = k8s.service_status()
        if ip is not None:
            return ip
    return None


@app.task
def bootstrap_session(session_pk, purged=False):
    '''
    Create all the necessary endpoint and exposes it so they can be used as proxy
    In case there is one or multiple docker images linked, it starts all of them
    '''
    session = Session.objects.get(pk=session_pk)
    if session.session_type.name == 'ZGW':
        ZGW_deploy(session)
        return
    update_session_status(session, 'Verbinding maken met Kubernetes', 1)
    endpoint = VNGEndpoint.objects.filter(session_type=session.session_type)

    k8s = K8S(app_name=session.name)
    # Init of the procedure
    k8s.initialize()
    to_check = []
    external_ports = random.sample(range(9000, 10000), len(endpoint))
    if session.session_type.database:
        k8s.deploy_postgres_no_persistent_lazy()
    for ep in endpoint:
        bind_url = ExposedUrl.objects.create(
            session=session,
            vng_endpoint=ep,
            subdomain='{}'.format(int(time.time()) * 100 + random.randint(0, 99))
        )
        if ep.docker_image:
            to_check.append(bind_url)
            env_var = bind_url.vng_endpoint.environmentalvariables_set.all()
            variables = {v.key: v.value for v in env_var}
            port = external_ports.pop()
            bind_url.port = port
            bind_url.save()
            k8s.deploy(bind_url.pk, ep.docker_image, ep.port, port, env_variables=variables)
    update_session_status(session, 'Docker image installatie op Kubernetes', 10)
    k8s.flush()
    N_TRIAL = 10
    for trial in range(N_TRIAL):
        try:
            time.sleep(10)
            percentage = 28 + (12 * trial)
            update_session_status(session, 'Installatie voortgang {}'.format(trial + 1), percentage if percentage < 95 else 94)
            for bu in copy.deepcopy(to_check):
                ip = k8s.status()
                update_session_status(session, 'Status controle van pod', 95)
                ready, message = k8s.get_pods_status()
                if not ready:
                    update_session_status(session, 'An error within the image prevented from a correct deployment')
                    return False
                update_session_status(session, 'Installatie succesvol uitgevoerd', 100)
                bu.docker_url = ip
                bu.save()
                to_check.remove(bu)
            return True
        except Exception as e:
            pass
    update_session_status(session, 'Impossible to deploy successfully, trying to remove old sessions')
    # Remove previous allocated local resources
    ExposedUrl.objects.filter(session=session).delete()
    # No resource available
    if not purged:
        if purge_sessions():
            bootstrap_session(session.pk, purged=True)
    else:
        update_session_status(session, 'Impossible to deploy successfully, all the resources are being used')
    return False


@app.task
def run_tests(session_pk):
    session = Session.objects.get(pk=session_pk)
    exposed_url = ExposedUrl.objects.filter(session=session,
                                            vng_endpoint__session_type=session.session_type)

    # stop the session for each exposed url, and eventually run the tests
    for eu in exposed_url:
        ep = eu.vng_endpoint
        if not ep.test_file:
            continue
        newman = NewmanManager(ep.test_file, ep.url)
        newman.replace_parameters({
            ep.name: ep.url
        })
        result = newman.execute_test()
        ts = TestSession()
        ts.save_test(result)
        with newman.execute_test_json() as result_json:
            ts.save_test_json(result_json)

        ts.save()
        eu.test_session = ts
        eu.save()

    session.status = choices.StatusChoices.stopped
    session.save()

    VNGEndpoint.objects.filter(session_type=session.session_type)
