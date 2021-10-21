#!/bin/bash
echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

echo "Updating apt-get"
sudo apt-get -qq update && sudo apt-get -qq upgrade

echo "Installing default-java"
sudo apt-get -y -q install openjdk-8-jre

echo "Installing jenkins 2.222"
wget -q "http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_2.222.4_all.deb"
sudo apt-get -y install ./jenkins_2.222.4_all.deb
rm -f ./jenkins_2.222.4_all.deb
echo "Skipping the initial setup"
echo 'JAVA_ARGS="-Djenkins.install.runSetupWizard=false"' >> /etc/default/jenkins

echo "Setting up users"
sudo rm -rf /var/lib/jenkins/init.groovy.d
sudo mkdir /var/lib/jenkins/init.groovy.d
sudo cp -v /vagrant/01_globalMatrixAuthorizationStrategy.groovy /var/lib/jenkins/init.groovy.d/
sudo cp -v /vagrant/02_createAdminUser.groovy /var/lib/jenkins/init.groovy.d/

sudo service jenkins start


echo "Installing jenkins plugins"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
rm -f jenkins_cli.jar.*
wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
while IFS= read -r line
do
  list=$list' '$line
done < /vagrant/jenkins-plugins.txt
java -jar jenkins-cli.jar -auth admin:$JENKINSPWD -s http://localhost:8080 install-plugin $list

echo "Restarting Jenkins"
sudo service jenkins restart
