# -*- mode: ruby -*-
# vi: set ft-ruby :

Vagrant.configure("2") do |config|
  config.vm.define "slave" do |slave|
    slave.vm.box = "ubuntu/bionic64"
    slave.vm.network "private_network", ip: "192.168.23.11"
    slave.vm.provider "virtualbox" do |v|
      v.name = "slave"
     end
    slave.vm.provision "file", source: "./id_rsa.pub", destination: "/home/vagrant/authorized_keys"
    slave.vm.provision :shell, path: "slave.sh"

  end
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.network "private_network", ip: "192.168.23.10"
    master.vm.provider "virtualbox" do |v|
      v.name = "master"
    end
    master.vm.provision "file", source: "./id_rsa", destination: "/home/vagrant/id_rsa"
    master.vm.provision "file", source: "./id_rsa.pub", destination: "/home/vagrant/id_rsa.pub"
    master.vm.provision "file", source: "./add-node.sh", destination: "add-node.sh"
    master.vm.provision :shell, path: "master.sh"
    master.vm.provision "file", source: "./config.sh", destination: "config.sh"
    master.vm.provision :shell, path: "nginx.sh"
  end
end
