# Setup a Docker Swarm cluster with 3 nodes

* Provisioned by ansible

* Using public ansible roles

# Notes
Current Vagrant file use virtualbox provisioner for demo purposes .
Change to any other provisioner by changing configuration file

# Setup

* change ansible.cfg to match your local setup

* ansible_galaxy_roles - external dependencies from other contributors
* * hostnames Role created by Antti J. Salminen in 2014 (TODO: include URL).

* ansible_roles_public - roles created by myself , available at https://Foto@bitbucket.org/MikeFoto/ansible_roles_public.git


# Usage

* Create the cluster
```bash
vagrant up
```

* Launch defined services
```bash
ansible-playbook  \
  -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \
   ansible/playbooks/swarm_run.yml 

```
