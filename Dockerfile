# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    lsb-release \
    unzip \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add OpenLiteSpeed APT repository and install OpenLiteSpeed and PHP
RUN wget -O - https://rpms.litespeedtech.com/centos/RPM-GPG-KEY-litespeed | apt-key add - \
    && echo "deb http://rpms.litespeedtech.com/debian/ jammy main" > /etc/apt/sources.list.d/litespeed.list \
    && apt-get update && apt-get install -y \
    openlitespeed \
    lsphp81 \
    lsphp81-mysql \
    lsphp81-xml \
    lsphp81-mbstring \
    lsphp81-curl \
    lsphp81-zip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer (for Laravel)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Expose the ports OpenLiteSpeed will listen on
EXPOSE 80 443

# Set the working directory
WORKDIR /var/www/html

# Copy the Laravel application code into the container
COPY . .

# Install Laravel dependencies
RUN composer install

# Set file permissions (make sure the web server has proper permissions)
RUN chown -R www-data:www-data /var/www/html

# Copy OpenLiteSpeed configuration files (if any)
# COPY ./path-to-your-litespeed-config.conf /usr/local/lsws/conf/

# Start OpenLiteSpeed server
CMD ["/usr/local/lsws/bin/lswsctrl", "start"]

