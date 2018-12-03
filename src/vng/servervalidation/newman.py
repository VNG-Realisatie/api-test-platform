import uuid
import subprocess
import logging

logger = logging.getLogger(__name__)

class NewmanManager:
    REPORT_FOLDER = 'newman'
    RUN_COMMAND = 'newman run --reporters html {} --reporter-html-export ./'+REPORT_FOLDER+'/{}.html'    #'newman run --reporters html {}'

    def __init__(self, file):
        self.file = file

    def run_command(self, command, *args):
        command = command.format(*args)
        logger.debug('running the COMMAND: {}'.format(command))
        subp = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        err = subp.stderr.read()
        logger.debug(str(err))
        return (subp.stdout, err)

    def execute_test(self):
        filename = str(uuid.uuid4())
        output, error = self.run_command(self.RUN_COMMAND, self.file.path, filename)
        f = open('{}/{}.html'.format(self.REPORT_FOLDER, filename))

        if error is not None:
            return f


