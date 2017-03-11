#!/bin/bash

sudo apt-get update

# Apache2
sudo apt-get -y install apache2
sudo apt-get -y install libapache2-mod-wsgi-py3

# Python
sudo apt-get -y install python3.6
sudo apt-get -y install python3.6-dev
sudo apt-get -y install python-pip

# PostgreSQL
sudo apt-get -y install postgresql-9.6

sudo pip install virtualenv