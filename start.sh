#!/usr/bin/env bash
set -o errexit

# Clear everything
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear

# Run migration separately with a pause
php artisan migrate:fresh --force

# Pause for 5 seconds to let Postgres settle
sleep 5

# Run the seeder
php artisan db:seed --force

# Recache
php artisan config:cache
php artisan route:cache

# Start
php artisan serve --host=0.0.0.0 --port=8000