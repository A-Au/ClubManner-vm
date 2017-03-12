#!/bin/bash

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

# PostgreSQL
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-9.6

sudo pip install virtualenv
pip install --upgrade pip

cd /vagrant
wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.5.14.tar.gz

tar xvfz /vagrant/4.5.14.tar.gz
cd /vagrant/mod_wsgi-4.5.14
./configure --with-python=/usr/bin/python3.6
make
make install

echo "LoadModule wsgi_module modules/mod_wsgi.so" >> /etc/apache2/apache2.conf
make clean

sudo apt-get -y upgrade

sudo service apache2 restart
