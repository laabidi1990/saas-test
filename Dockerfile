# Use an official PHP image
FROM php:8.1-fpm

# Set working directory inside the container
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git

# Install PHP extensions required for Laravel
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Install Composer (PHP dependency manager)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy the Laravel app code into the container
COPY . .

# Install Laravel dependencies
RUN composer install

# Set environment variables
ENV DB_CONNECTION=pgsql
ENV DB_HOST=postgres
ENV DB_PORT=5432

# Expose the app on port 80
EXPOSE 80

# Start the PHP FPM server
CMD ["php-fpm"]
