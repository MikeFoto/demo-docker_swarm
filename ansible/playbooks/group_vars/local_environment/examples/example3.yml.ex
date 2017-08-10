swarm_aux3:                              # aux values used in configuration
  exposed_ports:
    microservice1:   9080
    microservice2:   9081
    microservice3:   9082
    microservice4:   9083
  internal_ports:
    microservice1:   2000
    microservice2:   2010
    microservice3:   2020
    microservice4:   2030

swarm_run3:                              # microservice  example
  documentation: |
    pratical example of an microservice architecture with 4 service , 3 replicas for each
  test:
    - name:    test1      # basic testing to each service
      command: |
        curl --max-time 20 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.microservice1 | default(2000) }}
    - name:    test2
      command: |
        curl --max-time 20 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.microservice2 | default(2001) }}
    - name:    test3
      command: |
        curl --max-time 20 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.microservice3 | default(2002) }}
    - name:    test4
      command: |
        curl --max-time 20 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.microservice4 | default(2003) }}
    - name:    test5     # sequential test in same service
      command: |
        NUMTEST=10000
        TIMEOUT=0.1
        for i in {1..$NUMTEST}
        do
          curl --max-time $TIMEOUT {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.microservice4 | default(2003) }}
        done
  services:
    start:
      - name:     demo3_microservice_1
        image:    python
        tag:
          --replicas 3
          --publish {{ swarm_aux.exposed_ports.microservice1 | default("2000")}}:{{ swarm_aux.internal_ports.microservice1 | default("8080")}}
      - name:     demo3_microservice_2
        image:    python
        tag:      latest
        command: |
          python -m http.server {{ swarm_aux.internal_ports.microservice2 | default("8081")}}
        options:
          --replicas 3
          --publish {{ swarm_aux.exposed_ports.microservice2 | default("2001")}}:{{ swarm_aux.internal_ports.microservice2 | default("8081")}}
      - name:     demo3_microservice_3
        image:    :
    - name:    test1
      command: "curl --max-time 1 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.nginx1 }}"
    - name:    test2
      command: "curl --max-time 1 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.nginx2 }}"
  volumes:
    create:                              # define volumes here
      - name:     demo4_volume_1
        option:   "none"
  services:                               # single service at 8080
    start:
      - name:     demo4_nginx_1
        image:    nginx
        tag:      latest
        options:
          --replicas 2
          --publish {{ swarm_aux.exposed_ports.nginx1 }}:80
          --mount type=volume,source=demo_volume_1,destination=/tmp
      - name:     demo4_nginx_2
        image:    nginx
        tag:      latest
        options:
          --replicas 2
          --publish {{ swarm_aux.exposed_ports.nginx2 }}:80


