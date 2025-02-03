#!/bin/bash

# Variables
echo ""; read -r -p "Enter git repository url: " GIT_REPO
echo ""; read -r -p "Enter web root directory (e.g./var/www/html): " WEB_ROOT

# Remove existing directory and clone fresh copy
echo "Deploying web application..."
sudo rm -rf "$WEB_ROOT"/*
sudo git clone "$GIT_REPO" "$WEB_ROOT"

# Set correct permissions
echo "Setting permissions..."
sudo chown -R www-data:www-data "$WEB_ROOT"
sudo chmod -R 755 "$WEB_ROOT"

# Restart services
echo "Restarting web services..."
sudo systemctl restart apache2 > /dev/null 2>&1

echo "Deployment completed successfully!"
