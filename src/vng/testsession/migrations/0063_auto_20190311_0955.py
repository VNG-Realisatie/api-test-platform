# Generated by Django 2.2a1 on 2019-03-11 08:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('testsession', '0062_merge_20190306_1018'),
    ]

    operations = [
        migrations.AddField(
            model_name='session',
            name='deploy_percentage',
            field=models.IntegerField(blank=True, default=None, null=True),
        ),
        migrations.AddField(
            model_name='session',
            name='deploy_status',
            field=models.TextField(blank=True, default=None, null=True),
        ),
    ]
