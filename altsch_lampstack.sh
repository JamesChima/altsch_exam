#!/bin/bash

#Udate Ubuntu package manager
sudo apt update

#Install apache 
sudo apt install apache2 -y

#adjust firewall settings for apache
sudo ufw applist
sudo ufw allow "Apache"
sudo ufw status

#Install Mysql server 
sudo apt install  mysql-server -y

#Start msql security script
sudo mysql-secure-installation

#Install php
sudo apt install php8.2 -y

# Install PHP 8.2 Extensions
sudo apt-get install -y php8.2-cli php8.2-common php8.2-fpm php8.2-mysql php8.2-zip php8.2-gd php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath

#Restart the services
sudo systemctl restart apache2
sudo systemctl restart mysql

#Clone php laravel from Github
git clone https://github.com/laravel/laravel.git /var/www/html/altsch_laravelapp

#configure Mysql
sudo mysql -e "CREATE DATABASE altsch_exam;"
sudo mysql -e "CREATE USER 'laravel'@'localhost' IDENTIFIED BY 'ansible';"
sudo mysql -e "GRANT ALL PRIVILEGES ON altsch_exam.* to 'laravel'@'localhost';"
sudo php artisan session:table
sudo php artisan migrate

#Install composer
sudo apt install php-cli unzip
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer
composer update

#Build .env file and genarate app key
cp .env.example .env
php artisan key:generate

#Set permissiona
sudo chown -R www-data storage
sudo chown -R www-data bootstarp/cache

#Restart the services
sudo systemctl restart apache2
sudo systemctl restart mysql
