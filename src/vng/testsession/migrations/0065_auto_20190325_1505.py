# Generated by Django 2.2a1 on 2019-03-25 14:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('testsession', '0064_auto_20190325_1435'),
    ]

    operations = [
        migrations.AlterField(
            model_name='sessiontype',
            name='authentication',
            field=models.CharField(choices=[('JWT', 'jwt'), ('No Authorization', 'no auth')], default='No Authorization', max_length=20),
        ),
    ]
