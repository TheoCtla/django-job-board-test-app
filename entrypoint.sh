#!/bin/sh
set -e

echo "==> Collecting static files..."
python manage.py collectstatic --noinput

echo "==> Uploading assets to Azure Blob Storage..."
python backend/initialize_azure.py

echo "==> Running database migrations..."
python manage.py migrate --noinput

echo "==> Starting Gunicorn..."
exec gunicorn job_board.wsgi:application --bind 0.0.0.0:8000 --workers 2
