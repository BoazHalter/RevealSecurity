# Use nginx base image
FROM php:7.4-fpm


# Copy index.php file into the container
COPY index.php /var/www/html/index.php
