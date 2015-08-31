#!/bin/bash

cd /var/www
git clone https://github.com/ushahidi/platform-client.git
git submodule update --init --recursive

cd /var/www/platform-client
npm install -g gulp
npm install

a2enmod rewrite
rm -R /var/www/html

#to fix error relate to ip address of container apache2
echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
