swarm_aux2:                              # aux values used in configuration
  exposed_ports:
    nginx1:         8080
    nginx2:         8081

swarm_run2:                              # nginx example
  documentation: |
    on top of example1 we can add tests that will run after all the services where deployed
  test:
    - name:    test1
      command: "curl --max-time 1 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.nginx1 }}"
    - name:    test2
      command: "curl --max-time 1 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.nginx2 }}"
  volumes:
    create:                              # define volumes here
      - name:                             # single service at 8080
    start:
      - name:     demo2_nginx_1
        image:    nginx
        tag:      latest
        options:
          --replicas 3
          --publish {{ swarm_aux.exposed_ports.nginx1 }}:80       # Access service on 8080 @ any swarm host
      - name:     demo2_nginx_2
        image:    nginx
        tag:      latest
        options:
          --replicas 3
          --publish {{ swarm_aux.exposed_ports.nginx2 }}:80       # Access service on 8081 @ any swarm host

