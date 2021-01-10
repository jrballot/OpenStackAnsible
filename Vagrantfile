# -*- mode: ruby -*-
# vi: set ft=ruby :

# Definição de maquinas do Laboratório de MongoDB
machines = {
	"controller"  => { "memory" => "4096", "cpus" => "1" },
	#"network"     => { "memory" => "1024", "cpus" => "1" },
	"compute01"   => { "memory" => "2048", "cpus" => "1" },
	"compute02"   => { "memory" => "2048", "cpus" => "1" },
	#"block"       => { "memory" => "512", "cpus" => "1" },
	#"object01"    => { "memory" => "512", "cpus" => "1" },
	#"object02"    => { "memory" => "512", "cpus" => "1" },
}

Vagrant.configure("2") do |config|
  machines.each do |name,conf|
    config.vm.boot_timeout = 120
    config.vm.define "#{name}" do |srv|
      srv.vm.box = "centos/8"
      srv.vm.hostname = "#{name}.example.com"
      srv.vm.provider 'virtualbox' do |vb|
        vb.name = "#{name}"
        vb.memory = "#{conf["memory"]}"
        vb.cpus = "#{conf["cpus"]}"
      end
      
      # Define VM network for Controller Node
      if "#{name}" == "controller"
	srv.vm.network 'private_network', ip: "192.168.100.10", virtualbox__intnet: "management"
	srv.vm.network 'public_network', ip:"192.168.0.10", bridge: "eth1"
      end

      # Define VM for Network Node
      if "#{name}" == "network"
	srv.vm.network 'private_network', ip: "192.168.100.11", virtualbox__intnet: "management"
	srv.vm.network 'public_network', ip:"192.168.0.11", bridge: "eth1"
	srv.vm.network 'private_network', ip: "192.168.110.11", virtualbox__intnet: "guest"
      end
      
      # Define VMs for Compute Nodes
      if "#{name}" == "compute01"
	srv.vm.network 'private_network', ip: "192.168.100.12", virtualbox__intnet: "management"
	srv.vm.network 'private_network', ip: "192.168.110.12", virtualbox__intnet: "guest"
	srv.vm.network 'private_network', ip: "192.168.120.12", virtualbox__intnet: "storage"
      end
      if "#{name}" == "compute02"
	srv.vm.network 'private_network', ip: "192.168.100.13", virtualbox__intnet: "management"
	srv.vm.network 'private_network', ip: "192.168.110.13", virtualbox__intnet: "guest"
	srv.vm.network 'private_network', ip: "192.168.120.13", virtualbox__intnet: "storage"
      end

      # Define VM for Block Storage
      if "#{name}" == "block"
	srv.vm.network 'private_network', ip: "192.168.100.14", virtualbox__intnet: "management"
	srv.vm.network 'private_network', ip: "192.168.120.14", virtualbox__intnet: "storage"
      end
    
      #srv.vm.provision "ansible" do |ansible|
      #  ansible.verbose = '-vvv'
      #  ansible.playbook = "playbook.yml"
      #end

      srv.vm.provision "shell", inline: "dnf update -y"

    end
  end
end
