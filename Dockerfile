# Use an official PHP runtime with Apache as a parent image
FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libicu-dev \
    git \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install intl \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/html/

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install --no-autoloader --no-scripts

# Copy the application code
COPY . /var/www/html

# Generate the optimized autoloader
RUN composer dump-autoload --optimize

# Expose port 80
EXPOSE 80

# Apache will start automatically
