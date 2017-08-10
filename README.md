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

* Update the cluster
to add nodes just edit the file *hosts.yaml*

* Launch defined services
```bash
ansible-playbook  \
  -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \
  --extra-vars='swarm_manager_ip=192.168.33.20' \
   ansible/playbooks/swarm_run.yml

```

# Examples included

## Example1
* we can define any number of volumes and any option for each volume on *swarm_run.volumes.create*
* we can defined any number of services
** with associated images
** commands to run
** service options

## Example2
on top of example1 we can add tests that will run after all the services where deployed
