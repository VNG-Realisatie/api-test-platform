import uuid
from zds_client import ClientAuth

from django.core.files import File
from django.utils import timezone
from celery.utils.log import get_task_logger

from ..celery.celery import app
from .models import PostmanTest, PostmanTestResult, Endpoint, ServerRun, ServerHeader
from ..utils import choices
from ..utils.newman import DidNotRunException, NewmanManager


logger = get_task_logger(__name__)


def get_jwt(server_run):

    return ClientAuth(
        client_id=server_run.client_id,
        secret=server_run.secret,
        scopes=['zds.scopes.zaken.lezen',
                'zds.scopes.zaaktypes.lezen',
                'zds.scopes.zaken.aanmaken',
                'zds.scopes.statussen.toevoegen',
                'zds.scopes.zaken.bijwerken'],
        zaaktypes=['*']
    )


@app.task
def execute_test_scheduled():
    server_run = ServerRun.objects.filter(scheduled=True).filter(status=choices.StatusWithScheduledChoices.scheduled)
    for sr in server_run:
        execute_test(sr.pk, scheduled=True)


@app.task
def execute_test(server_run_pk, scheduled=False):
    server_run = ServerRun.objects.get(pk=server_run_pk)
    server_run.status = choices.StatusWithScheduledChoices.running
    endpoints = Endpoint.objects.filter(server_run=server_run)

    file_name = str(uuid.uuid4())
    postman_tests = PostmanTest.objects.filter(test_scenario=server_run.test_scenario).order_by('order')
    try:
        for counter, postman_test in enumerate(postman_tests):
            auth_choice = postman_test.test_scenario.authorization
            if auth_choice == choices.AuthenticationChoices.jwt:
                jwt_auth = get_jwt(server_run).credentials()
            server_run.status_exec = 'Running the test {}'.format(postman_test.validation_file)
            server_run.percentage_exec = int(((counter + 1) / (len(postman_tests) + 1)) * 100)
            server_run.save()
            nm = NewmanManager(postman_test.validation_file)

            if auth_choice == choices.AuthenticationChoices.jwt:
                nm.replace_parameters({
                    'BEARER_TOKEN': list(jwt_auth.values())[0].split()[1]
                })
            elif auth_choice == choices.AuthenticationChoices.header:
                se = ServerHeader.objects.filter(server_run=server_run)
                for header in se:
                    nm.replace_parameters({
                        'Authentication': header.header_value
                    })
            elif auth_choice == choices.AuthenticationChoices.no_auth:
                pass
            param = {}
            for ep in endpoints:
                param[ep.test_scenario_url.name] = ep.url
                nm.replace_parameters(param)
            file = nm.execute_test()
            file_json = nm.execute_test_json()
            ptr = PostmanTestResult(
                postman_test=postman_test,
                server_run=server_run
            )
            ptr.log.save(file_name, File(file))
            ptr.save_json(file_name, File(file_json))
            ptr.status = ptr.get_outcome_json()
            ptr.save()

        server_run.status_exec = 'Completed'
    except Exception as e:
        logger.info(e)
        server_run.status_exec = 'An error occurred'
    server_run.percentage_exec = 100
    if not scheduled:
        server_run.status = choices.StatusWithScheduledChoices.stopped
        server_run.stopped = timezone.now()
    else:
        server_run.status = choices.StatusWithScheduledChoices.scheduled
    server_run.save()
