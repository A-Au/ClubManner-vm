#!/bin/bash

sudo mkdir -p /var/www/resources/css
sudo mkdir -p /var/www/resources/images
sudo mkdir -p /var/www/resources/js
sudo mkdir -p /var/www/ssi
sudo mkdir -p /var/log/django
sudo chmod 777 /var/log/django

sudo apt-get update

# Apache2
sudo apt-get -y install apache2
sudo apt-get -y install apache2-dev
sudo apt-get -y install libapache2-mod-wsgi-py3

# Python
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get -y install python3.6
sudo apt-get -y install python3.6-dev
sudo apt-get -y install python-pip

sudo pip install virtualenv
pip install --upgrade pip

# PostgreSQL
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-9.6

cd /vagrant
wget https:/.com/GrahamDumpleton/mod_wsgi/archive/4.5.14.tar.gz

tar xvfz /vagrant/4.5.14.tar.gz
cd /vagrant/mod_wsgi-4.5.14
./configure --with-python=/usr/bin/python3.6
make
make install

#echo "LoadModule wsgi_module modules/mod_wsgi.so" >> /etc/apache2/apache2.conf
sudo rm /etc/apache2/apache2.conf
sudo cp /vagrant/setup/apache2.conf /etc/apache2/apache2.conf

sudo cp /vagrant/setup/clubmanner.com.conf /etc/apache2/sites-available

sudo a2enmod wsgi
sudo a2ensite clubmanner.com.conf
sudo a2dissite 000-default.conf

sudo rm -rf /var/www/html/

make clean

sudo apt-get -y upgrade

sudo mkdir -p /var/www/clubmanner.com/mock
sudo cp -r /home/ubuntu/ClubManner-frontend/mock/* /var/www/clubmanner.com/mock

sudo rm /vargrant/4.5.14.tar.gz
sudo rm -rf /vargrant/mod_wsgi-4.5.14

cd /home/ubuntu/ClubManner-Email
virtualenv -p python3.6 emailenv
source /home/ubuntu/ClubManner-Email/emailenv/bin/activate
pip install -r /home/ubuntu/ClubManner-Email/requirements.txt

sudo service apache2 restart
