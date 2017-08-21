#!/bin/bash

function finish  {
  cd $GATLING_DIR
  echo "finish "
}
function usage {
  echo "GATLING_DIR=<where gatling was installed > IP=<ip to test > PORT_RANGE=<string with ports to test > OUT_DIR=<where logs and html files will be create(will be removed if exists)> $0"
}

function local_die {
  finish
  echo "$1"
  usage
  echo "# GATLING_DIR=<some dir > IP=192.168.33.20 PORT_RANGE='9080 9081 9082' OUT_DIR=/tmp/lixo1 $0"
  exit 1
}

function check_args {
  if [ -z ${PORT_RANGE+x} ]
  then
    local_die "PORT_RANGE is unset"
  fi

  if [ -z ${OUT_DIR+x} ]
  then
    local_die "OUT_DIR is unset"
  fi

  if [ -z ${IP+x} ]
  then
    local_die "IP is unset"
  fi

  if [ -z ${GATLING_DIR+x} ]
  then
    local_die "GATLING_DIR is unset"
  fi

}

function check_test {
  FILE="$TEST.scala"
  if [ -f $FILE ]
  then
    echo "test found ($FILE)"
  else
    local_die "test $FILE does not exist"
  fi

}

function update_test {
  check_test
  cp $TEST.scala $GATLING_DIR/user-files/simulations/
  if [ $? -eq 1 ]
  then
     echo "could not copy $TEST.scala to $GATLING_DIR/user-files/simulations"
     local_die
  fi
}

function setup {
  check_args
  update_test
  cd $GATLING_DIR
  if [ $? -eq 1 ]
  then
     echo "GATLING_DIR is $GATLING_DIR and not found"
     local_die
  fi
  rm -rf $OUT_DIR
  mkdir -p $OUT_DIR
}

export TEST=OneServiceStress
export START_DIR=`pwd`
setup

export DELAY=0
#export USERS=15
for USERS in 1 5
do
  #export PAGES=10
  for PAGES in 1 5
  do
    for PORT in $PORT_RANGE
    do
      export LOGFILE="$OUT_DIR/log-output.txt"
      export DESC_DETAIL="pages=$PAGES users=$USERS pause=$DELAY url=http://$IP:$PORT"
      JAVA_OPTS="-Dpages=$PAGES -Dusers=$USERS -Dpause=$DELAY -Durl=http://$IP:$PORT"  \
        ./bin/gatling.sh  \
      	   --simulation $TEST \
      	   --output-name IndividualSimulation \
      	   --run-description "docker swarm IndividualSimulation $DESC_DETAIL " \
      	   --results-folder="$OUT_DIR/PORT_${PORT}_USERS_${USERS}_PAGES_${PAGES}" \
            >> $LOGFILE
      if [ $? -eq 1 ]
      then
         echo "gatling failed"
         local_die
      fi
    done
  done
done
