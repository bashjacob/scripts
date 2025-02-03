#!/bin/bash

# Variables
echo ""; read -r -p "Enter git repository url: " GIT_REPO < /dev/tty

# Remove existing directory and clone fresh copy
echo "Deploying web application..."
sudo rm -rf /var/www/html/*
sudo git clone "$GIT_REPO" /var/www/html/ > /dev/null 2>&1

# Set correct permissions
echo "Setting permissions..."
sudo chmod -R 755 /var/www/html

# Restart services
echo "Restarting web services..."
sudo systemctl restart apache2 > /dev/null 2>&1

echo "Deployment completed successfully!"
