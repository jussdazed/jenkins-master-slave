#!/bin/bash

echo "deb [arch=amd64] http://nginx.org/packages/mainline/ubuntu/ bionic nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key

apt-get update
apt-get install nginx

systemctl start nginx
systemctl enable nginx

cp /home/vagrant/config.sh /etc/nginx/conf.d/nodeapp.conf
nginx -s reload

echo "Adding node"
chmod +x add-node.sh
sed -i 's/<useSecurity>true<\/useSecurity>/<useSecurity>false<\/useSecurity>/' /var/lib/jenkins/config.xml
./add-node.sh
