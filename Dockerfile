# Use the official PHP image with Apache
FROM php:8.2-apache

# Install additional PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install Composer (optional, for managing PHP dependencies)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy custom configuration files (if any)
# COPY ./path-to-your-php-config.ini /usr/local/etc/php/conf.d/

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the PHP website files into the container
COPY . .

# Install dependencies (if using Composer)
# RUN composer install

# Expose port 80 for the web server
EXPOSE 8000

# The default command to run when starting the container
CMD ["apache2-foreground"]


