#!/bin/bash

# Menjalankan php artisan jika kontainer baru dibuat atau di-restart
php artisan key:generate
php artisan storage:link
php artisan migrate --force
php artisan db:seed
# Menjalankan perintah default dari kontainer (misalnya php-fpm atau nginx)
exec "$@"
