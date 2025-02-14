export COMPOSE_PATH_SEPARATOR=:

export COMPOSE_FILE=./docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./um11/docker-compose.yml 
export COMPOSE_FILE=$COMPOSE_FILE:./elastic11/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./kibana11/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./apigw11/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./jaeger/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./prometheus/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./grafana/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./msr-sandbox/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./apigw-init/docker-compose.yml