#!/usr/bin/env bash
set -o errexit

php artisan config:clear
php artisan route:clear

# Run ALL migrations first — creates users table
php artisan migrate --force

# Create users AFTER migrations
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
\App\Models\User::updateOrCreate(
    ['username' => 'user'],
    [
        'name'     => 'Regular User',
        'username' => 'user',
        'email'    => 'user@school.com',
        'password' => bcrypt('user123'),
        'role'     => 'user',
    ]
);
echo 'Users created successfully';
"

# Skip db:seed for now — add back once users issue is resolved
# php artisan db:seed --force

php artisan config:cache
php artisan route:cache

php artisan serve --host=0.0.0.0 --port=8000