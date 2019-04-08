# Generated by Django 2.2a1 on 2019-04-04 09:01

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('servervalidation', '0053_auto_20190327_1645'),
    ]

    operations = [
        migrations.AlterField(
            model_name='endpoint',
            name='server_run',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='servervalidation.ServerRun'),
        ),
        migrations.AlterField(
            model_name='expectedpostmanresult',
            name='expected_response',
            field=models.CharField(choices=[('200 OK', 'OK 200'), ('201 Created', 'CREATED 201'), ('204 No Content', 'NO CONTENT 204'), ('301 Moved Permanently', 'MOVED 301'), ('302 Found', 'FOUND 302'), ('400 Bad Request', 'BAD REQUEST 400'), ('401 Unauthorized', 'UNAUTHORIZED 401'), ('403 Forbidden', 'FORBITTEN 403'), ('404 Not Found', 'NOT FOUND 404'), ('405 Method Not Allowed', 'METHOD NOT ALLOWED'), ('500 Internal Server Error', 'INTERNAL ERROR 500')], max_length=20),
        ),
        migrations.AlterField(
            model_name='postmantestresult',
            name='server_run',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='servervalidation.ServerRun'),
        ),
        migrations.AlterField(
            model_name='serverheader',
            name='server_run',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='servervalidation.ServerRun'),
        ),
        migrations.AlterField(
            model_name='serverrun',
            name='started',
            field=models.DateTimeField(default=django.utils.timezone.now, verbose_name='Gestart op'),
        ),
        migrations.AlterField(
            model_name='serverrun',
            name='stopped',
            field=models.DateTimeField(blank=True, default=None, null=True, verbose_name='Gestopt op'),
        ),
        migrations.AlterField(
            model_name='testscenario',
            name='authorization',
            field=models.CharField(choices=[('JWT', 'jwt'), ('Authorization header', 'header'), ('No Authorization', 'no auth')], default='JWT', max_length=20, verbose_name='Authorisatie'),
        ),
        migrations.AlterField(
            model_name='testscenario',
            name='name',
            field=models.CharField(max_length=200, unique=True, verbose_name='Naam'),
        ),
        migrations.AlterField(
            model_name='testscenariourl',
            name='name',
            field=models.CharField(max_length=200, verbose_name='Naam'),
        ),
    ]