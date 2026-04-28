#!/usr/bin/env bash
set -o errexit

# Clear file-based caches only (not database cache)
php artisan config:clear
php artisan route:clear

# Run migrations first — this creates all tables including cache
php artisan migrate --force

# Now seed users
php artisan db:seed --force

# Cache config after migrations are done
php artisan config:cache
php artisan route:cache

# Start server
php artisan serve --host=0.0.0.0 --port=8000