#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies only
composer install --no-dev --optimize-autoloader