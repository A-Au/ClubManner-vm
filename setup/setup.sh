#!/bin/bash

sudo mkdir -p /var/www/resources/css
sudo mkdir -p /var/www/resources/images
sudo mkdir -p /var/www/resources/js
sudo mkdir -p /var/www/ssi
sudo mkdir -p /var/log/django
touch /var/log/django/cmemail.log

sudo chmod 777 /var
sudo chmod 777 /var/log
sudo chmod 777 /var/log/django
sudo chmod 777 /var/log/django/cmemail.log

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

sudo -u postgres psql -c "create role djangouser superuser"
sudo -u postgres psql -c "alter role djangouser with password 'password'"
sudo -u postgres psql -c "create database djangoadmin"
sudo -u postgres psql -c "alter role djangouser with login"

cd /vagrant
wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.5.14.tar.gz

tar xvfz /vagrant/4.5.14.tar.gz
cd /vagrant/mod_wsgi-4.5.14
./configure --with-python=/usr/bin/python3.6
make
make install

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
sudo cp -r /home/ubuntu/git/ClubManner-frontend/mock/* /var/www/clubmanner.com/mock

cd /home/ubuntu/git/ClubManner-backend
virtualenv -p python3.6 backendenv
source /home/ubuntu/git/ClubManner-backend/backendenv/bin/activate
pip install -r /home/ubuntu/git/ClubManner-backend/requirements.txt

/home/ubuntu/git/ClubManner-backend/manage.py makemigrations
/home/ubuntu/git/ClubManner-backend/manage.py migrate

sudo service apache2 restart

# clean up
sudo rm /vargrant/4.5.14.tar.gz
sudo rm -rf /vargrant/mod_wsgi-4.5.14
