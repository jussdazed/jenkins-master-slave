#!/bin/bash

echo "deb [arch=amd64] http://nginx.org/packages/mainline/ubuntu/ bionic nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

sudo apt update
sudo apt install nginx

sudo systemctl start nginx
sudo systemctl enable nginx

sudo su -c "cp /home/vagrant/config.sh /etc/nginx/conf.d/nodeapp.conf"
sudo su -c "mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled"
sudo nginx -t
sudo nginx -s reload
