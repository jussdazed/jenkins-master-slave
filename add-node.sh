#!/bin/bash

cat <<EOF | java -jar ./jenkins-cli.jar -auth admin:$JENKINSPWD -s http://localhost:8080 create-node Slave1
<slave>
  <name>Slave 1</name>
  <description></description>
  <remoteFS>/home/jenkins</remoteFS>
  <numExecutors>5</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
  <launcher class="hudson.plugins.sshslaves.SSHLauncher" plugin="ssh-slaves@1.10">
    <host>192.168.23.11</host>
    <port>22</port>
    <credentialsId>jopa</credentialsId>
    <maxNumRetries>0</maxNumRetries>
    <retryWaitTime>0</retryWaitTime>
  </launcher>
  <label>slave</label>
  <nodeProperties/>
  <userId>jeff@mymiller.name</userId>
</slave>
EOF
