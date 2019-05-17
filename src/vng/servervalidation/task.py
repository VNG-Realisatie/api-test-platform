import uuid
from zds_client import ClientAuth

from django.core.files import File
from django.utils import timezone
from django.core.mail import send_mail
from django.template.loader import render_to_string
from celery.utils.log import get_task_logger
from django.conf import settings

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
    server_run = ServerRun.objects.filter(scheduled=True).filter(status=choices.StatusWithScheduledChoices.scheduled).order_by('user')
    s_list = []
    for i, sr in enumerate(server_run):
        sr.status = choices.StatusWithScheduledChoices.running
        sr.save()
        s_list.append((sr, execute_test(sr.pk, scheduled=True)))
        if i == len(server_run) - 1 or sr.user != server_run[i + 1].user and s_list != []:
            send_email_failure(s_list)
            s_list = []


@app.task
def execute_test(server_run_pk, scheduled=False, email=False):
    server_run = ServerRun.objects.get(pk=server_run_pk)
    server_run.status = choices.StatusWithScheduledChoices.running
    endpoints = Endpoint.objects.filter(server_run=server_run)

    file_name = str(uuid.uuid4())
    postman_tests = PostmanTest.objects.filter(test_scenario=server_run.test_scenario).order_by('order')
    # remove previous results
    PostmanTestResult.objects.filter(server_run=server_run).delete()
    failure = False
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
            failure = failure or (ptr.status == choices.ResultChoices.failed)

        server_run.status_exec = 'Completed'
    except Exception as e:
        logger.info(e)
        server_run.status_exec = 'An error occurred'
    server_run.percentage_exec = 100
    if not scheduled:
        server_run.status = choices.StatusWithScheduledChoices.stopped
        server_run.stopped = timezone.now()
    else:
        server_run.last_exec = timezone.now()
        server_run.status = choices.StatusWithScheduledChoices.scheduled
    if email:
        send_email_failure([(server_run, failure)])
    server_run.save()
    return failure


def send_email_failure(sl):
    from django.contrib.sites.models import Site
    domain = Site.objects.get_current().domain
    msg_html = render_to_string('servervalidation/failed_test_email.html', {
        'successful': [s for s in sl if not s[1]],
        'failure': [s for s in sl if s[1]],
        'domain': domain
    })

    send_mail(
        'Failure of scheduled test',
        msg_html,
        settings.DEFAULT_FROM_EMAIL,
        [sl[0][0].user.email],
        html_message=msg_html
    )
