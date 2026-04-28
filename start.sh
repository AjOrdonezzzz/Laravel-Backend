#!/usr/bin/env bash
set -o errexit

# Clear any cached config from build time
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Now cache with correct env values
php artisan config:cache
php artisan route:cache

# Run migrations and seed
php artisan migrate --force
php artisan db:seed --class=UserSeeder --force

# Start server
php artisan serve --host=0.0.0.0 --port=8000