#!/usr/bin/env bash

apt-get update
#apt-get install -y apache2
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi

echo "Installing Git"
apt-get install git -y > /dev/null
 
echo "Installing Nginx"
apt-get install nginx -y > /dev/null

touch /etc/nginx/sites-enabled/dev.pachnand.org.conf
cd /apps/dropwizard-example
rm -R targe
sudo apt-get install openjdk-8-jdkt
java -version
mvn clean package
java -jar target/dropwizard-example-0.8.1-SNAPSHOT.jar server exampl.yml
