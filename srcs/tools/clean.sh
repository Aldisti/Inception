#!/bin/bash

DOCKER_PATH="../docker-compose.yml"

echo "--> doing compose down"
docker compose -f $DOCKER_PATH compose down
echo "--> compose down completed [$?]"

volumes="$(docker volume ls -q | grep 'mariadb\|wordpress')"
if [ ! "$volumes" = "" ]; then
	echo "--> removing docker volumes"
	docker volume rm "$volumes"
	echo "--> docker volumes removed [$?]"
else
	echo "--> no volumes found"
fi

containers="$(docker ps -a | \
	grep 'mariadb\|wordpress\|nginx' | \
	awk '{print $1}' | \
	tr '\n' '\ ')"
if [ ! "$containers" = "" ]; then
	echo "--> removing containers"
	docker rm "$containers"
	echo "--> containers removed [$?]"
else
	echo "--> no containers found"
fi

