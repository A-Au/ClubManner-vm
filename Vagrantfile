# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.12.2"
  #config.vm.network "forwarded_port", guest: 5432, host: 54321

  #config.ssh.username = "ubuntu"
  #config.ssh.password = "password"

  config.vm.provision "shell", inline: "/vagrant/setup/setup.sh"

  config.vm.synced_folder "../.", "/home/ubuntu/git"
end
