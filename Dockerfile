# Lightweight web server
FROM nginx:alpine

# Copy files to Nginx
COPY . /usr/share/nginx/html

# Expose port
EXPOSE 80


