#!/bin/bash 

#System Update
sudo apt update

#Database installation
echo "mysql-server mysql-server/root_password password password" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password password" | sudo debconf-set-selections

sudo apt install mysql-server -y

mysql --user=root --password='password' < ~/FlaskSettings/dbsetup.txt

#Apache Installation
sudo apt install apache2 -y
sudo apt install libapache2-mod-wsgi -y

#Pip installation
sudo apt install python-pip -y
sudo pip install flask

#installing neccesary modules
sudo pip install boto3
sudo pip install requests
sudo pip install mysql-connector-python

sudo ln -sT ~/FlaskSettings /var/www/html/flask

sudo mv ~/FlaskSettings/apacheconf.txt /etc/apache2/sites-enabled/000-default.conf

sudo apachectl restart

echo 'Setup Complete'