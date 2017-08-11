# Setup a Docker Swarm cluster with arbitrary number of  nodes

* Provisioned by ansible

* Using public ansible roles

# Notes

Current Vagrant file use virtualbox provisioner for demo purposes .
Change to any other provisioner by changing configuration file

# Setup

* change ansible.cfg to match your local setup

* change hosts.yml with your desired configuration . In each node #Cpus, memory and role can be configured

* One private network is used (192.168.33.0/24 ). Change it (on Vagrantfile and hosts.yaml ) if conflicts with existing ones.

# Dependencies

* ansible_galaxy_roles - external dependencies from other contributors
** hostnames Role created by Antti J. Salminen in 2014 (TODO: include URL).

* My public roles
** ansible_repos - git clone https://MikeFoto@bitbucket.org/MikeFoto/ansible_repos.git
** ansible_packages - git clone https://MikeFoto@bitbucket.org/MikeFoto/ansible_packages.git
** ansible_firewalld - git clone https://MikeFoto@bitbucket.org/MikeFoto/ansible_firewalld.git
** ansible_docker_ce_centos_install - git clone https://MikeFoto@bitbucket.org/MikeFoto/ansible_docker_ce_centos_install.git
** ansible_docker_swarm_manager - git clone https://MikeFoto@bitbucket.org/MikeFoto/ansible_docker_swarm_manager.git
** ansible_docker_swarm_node - git clone https://MikeFoto@bitbucket.org/MikeFoto/ansible_docker_swarm_node.git

# Usage

* Create the cluster
This Command just creates the cluster without any services running
```bash
vagrant up
```

* Update the cluster (Optional)
to add nodes just edit the file *hosts.yaml* and run the command again.

* Launch defined services
```bash
ansible-playbook  \
  -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \
  --extra-vars='swarm_manager_ip=192.168.33.20' \
   ansible/playbooks/swarm_run.yml
```
All services are defined using ansible_docker_swarm role. Check examples

# License

MIT

# Author Information

Created by Miguel Rodrigues.
