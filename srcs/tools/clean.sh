#!/bin/bash

DOCKER_PATH="./srcs/docker-compose.yml"

docker compose -f "$DOCKER_PATH" down
echo "--> compose down completed [$?]"

containers="$(docker ps -a | grep 'mariadb\|wordpress\|nginx' | \
	awk '{print $1}' | tr '\n' '\ ')"
if [ -n "$containers" ]; then
	docker rm $containers
	echo "--> containers removed [$?]"
fi

volumes="$(docker volume ls -q | grep 'mariadb\|wordpress')"
if [ -n "$volumes" ]; then
	docker volume rm $volumes
	echo "--> docker volumes removed [$?]"
fi

