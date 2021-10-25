#!/bin/bash

echo "deb [arch=amd64] http://nginx.org/packages/mainline/ubuntu/ bionic nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

sudo apt-get update
sudo apt-get install nginx

sudo systemctl start nginx
sudo systemctl enable nginx

sudo su -c "cp /home/vagrant/config.sh /etc/nginx/conf.d/nodeapp.conf"
sudo nginx -s reload

echo "Adding node"
chmod +x add-node.sh
sed -i 's/<useSecurity>true<\/useSecurity>/<useSecurity>false<\/useSecurity>/' /var/lib/jenkins/config.xml
./add-node.sh
