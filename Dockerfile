# Use the official Nginx image as the base image
FROM nginx:latest

# Update package repositories
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html

# Copy the index.php file into the container
COPY index.php /var/www/html/

# Expose port 80
EXPOSE 80

# Start PHP-FPM and Nginx when the container starts
CMD ["sh", "-c", "php-fpm7.4 && nginx -g 'daemon off;'"]
