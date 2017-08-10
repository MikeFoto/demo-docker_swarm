swarm_aux:                              # aux values used in configuration
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

swarm_run:                              # microservice  example
  documentation: |
    pratical example of an microservice architecture with 4 service , 3 replicas for each
  test:
    - name:    test1      # basic testing to each service
      command: |
        curl --max-time 20 {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.microservice1 | default(2000) }}
    # - name:    test5     # sequential test in same service
    #   command: |
    #     NUMTEST=10000
    #     TIMEOUT=0.1
    #     for i in {1..$NUMTEST}
    #     do
    #       curl --max-time $TIMEOUT {{ swarm_manager_ip }}:{{ swarm_aux.exposed_ports.microservice4 | default(2003) }}
    #     done
  services:
    start:
      - name:     demo_microservice_2
        image:    python
        tag:      latest
        command: |
          python -m http.server {{ swarm_aux.internal_ports.microservice2 | default("8081")}}
        options:
          --replicas 1
          --publish {{ swarm_aux.exposed_ports.microservice2 | default("2001")}}:{{ swarm_aux.internal_ports.microservice2 | default("8081")}}
      - name:     demo_microservice_3
        image:    :
