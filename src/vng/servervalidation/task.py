import uuid

from django.core.files import File
from django.utils import timezone
from celery.utils.log import get_task_logger

from ..celery.celery import app
from .models import PostmanTest, PostmanTestResult, Endpoint, ServerRun
from ..utils import choices
from ..utils.newman import DidNotRunException, NewmanManager


logger = get_task_logger(__name__)


@app.task
def execute_test(server_run_pk):
    server_run = ServerRun.objects.get(pk=server_run_pk)
    endpoints = Endpoint.objects.filter(server_run=server_run)

    file_name = str(uuid.uuid4())
    try:
        for postman_test in PostmanTest.objects.filter(test_scenario=server_run.test_scenario).order_by('order'):
            nm = NewmanManager(postman_test.validation_file)
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
            ptr.status = ptr.get_outcome_html()
            ptr.save()
        server_run.status = choices.StatusChoices.stopped
        server_run.stopped = timezone.now()
        server_run.save()
    except Exception as e:
        logger.info(e)
