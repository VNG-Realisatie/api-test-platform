# -*- coding: utf-8 -*-
# Generated by Django 1.11.14 on 2018-11-22 14:47
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('servervalidation', '0004_serverrun_stopped'),
    ]

    operations = [
        migrations.AlterField(
            model_name='serverrun',
            name='stopped',
            field=models.DateTimeField(blank=True, default=None, null=True),
        ),
    ]