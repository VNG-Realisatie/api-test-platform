from .kubernetes import *

postgis = Container(
    name='postgis',
    image='mdillon/postgis:11',
    public_port=5432,
    private_port=5432,
    exposed=False,
    variables={},
    command=[
        "echo 'create database AC' | sudo -u postgres psql",
        "echo 'create database NRX' | sudo -u postgres psql",
        "echo 'create database ZTC' | sudo -u postgres psql",
        "echo 'create database ZRC' | sudo -u postgres psql",
        "echo 'create database DRC' | sudo -u postgres psql",
        "echo 'create database BRC' | sudo -u postgres psql"
    ]
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
    name='NRC',
    image='vngr/gemma-notifications',
    public_port=8004,
    private_port=8004,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'NRC',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

ZTC = Container(
    name='ZTC',
    image='vngr/gemma-ztc',
    public_port=8002,
    private_port=8002,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'ZTC',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

ZRC = Container(
    name='ZRC',
    image='vngr/gemma-zrc',
    public_port=8000,
    private_port=8000,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'ZRC',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

BRC = Container(
    name='BRC',
    image='vngr/gemma-brc',
    public_port=8003,
    private_port=8003,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'BRC',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

DRC = Container(
    name='DRC',
    image='vngr/gemma-drc',
    public_port=8001,
    private_port=8001,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'DRC',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)


AC = Container(
    name='AC',
    image='vngr/gemma-autorisatiecomponent',
    public_port=8005,
    private_port=8005,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'AC',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)
