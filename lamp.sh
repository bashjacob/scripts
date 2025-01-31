#!/bin/bash

#Update package list
sudo apt update > /dev/null 2>&1
echo -e "\n------------------\n"

#Apache
echo "Installing apache..."
sudo apt install -y apache2 > /dev/null 2>&1
echo -e "\n------------------\n"

#MySQL
echo "Installing mysql..."
sudo apt install -y mysql-server > /dev/null 2>&1
echo -e "\n------------------\n"

#PHP and some modules
echo "Installing PHP..."
sudo apt install -y > /dev/null 2>&1 php libapache2-mod-php php-mysql php-cli php-curl php-gd php-json php-mbstring php-xml php-zip
echo -e "\n------------------\n"

echo "Starting and enabing apache service..."
sudo systemctl enable --now apache2 > /dev/null 2>&1
echo -e "\n------------------\n"

#Checking packages
if systemctl is-active --quiet apache2; then
  APACHE_WORKS='OK'
else
  APACHE_WORKS='FAILED'
fi

if [[ -z $(dpkg -l | grep -i mysql-server) ]]; then
  MYSQL_WORKS='FAILED'
else
  MYSQL_WORKS='OK'
fi

if [[ -z $(dpkg -l | grep -i php) ]]; then
  PHP_WORKS='FAILED'
else
  PHP_WORKS='OK'
fi

echo "Services check:
[Apache] - $APACHE_WORKS
[MySQL] - $MYSQL_WORKS
[PHP] - $PHP_WORKS"


echo -e "\nDon't forget about:
  - sudo mysql_secure_installation
  - sudo systemctl enable --now mysql"
