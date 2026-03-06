# Step 1: Use an official lightweight web server as the base image
FROM nginx:latest

# Step 2: Copy our custom HTML file into the Nginx web directory
# This overwrites the default "Welcome to nginx" page
COPY index.html /usr/share/nginx/html/index.html

# Step 3: Expose port 80 so we can access the web server
EXPOSE 80

# Step 4: Nginx starts automatically in this image, so no CMD needed