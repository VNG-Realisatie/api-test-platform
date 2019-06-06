from .kubernetes import *

postgis = Container(
    name='postgis',
    image='mdillon/postgis:11',
    public_port=5432,
    private_port=5432,
    exposed=False,
    variables={
        'POSTGRES_PASSWORD': 'postgres',
        'POSTGRES_USER': 'postgres'
    },
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
        'DB_PASSWORD': 'postgres',
        'DJANGO_SETTINGS_MODULE': 'zrc.conf.docker',
        'SECRET_KEY': 'x1#8uih#76j4z)+_3j-^iot)2=c#ht%&j1lcvyqxh&t+=5i@i='
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
        'DB_PASSWORD': 'postgres',
        'DJANGO_SETTINGS_MODULE': 'zrc.conf.docker',
        'SECRET_KEY': '5t=%u76*^l%d97mp)6%u4-p^&wgfh(!+t1$*0pgjt&0&=oh-f!'
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
        'DB_PASSWORD': 'postgres',
        'DJANGO_SETTINGS_MODULE': 'zrc.conf.docker',
        'SECRET_KEY': '6$10p3m()ygr41f&!(ya=dw=aysz_9rg+bj1x*o1^vnw1n3-!p'
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
        'DB_PASSWORD': 'postgres',
        'DJANGO_SETTINGS_MODULE': 'zrc.conf.docker',
        'SECRET_KEY': 'dtd5g0#bef=sj!ii5@8pl3bkp=@$u7e68&+2p735n4ff1s22a3'
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
        'DB_PASSWORD': 'postgres',
        'DJANGO_SETTINGS_MODULE': 'zrc.conf.docker',
        'SECRET_KEY': 'h3af@_s8s@@(g0sz4py$6eaimers9zx8zu5m=3yi+kd(tjudlh'
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
        'DB_PASSWORD': 'postgres',
        'DJANGO_SETTINGS_MODULE': 'zrc.conf.docker',
        'SECRET_KEY': 'l00=^9g$va8nzl8#n1g_2e=8fdq$$38&^x6x$t9-cm6=tg8$hu'
    }
)


ingress = Ingress(
    name='zgw-ingress',
    paths=[{
        'path': '/ac',
        'serviceName': 'appname-service',
        'servicePort': 8005
    }, {
        'path': '/nrc',
        'serviceName': 'appname-service',
        'servicePort': 8004
    }, {
        'path': '/ztc',
        'serviceName': 'appname-service',
        'servicePort': 8002
    }, {
        'path': '/zrc',
        'serviceName': 'appname-service',
        'servicePort': 8000
    }, {
        'path': '/drc',
        'serviceName': 'appname-service',
        'servicePort': 8001
    }, {
        'path': '/brc',
        'serviceName': 'appname-service',
        'servicePort': 8003
    }
    ]
)
