# Use nginx base image
FROM nginx:latest

# Copy index.php file into the container
COPY index.php /usr/share/nginx/html/index.php
