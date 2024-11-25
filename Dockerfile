# Gunakan image PHP dengan versi yang sesuai
FROM php:8.2.12-fpm

# Instal dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx \
    supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions yang diperlukan Laravel
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Instal Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy semua file ke dalam container
COPY . .

# Beri permission
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www


# Menentukan entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


# Install dependensi proyek Laravel
RUN composer install --no-dev --optimize-autoloader

# Salin file konfigurasi Nginx dan Supervisor
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80 untuk Nginx dan port 9000 untuk PHP-FPM
EXPOSE 80 9000

# CMD untuk memulai Supervisor
CMD ["/usr/bin/supervisord"]
