#!/bin/bash


# downloading the last release plus bundle package for locale
cd /var/www
wget https://github.com/ushahidi/platform-client/archive/v4.4.4.zip
unzip v4.4.4.zip -d  /var/www
mv /var/www/platform-client* /var/www/platform-client
rm v4.4.4.zip
# downloading bundle package for locales
wget https://github.com/ushahidi/platform-client/releases/download/v4.4.4/ushahidi-platform-client-bundle-v4.4.4.tar.gz
ver=$(tar -tf ushahidi-platform-client-bundle-v4.4.4.tar.gz | head -n1 | tr -d /)
tar -xvf ushahidi-platform-client-bundle-v4.4.4.tar.gz && cp -r $ver/. /var/www/platform-client/server/www
rm ushahidi-platform-client-bundle-v4.4.4.tar.gz

cd /var/www/platform-client 
chown -R www-data:www-data /var/www/platform-client  /var/log/apache2

#git checkout develop
npm install -g gulp
npm install

a2enmod rewrite
a2enmod headers
rm -R /var/www/html

#to fix error relate to ip address of container apache2
echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
