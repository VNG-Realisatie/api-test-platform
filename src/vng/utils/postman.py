import json
from .choices import ResultChoices


def get_outcome_json(_json):
    error_codes = range(400, 600)

    json_obj = json.loads(_json)
    if json_obj['run']['failures'] != []:
        return ResultChoices.failed
    for call in json_obj['run']['executions']:
        if str(call['response']['code']) in error_codes:
            return ResultChoices.failed
    return ResultChoices.success


def get_json_obj_file(filename):
    with open(filename) as jfile:
        return get_json_obj(jfile, file=True)


def get_json_obj(content, file=False):
    if file:
        f = json.load(content)
    else:
        f = json.loads(content)
    res = f['run']['executions']
    for execution in res:
        req = execution['request']['url']
        url = '.'.join(req['host'])
        path = ''
        if 'path' in req:
            path = '/'.join(req['path'])
        if 'protocol' in req:
            req['url'] = '{}://{}/{}'.format(req['protocol'], url, path)
        else:
            req['url'] = '{}/{}'.format(url, path)

        execution['item']['error_test'] = False
        if 'assertions' in execution:
            for assertion in execution['assertions']:
                if 'error' in assertion:
                    execution['item']['error_test'] = True
                    break

    return res
