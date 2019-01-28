import uuid

from django.core.files import File
from django.utils import timezone
from celery.utils.log import get_task_logger

from ..slave.celery import app
from .models import ExposedUrl, Session, TestSession, VNGEndpoint
from ..utils import choices
from ..utils.newman import DidNotRunException, NewmanManager
from .container_manager import K8S

logger = get_task_logger(__name__)


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

    endpoint = VNGEndpoint.objects.filter(session_type=session.session_type)

    # if the endpoints is related to an online cluster image it is stopped
    for ep in endpoint:
        if ep.docker_image:
            kuber = K8S()
            kuber.delete(session.name)
