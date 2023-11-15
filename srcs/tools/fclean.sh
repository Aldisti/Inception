#!/bin/bash

DOCKER_PATH="./srcs/tools/docker-compose.yml"

images="$(docker images -a | grep 'mariadb\|nginx\|wordpress' | awk '{print $3}' | tr '\n' '\ ')"
if [ -n "$images" ]; then
	docker image rm $images
	echo "--> images removed [$?]"
fi

network="$(docker network ls | grep 'inception' | awk '{print $1}')"
if [ -n "$network" ]; then
	docker network rm $network
	echo "--> network removed [$?]"
fi

if [ -d "$HOME/data/mariadb" ] || [ -d "$HOME/data/wordpress" ]; then
	sudo rm -rf "$HOME/data/mariadb"
	sudo rm -rf "$HOME/data/wordpress"
	echo "--> volume files removed [$?]"
fi

