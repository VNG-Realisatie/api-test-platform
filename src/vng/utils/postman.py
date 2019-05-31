import json
from .choices import ResultChoices

error_codes = range(400, 600)


def get_error_codes():
    return error_codes


def get_outcome_json(_json, file=False):

    if file:
        json_obj = json.load(_json)
    else:
        json_obj = json.loads(_json)

    if json_obj['run']['failures'] != []:
        return ResultChoices.failed
    for call in json_obj['run']['executions']:
        if not get_call_result(call):
            return ResultChoices.failed
    return ResultChoices.success


def get_json_obj_file(filename):
    with open(filename) as jfile:
        return get_json_obj(jfile, file=True)


def get_call_result(call):
    # if the response is not present it means that it has not been performed
    if 'response' not in call or 'code' not in call['response']:
        return False
    if 'error_test' in call['item'] and call['item']['error_test']:
        return False
    return call['response']['code'] not in error_codes


def get_json_obj(content, file=False):
    if file:
        f = json.load(content)
    else:
        f = json.loads(content)
    res = f['run']['executions']
    for execution in res:
        if 'host' in execution['request']['url']:
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
