# Generated by Django 2.1.3 on 2018-11-13 14:20

from django.db import migrations


class Migration(migrations.Migration):
    atomic = False
    dependencies = [
        ('testsession', '0004_session_type_session'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Session_type',
            new_name='SessionType',
        ),
        migrations.RenameField(
            model_name='session',
            old_name='type_session',
            new_name='sessionType',
        ),
    ]