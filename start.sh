#!/usr/bin/env bash
set -o errexit

# Clear caches
php artisan config:clear
php artisan cache:clear

# 1. Run migrations ONLY. 
# We remove the --seed here to ensure the migration process closes completely.
php artisan migrate:fresh --force

# 2. Wait. This isn't just for luck; it forces the Postgres connection to 
# finish its current transaction block.
sleep 10

# 3. Run the seeders as a fresh, new database connection.
php artisan db:seed --force

# 4. Final caching
php artisan config:cache
php artisan route:cache

# 5. Start
php artisan serve --host=0.0.0.0 --port=8000