# Django command to wait for the database to be available

# from typing import Any, Optional
from django.core.management.base import BaseCommand
import time
from django.db.utils import OperationalError
from psycopg2 import OperationalError as Psycopg20pError


class Command(BaseCommand):
    help = "Django command to wait for the database"

    def handle(self, *args, **options):
        """Entry point for command."""
        self.stdout.write("Waiting for database...")
        db_up = False
        while not db_up:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycopg20pError, OperationalError):
                self.stdout.write("Database unavailable, waiting 1 sec...")
                time.sleep(1)
        self.stdout.write(self.style.SUCCESS('Database available!'))
