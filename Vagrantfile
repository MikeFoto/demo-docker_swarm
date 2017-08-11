# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

#
# Commons

DEFAULTS = {
  :base_image      => 'centos/7',
  :cpu             => 1,
  :memory          => 1024,
  :enabled         => false,
  :playbook        => 'unexistent_playbook_to_fail',
}.freeze

#
# Load hosts from file
hosts = {}
['hosts.yaml', 'custom_hosts.yaml'].each do |hostFile|
  if File.exists?(hostFile)
    tmpHosts = YAML.load_file(hostFile)
    hosts.merge!(tmpHosts) unless tmpHosts.nil?
  end
end


Vagrant.configure("2") do |config|
  hosts.each do |name,host|
    host = DEFAULTS.merge(host)
    next unless host[:enabled]
    config.vm.define name do |host_config|
      host_config.vm.box      = "#{host[:base_image]}"
      host_config.vm.hostname = "#{name}.swarm"
      host_config.vm.network "private_network", ip: "#{host[:ip]}"
      host_config.vm.provider "virtualbox" do |v|
        v.memory = "#{host[:memory]}"
        v.cpus   = "#{host[:cpu]}"
      end
      host_config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/playbooks/#{host[:playbook]}"
        ansible.sudo     = true
        ansible.extra_vars = {
          swarm_manager_ip:             "192.168.33.20",
          swarm_manager_inventory_name: "manager1",
          hosts_additional_hosts: [
            { address: "192.168.33.20", hostnames: [ "manager1.swarm","manager1" ] },
            { address: "192.168.33.21", hostnames: [ "manager2.swarm","manager2" ] },
            { address: "192.168.33.22", hostnames: [ "worker1.swarm","worker1" ] },
            { address: "192.168.33.23", hostnames: [ "worker2.swarm","worker2" ] },
            { address: "192.168.33.24", hostnames: [ "worker3.swarm","worker3" ] }
          ],
          swarm_role: "#{host[:swarm_role]}"
       }
       ansible.groups = {
         "local_environment" => [ "manager1","manager2",
                                  "worker1","worker2","worker3"
                                ] ,
         "leader_group"      => ["manager1"] ,
         "manager_group"     => ["manager1","manager2"] ,
         "others_group"      => ["manager2","worker1","worker2","worker3"] ,
       }
      end
    end
  end
end
