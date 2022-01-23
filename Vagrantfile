# -*- mode: ruby -*-
# vi: set ft=ruby :
PRIMARY_NODES=2
DATA_NODES=1

# Primary => 192.168.57.6
# Data Node => 192.168.57.101

unless Vagrant.has_plugin?('vagrant-hostmanager')
  puts 'Installing vagrant-hostmanager Plugin...'
  system('vagrant plugin install vagrant-hostmanager')
end

Vagrant.configure("2") do |config|
  config.vm.box = "elastic/ubuntu-16.04-x86_64"

  if Vagrant.has_plugin?("vagrant-hostmanager")
    # Disable the default hostmanager behavior
    config.hostmanager.enabled = false

    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    # hostmanager provisioner
    config.vm.provision :hostmanager
end

  # Primary Nodes
  (1..PRIMARY_NODES).each do |i|
    config.vm.synced_folder "shared/", "/home/vagrant"
    config.vm.define "es-primary-#{format('%02d', i)}" do |node|
      node.vm.hostname = "es-primary-#{format('%02d', i)}"
      node.hostmanager.aliases = [
        "es-primary-#{format('%02d', i)}.vm.cluster.local",
        "es.vm.cluster.local"
      ]
      node.vm.network "private_network", ip: "192.168.57.#{5+i}", hostname: true
      node.vm.provision :shell, :name => "Bootstrap", :path => "bootstrap.sh"
      node.vm.provision :shell, :name => "Configure ES - Primary", :path => "configure_esp.sh"
      node.vm.provision :shell, :name => "Start ES", :path => "start_es.sh"
    end
  end
  
  # Data Nodes
  (1..DATA_NODES).each do |i|
    config.vm.synced_folder "shared/", "/home/vagrant"
    config.vm.define "es-data-#{format('%02d', i)}" do |node|
      node.vm.hostname = "es-data-#{format('%02d', i)}"
      node.hostmanager.aliases = [
        "es-data-#{format('%02d', i)}.vm.cluster.local",
        "es.vm.cluster.local"
      ]
      node.vm.network "private_network", ip: "192.168.57.#{100+i}", hostname: true
      node.vm.provision :shell, :name => "Bootstrap", :path => "bootstrap.sh"
      node.vm.provision :shell, :name => "Configure ES - Data", :path => "configure_esd.sh"
      node.vm.provision :shell, :name => "Start ES", :path => "start_es.sh"
    end
  end
end