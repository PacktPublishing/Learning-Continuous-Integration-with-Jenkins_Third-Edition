# Use the lightweight version of the official Nginx image based on Alpine Linux as the base image
FROM nginx:alpine

# Copy the content of the 'frontend' directory on the host
# to the default Nginx public directory inside the container
COPY . /usr/share/nginx/html

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
