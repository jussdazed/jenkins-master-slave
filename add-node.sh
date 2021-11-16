#!/bin/bash

JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
cat <<EOF | java -jar ./jenkins-cli.jar -auth 'admin:$JENKINSPWD' -s http://192.168.23.10 create-node Slave1
<slave>
  <name>Slave 1</name>
  <description>new slave</description>
  <remoteFS>/home/vagrant</remoteFS>
  <numExecutors>5</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.plugins.sshslaves.SSHLauncher" plugin="ssh-slaves@1.10">
    <host>192.168.23.11</host>
    <port>22</port>
    <credentialsId>jenkins</credentialsId>
    <maxNumRetries>0</maxNumRetries>
    <retryWaitTime>0</retryWaitTime>
  </launcher>
  <label>slave</label>
  <nodeProperties/>
  <userId></userId>
</slave>
EOF
