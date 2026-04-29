#!/usr/bin/env bash
set -o errexit

php artisan config:clear
php artisan route:clear

# Wipe and remigrate to ensure clean state
php artisan db:wipe --force
php artisan migrate --force

# Seed everything including users
php artisan db:seed --force

php artisan config:cache
php artisan route:cache

php artisan serve --host=0.0.0.0 --port=8000