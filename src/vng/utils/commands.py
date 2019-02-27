import logging
import os
import subprocess

logger = logging.getLogger(__name__)


def run_command(command):
    logger.info('running the COMMAND: %s', command)
    my_env = os.environ.copy()
    my_env["CLOUDSDK_PYTHON"] = "/usr/bin/python2"

    if my_env.get("VIRTUAL_ENV"):
        del my_env["VIRTUAL_ENV"]
    my_env["HOME"] = "/home/maykin"
    logger.info('Environment: {}'.format(str(my_env)))
    subp = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=my_env)
    res, error = subp.communicate('n\n')
    if error:
        logger.exception(error)
    if res is not None:
        return res


def run_command_with_shell(command):
    logger.debug('running the COMMAND: %s', command)
    subp = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    res = subp.communicate('n\n')
    if res is not None:
        return res
