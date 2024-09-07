# Use an official PHP runtime as a parent image
FROM php:8.1-apache

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the PHP source code into the container
COPY . .

# Install any PHP extensions you need
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Expose port 80 to the outside world
EXPOSE 80

# Define the command to run the Apache server
CMD ["apache2-foreground"]