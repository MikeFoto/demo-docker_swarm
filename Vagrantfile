Vagrant.configure(2) do |config|
  ####################################################################################
  # server
  config.vm.define "manager"  do |manager|
    manager.vm.box = "centos/7"
    config.vm.network "public_network", bridge: "wlan0"
    config.vm.network "private_network", ip: "192.168.33.20"
    config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/manager.yml"
       ansible.extra_vars = {
         swarn_manager_ip: "192.168.33.20"
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
    config.vm.network "public_network", bridge: "wlan0"
    config.vm.network "private_network", ip: "192.168.33.31"
    config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/worker.yml"
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
    worker2.vm.box = "centos/6"
    config.vm.network "public_network", bridge: "wlan0"
    config.vm.network "private_network", ip: "192.168.33.32"
    config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/worker.yml"
      ansible.groups = {
        "local_environment" => ["manager","worker1","worker2"] ,
        "manager_group"    => ["manager"] ,
        "worker_servers"   => ["worker1","worker2"] ,
      }
      ansible.sudo     = true
    end
  end
end
