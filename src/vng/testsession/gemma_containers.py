from .kubernetes import *

postgis = Container(
    name='postgis',
    image='mdillon/postgis:11',
    public_port=None,
    private_port=None,
    variables={},
    data=[
        "create database AC;"
        "create database NRC;"
        "create database ZTC;"
        "create database ZRC;"
        "create database DRC;"
        "create database BRC;"
    ],
    filename='initdb.sql'
)

rabbitMQ = Container(
    name='rabbit',
    image='rabbitmq',
    public_port=5672,
    private_port=5672,
    exposed=False,
    variables={}
)

celery = Container(
    name='celery',
    image='celery',
    public_port=None,
    private_port=None,
    exposed=False,
    variables={}
)

NRC = Container(
    name='nrc',
    image='vngr/gemma-notifications',
    public_port=8004,
    private_port=8004,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'nrc',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

ZTC = Container(
    name='ztc',
    image='vngr/gemma-ztc',
    public_port=8002,
    private_port=8002,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'ztc',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

ZRC = Container(
    name='zrc',
    image='vngr/gemma-zrc',
    public_port=8000,
    private_port=8000,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'zrc',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

BRC = Container(
    name='brc',
    image='vngr/gemma-brc',
    public_port=8003,
    private_port=8003,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'brc',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

DRC = Container(
    name='drc',
    image='vngr/gemma-drc',
    public_port=8001,
    private_port=8001,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'drc',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

AC = Container(
    name='ac',
    image='vngr/gemma-autorisatiecomponent',
    public_port=8005,
    private_port=8005,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'ac',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)
