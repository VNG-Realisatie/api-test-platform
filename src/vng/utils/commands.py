import subprocess
import logging
import re

from django.conf import settings
from .errors import CommandError

logger = logging.getLogger(__name__)


def run_command(command):

    if settings.RUN_KUBERNETES_CMD:
        subp = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, err = subp.communicate('n\n')
        if err:
            logger.debug('running the COMMAND: {}'.format(command))
            logger.exception(err.decode('utf-8'))
            raise CommandError(err.decode('utf-8'), command)
    else:
        return 'success', 'error'
