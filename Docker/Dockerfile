# Dockerfile to setup PHP server
# Version 0.0.1

# Set base image from PHP Latest
FROM php:latest

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install git
RUN apt-get update && apt-get install -y git

# Remove default web app
RUN rm -rf /var/www/html/*

# Clone web app from github
RUN git clone https://github.com/broekeson/Basic-CRUD-Application.git /var/www/html

# Expose port 80
EXPOSE 80

# Run the web app
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]