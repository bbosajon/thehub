# Use a more recent official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to non-interactive to avoid prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Add OpenLiteSpeed APT repository
RUN wget -O - https://rpms.litespeedtech.com/centos/RPM-GPG-KEY-litespeed | apt-key add - \
    && echo "deb http://rpms.litespeedtech.com/debian/ jammy main" > /etc/apt/sources.list.d/litespeed.list

# Install OpenLiteSpeed
RUN apt-get update && apt-get install -y \
    openlitespeed \
    && rm -rf /var/lib/apt/lists/*

# Expose the ports OpenLiteSpeed will listen on
EXPOSE 80 443

# Copy custom configuration files (if any)
# Example: COPY ./my-config.conf /usr/local/lsws/conf/httpd_config.conf
# COPY ./vhost.conf /usr/local/lsws/conf/vhosts/my-vhost.conf

# Set permissions for configuration files if needed
# RUN chown -R lsadm:lsadm /usr/local/lsws/conf/

# Start OpenLiteSpeed server
CMD ["/usr/local/lsws/bin/lswsctrl", "start"]

# Optionally, you can specify an entrypoint script if you have setup steps
# ENTRYPOINT ["/usr/local/lsws/bin/lswsctrl", "start"]
