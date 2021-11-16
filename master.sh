#!/bin/bash
echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
echo deb https://pkg.jenkins.io/debian binary/ | tee /etc/apt/sources.list.d/jenkins.list

echo "Updating apt-get"
apt-get -qq update && apt-get -qq upgrade

echo "Installing default-java"
apt-get -y -q install openjdk-8-jre

echo "Installing jenkins 2.317"
wget -q "https://archives.jenkins-ci.org/debian/jenkins_2.317_all.deb"
apt-get -y install ./jenkins_2.317_all.deb
rm -f ./jenkins_2.317_all.debsu

echo "Skipping the initial setup"
echo 'JAVA_ARGS="-Djenkins.install.runSetupWizard=false"' >> /etc/default/jenkins

echo "Setting up users"
rm -rf /var/lib/jenkins/init.groovy.d
mkdir /var/lib/jenkins/init.groovy.d
cp -v /vagrant/01_globalMatrixAuthorizationStrategy.groovy /var/lib/jenkins/init.groovy.d/
cp -v /vagrant/02_createAdminUser.groovy /var/lib/jenkins/init.groovy.d/
cp -v /vagrant/03_addCredentials.groovy /var/lib/jenkins/init.groovy.d/

systemctl start jenkins
sleep 2m

echo "Installing jenkins plugins"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
rm -f jenkins_cli.jar.*
wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
while IFS= read -r line
do
  list=$list' '$line
done < /vagrant/jenkins-plugins.txt
java -jar ./jenkins-cli.jar -auth admin:$JENKINSPWD -s http://localhost:8080 install-plugin $list

echo "Restarting Jenkins"
systemctl restart jenkins
sleep 1m

echo "Copy the slave node's key"
echo "192.168.23.10 jenkins.local jenkins" >> /etc/hosts
echo "192.168.23.11 jenkinslave.local jenkinslave"  >> /etc/hosts
mkdir /var/lib/jenkins/.ssh
mv /home/vagrant/id_rsa /var/lib/jenkins/.ssh/id_rsa
mv /home/vagrant/id_rsa.pub /var/lib/jenkins/.ssh/id_rsa.pub
