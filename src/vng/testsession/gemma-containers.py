from .kubernetes import *

postgis = Container(
    image='mdillon/postgis:11',
    public_port=5432,
    private_port=5432,
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
    image='rabbitmq',
    public_port=5672,
    private_port=5672,
    variables={}
)

celery = Container(
    image='celery',
    public_port=None,
    private_port=None,
    variables={}
)

NRC = Container(
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
    image='vngr/gemma-ztc',
    public_port=8002,
    private_port=8002,
    variables={
        'DB_HOST': 'localhost',
        'DB_NAME': 'nrc',
        'DB_USER': 'postgres',
        'DB_PASSWORD': 'postgres'
    }
)

ZRC = Container(
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
