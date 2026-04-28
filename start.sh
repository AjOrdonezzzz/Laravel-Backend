#!/usr/bin/env bash
set -o errexit

php artisan config:clear
php artisan route:clear

# Run migrations FIRST — this creates the users table
php artisan migrate --force

# Create admin user via tinker AFTER migrations
php artisan tinker --execute="
\App\Models\User::updateOrCreate(
    ['username' => 'admin'],
    [
        'name'     => 'System Admin',
        'username' => 'admin',
        'email'    => 'admin@school.com',
        'password' => bcrypt('password123'),
        'role'     => 'admin',
    ]
);
echo 'Admin user created successfully';
"

# Seed the rest of the data
php artisan db:seed --force

php artisan config:cache
php artisan route:cache

php artisan serve --host=0.0.0.0 --port=8000