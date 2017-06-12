Vagrant.configure(2) do |config|
  ####################################################################################
  # server
  config.vm.define "manager"  do |manager|
    manager.vm.box = "centos/7"
    manager.vm.network "private_network", ip: "192.168.33.20"
    manager.vm.hostname = "manager.swarm"
    manager.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
    manager.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/swarm.yml"
       ansible.extra_vars = {
         swarm_manager_ip: "192.168.33.20",
         hosts_additional_hosts: [
           { address: "192.168.33.20", hostnames: [ "manager.swarm","manager" ] },
           { address: "192.168.33.31", hostnames: [ "worker1.swarm","worker1" ] },
           { address: "192.168.33.32", hostnames: [ "worker2.swarm","worker2" ] }
         ]
       }
      ansible.groups = {
        "local_environment" => ["manager","worker1","worker2"] ,
        "manager_group"     => ["manager"] ,
        "worker_servers"    => ["worker1","worker2"] ,
      }
      ansible.sudo     = true
    end
  end
  ####################################################################################
  # worker1
  config.vm.define "worker1"  do |worker1|
    worker1.vm.box = "centos/7"
    worker1.vm.network "private_network", ip: "192.168.33.31"
    worker1.vm.hostname = "worker1.swarm"
    worker1.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
    worker1.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/swarm.yml"
      ansible.extra_vars = {
         swarm_manager_inventory_name: "manager",
         swarm_manager_ip: "192.168.33.20",
         hosts_additional_hosts: [
           { address: "192.168.33.20", hostnames: [ "manager.swarm","manager" ] },
           { address: "192.168.33.31", hostnames: [ "worker1.swarm","worker1" ] },
           { address: "192.168.33.32", hostnames: [ "worker2.swarm","worker2" ] }
         ]
       }
      ansible.groups = {
        "local_environment" => ["manager","worker1","worker2"] ,
        "manager_group"    => ["manager"] ,
        "worker_servers"   => ["worker1","worker2"] ,
      }
      ansible.sudo     = true
    end
  end
  ####################################################################################
  # server
  config.vm.define "worker2"  do |worker2|
    worker2.vm.box = "centos/7"
    worker2.vm.network "private_network", ip: "192.168.33.32"
    worker2.vm.hostname = "worker2.swarm"
    worker2.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
    worker2.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/swarm.yml"
      ansible.extra_vars = {
         swarm_manager_inventory_name: "manager",
         swarm_manager_ip: "192.168.33.20",
         hosts_additional_hosts: [
           { address: "192.168.33.20", hostnames: [ "manager.swarm","manager" ] },
           { address: "192.168.33.31", hostnames: [ "worker1.swarm","worker1" ] },
           { address: "192.168.33.32", hostnames: [ "worker2.swarm","worker2" ] }
         ]
       }
      ansible.groups = {
        "local_environment" => ["manager","worker1","worker2"] ,
        "manager_group"    => ["manager"] ,
        "worker_servers"   => ["worker1","worker2"] ,
      }
      ansible.sudo     = true
    end
  end
end
