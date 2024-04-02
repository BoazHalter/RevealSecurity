# Use the official Nginx image as the base image
FROM nginx:latest

# Install PHP and PHP-FPM
RUN apt-get update && apt-get install -y \
    php-fpm \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html

# Copy the index.php file into the container
COPY index.php /var/www/html/

# Expose port 80
EXPOSE 80

# Start PHP-FPM and Nginx when the container starts
CMD ["sh", "-c", "service php7.4-fpm start && nginx -g 'daemon off;'"]
