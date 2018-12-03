import uuid
import subprocess
import logging
import os

logger = logging.getLogger(__name__)

class NewmanManager:
    REPORT_FOLDER = 'newman'
    RUN_COMMAND = 'newman run --reporters html {} --reporter-html-export ./'+REPORT_FOLDER+'/{}.html'    #'newman run --reporters html {}'

    def __init__(self, file):
        self.file = file
        self.file_to_be_discarted = []

    def __del__(self):
        for file in self.file_to_be_discarted:
            full_path = os.path.realpath(file.name)
            os.remove(full_path)


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
        self.file_to_be_discarted.append(f)

        if error is not None:
            return f


