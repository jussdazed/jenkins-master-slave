# -*- mode: ruby -*-
# vi: set ft-ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/bionic64"
   config.vm.network "private_network", ip: "192.168.23.10"
    master.vm.provider "virtualbox" do |v|
      v.name = "master"
     end
    master.vm.provision :shell, path: "master.sh"
    master.vm.provision :shell, path: "nginx.sh"
    master.vm.provision "file", source: "./config.sh", destination: "config.sh"
  end
end
