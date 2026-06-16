#!/bin/sh
set -e
python wait_for_db.py
flask db upgrade
exec gunicorn -b 0.0.0.0:8000 wsgi:app