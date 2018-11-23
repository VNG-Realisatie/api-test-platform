import subprocess
import logging

logger = logging.getLogger(__name__)

class NewmanManager:
    RUN_COMMAND = 'newman run {}'

    def __init__(self, file):
        self.file = file

    def run_command(self, command, *args):
        command = command.format(*args)
        logger.debug('running the COMMAND: {}'.format(command))
        subp = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        err = subp.stderr.read()
        return (subp.stdout.read(), err)

    def execute_test(self):
        output, error = self.run_command(self.RUN_COMMAND, self.file.path)
        if error is not None:
            return output

