# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y wget gnupg2 lsb-release

# Install OpenLiteSpeed
RUN wget -O - https://rpms.litespeedtech.com/centos/RPM-GPG-KEY-LiteSpeed | apt-key add - && \
    echo "deb http://rpms.litespeedtech.com/ubuntu/ focal main" > /etc/apt/sources.list.d/litespeed.list && \
    apt-get update && \
    apt-get install -y openlitespeed

# Install PHP (example: PHP 7.4)
RUN apt-get install -y lsphp74 lsphp74-mysql lsphp74-xml lsphp74-mbstring

# Copy your application files to the container (optional)
# COPY /path/to/your/app /usr/local/lsws/Example/

# Expose ports for OpenLiteSpeed
EXPOSE 80 443

# Start OpenLiteSpeed server
CMD ["/usr/local/lsws/bin/lswsctrl", "start"] && tail -f /usr/local/lsws/logs/error.log
