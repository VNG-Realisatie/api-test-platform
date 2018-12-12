import subprocess
import logging
import re

from django.conf import settings
from .errors import CommandError

logger = logging.getLogger(__name__)


def run_command(command):
    logger.debug('running the COMMAND: {}'.format(command))
    subp = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    res, error = subp.communicate('n\n')
    if error:
        logger.exception(error)
    if res is not None:
        return res


def run_command_with_shell(command):
    logger.debug('running the COMMAND: {}'.format(command))
    subp = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    res = subp.communicate('n\n')
    if res is not None:
        return res
