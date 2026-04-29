#!/usr/bin/env bash
set -o errexit

php artisan config:clear
php artisan route:clear

# Force fresh migration — drops all tables and recreates them
php artisan migrate:fresh --force

# Create users after fresh migration
php artisan tinker --execute="
\App\Models\User::create([
    'name'     => 'System Admin',
    'username' => 'admin',
    'email'    => 'admin@school.com',
    'password' => bcrypt('password123'),
    'role'     => 'admin',
]);
\App\Models\User::create([
    'name'     => 'Regular User',
    'username' => 'user',
    'email'    => 'user@school.com',
    'password' => bcrypt('user123'),
    'role'     => 'user',
]);
echo 'Users created!';
"

php artisan config:cache
php artisan route:cache

php artisan serve --host=0.0.0.0 --port=8000