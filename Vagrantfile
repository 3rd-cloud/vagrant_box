# -*- mode: ruby -*-
# vi: set ft=ruby :

### Vagrant Box Update Tool ###############################
# Base Update and VirtualBox Guest Additions Install.
###########################################################

Vagrant.configure("2") do |config|

  # Base Vagrant Box
  config.vm.box = "generic/centos8"
  config.vm.provider "virtualbox"

  # Require Vagrant Plugin: VirtualBox Guest Additions
  system "vagrant plugin install vagrant-vbguest" unless Vagrant.has_plugin? 'vagrant-vbguest'

  # Optional Vagrant Plugin: vagrant-cachier
  config.cache.scope = :box if Vagrant.has_plugin? 'vagrant-cachier'

  config.vm.provider :virtualbox do |vbox|
    # Memory: 2GB
    vbox.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Provisioning
  config.vm.provision "shell", :path => "provision.sh"
end