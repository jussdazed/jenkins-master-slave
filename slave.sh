#!/bin/bash

sudo apt-get update
sudo apt-get install openjdk-8-jre-headless

echo "Configuration on slave"
sudo sh -c 'echo "192.168.23.10 jenkins.local jenkins" >> /etc/hosts'
sudo sh -c 'echo "192.168.23.11 jenkinslave.local jenkinslave"  >> /etc/hosts'
sudo groupadd jenkins
sudo useradd -m -d /var/lib/jenkins -g jenkins jenkins
sudo sh -c 'echo "jenkins:jenkins" | chpasswd'
sudo mkdir -p /var/lib/jenkins/.ssh
sudo mv /home/vagrant/authorized_keys /var/lib/jenkins/.ssh/authorized_keys
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/authorized_keys
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
