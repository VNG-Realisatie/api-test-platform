import time
import random

from datetime import timedelta, datetime
from celery.utils.log import get_task_logger

from django.utils.timezone import make_aware

from ..celery.celery import app
from .models import ExposedUrl, Session, TestSession, VNGEndpoint, EnvironmentBoostrap
from ..utils import choices
from ..utils.newman import NewmanManager
from .container_manager import K8S

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
            kuber = K8S()
            app_name = get_app_name(session, e_url)
            kuber.delete(app_name)
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


def start_app_b8s(kuber, session, bind_url):
    kuber.initialize()
    if session.session_type.database:
        kuber.deploy_postgres_no_persistent_lazy()
    update_session_status(session, 'Verbinding maken met Kubernetes', 1)
    endpoint = bind_url.vng_endpoint
    app_name = get_app_name(session, bind_url)
    update_session_status(session, 'Docker image installatie op Kubernetes', 10)
    # TODO: add environmental variables
    env_var = bind_url.vng_endpoint.environmentalvariables_set.all()
    e_vars = {e.key: e.value for e in env_var}
    kuber.deploy(app_name, endpoint.docker_image, endpoint.port, env_variables=e_vars)
    update_session_status(session, 'Installatie voortgang', 22)
    N_TRIALS = 10
    for trial in range(N_TRIALS):
        try:
            time.sleep(10)                      # Waiting for the load balancer to be loaded
            percentage = 28 + (12 * trial)
            update_session_status(session, 'Installatie voortgang {}'.format(trial + 1), percentage if percentage < 95 else 94)
            ip = kuber.status(app_name)

            update_session_status(session, 'Status controle van pod', 95)
            ready, message = kuber.get_pods_status(app_name)
            if not ready:
                update_session_status(session, 'An error within the image prevented from a correct deployment')
                return ready, message
            update_session_status(session, 'Installatie succesvol uitgevoerd', 100)
            return ip, None
        except Exception as e:
            pass
    update_session_status(session, 'Impossible to deploy successfully, trying to remove old sessions')
    if purge_sessions():
        start_app_b8s(kuber, session, bind_url)
    else:
        update_session_status(session, 'Impossible to deploy successfully, all the resources are being used')
    eb = EnvironmentBoostrap.objects.filter(vng_endpoint=endpoint)
    if len(eb) > 0:
        pass
        # TODO: run the command
    ready, message = kuber.get_pods_status(app_name)
    return ready, message


@app.task
def purge_sessions():
    align_sessions_data()
    purged = False
    for session in Session.objects.filter(started__lte=make_aware(datetime.now()) - timedelta(days=1)).filter(status=choices.StatusChoices.running):
        purged = True
        stop_session(session.pk)
    return purged


@app.task
def bootstrap_session(session_pk):
    '''
    Create all the necessary endpoint and exposes it so they can be used as proxy
    In case there is one or multiple docker images linked, it starts all of them
    '''
    session = Session.objects.get(pk=session_pk)
    endpoint = VNGEndpoint.objects.filter(session_type=session.session_type)
    try:
        error_deployment = False
        k8s = K8S()
        for ep in endpoint:
            bind_url = ExposedUrl.objects.create(
                session=session,
                vng_endpoint=ep,
                subdomain='{}'.format(int(time.time()) * 100 + random.randint(0, 99))
            )
            if ep.docker_image:
                ip, message = start_app_b8s(k8s, session, bind_url)
                if message is None:
                    bind_url.docker_url = ip
                else:
                    error_deployment = True
                    session.status = choices.StatusChoices.error_deploy
                    session.error_message = message
            if not error_deployment:
                bind_url.save()
            else:
                bind_url.delete()
        if not error_deployment:
            session.status = choices.StatusChoices.running
        session.save()
    except Exception as e:
        logger.exception(e)
        session.delete()


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
