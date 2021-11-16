#!/bin/bash

apt-get update
apt-get install openjdk-8-jre-headless

echo "Configuration on slave"
sh -c 'echo "192.168.23.10 jenkins.local jenkins" >> /etc/hosts'
sh -c 'echo "192.168.23.11 jenkinslave.local jenkinslave"  >> /etc/hosts'
groupadd jenkins
useradd -m -d /var/lib/jenkins -g jenkins jenkins
sh -c 'echo "jenkins:jenkins" | chpasswd'
mkdir -p /var/lib/jenkins/.ssh
mv /home/vagrant/authorized_keys /var/lib/jenkins/.ssh/authorized_keys
chown jenkins:jenkins /var/lib/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /var/lib/jenkins/.ssh
