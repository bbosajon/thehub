# Use a base Ubuntu image
FROM ubuntu:22.04

# Set environment variables to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Add OpenLiteSpeed APT repository and install OpenLiteSpeed
RUN wget -O - https://rpms.litespeedtech.com/centos/RPM-GPG-KEY-litespeed | apt-key add - \
    && echo "deb http://rpms.litespeedtech.com/debian/ jammy main" > /etc/apt/sources.list.d/litespeed.list \
    && apt-get update && apt-get install -y \
    openlitespeed \
    && rm -rf /var/lib/apt/lists/*

# Expose ports for OpenLiteSpeed
EXPOSE 80 443

# Start OpenLiteSpeed server
CMD ["/usr/local/lsws/bin/lswsctrl", "start"]
