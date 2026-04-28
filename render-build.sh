#!/usr/bin/env bash
set -o errexit

# Use the absolute path for composer
/usr/bin/composer install --no-dev --optimize-autoloader

php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan migrate --force