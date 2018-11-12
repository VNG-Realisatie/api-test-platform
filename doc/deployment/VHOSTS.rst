Apache + mod-wsgi configuration
===============================

An example Apache2 vhost configuration follows::

    WSGIDaemonProcess vng-<target> threads=5 maximum-requests=1000 user=<user> group=staff
    WSGIRestrictStdout Off

    <VirtualHost *:80>
        ServerName my.domain.name

        ErrorLog "/srv/sites/vng/log/apache2/error.log"
        CustomLog "/srv/sites/vng/log/apache2/access.log" common

        WSGIProcessGroup vng-<target>

        Alias /media "/srv/sites/vng/media/"
        Alias /static "/srv/sites/vng/static/"

        WSGIScriptAlias / "/srv/sites/vng/src/vng/wsgi/wsgi_<target>.py"
    </VirtualHost>


Nginx + uwsgi + supervisor configuration
========================================

Supervisor/uwsgi:
-----------------

.. code::

    [program:uwsgi-vng-<target>]
    user = <user>
    command = /srv/sites/vng/env/bin/uwsgi --socket 127.0.0.1:8001 --wsgi-file /srv/sites/vng/src/vng/wsgi/wsgi_<target>.py
    home = /srv/sites/vng/env
    master = true
    processes = 8
    harakiri = 600
    autostart = true
    autorestart = true
    stderr_logfile = /srv/sites/vng/log/uwsgi_err.log
    stdout_logfile = /srv/sites/vng/log/uwsgi_out.log
    stopsignal = QUIT

Nginx
-----

.. code::

    upstream django_vng_<target> {
      ip_hash;
      server 127.0.0.1:8001;
    }

    server {
      listen :80;
      server_name  my.domain.name;

      access_log /srv/sites/vng/log/nginx-access.log;
      error_log /srv/sites/vng/log/nginx-error.log;

      location /500.html {
        root /srv/sites/vng/src/vng/templates/;
      }
      error_page 500 502 503 504 /500.html;

      location /static/ {
        alias /srv/sites/vng/static/;
        expires 30d;
      }

      location /media/ {
        alias /srv/sites/vng/media/;
        expires 30d;
      }

      location / {
        uwsgi_pass django_vng_<target>;
      }
    }
