#!/bin/bash

DOCKER_PATH="./srcs/tools/docker-compose.yml"

images="$(docker images -a | grep 'mariadb\|nginx\|wordpress' | awk '{print $3}' | tr '\n' '\ ')"
if [ -n "$images" ]; then
	echo "--> removing images"
	docker image rm $images
	echo "--> images removed [$?]"
else
	echo "--> no images found"
fi

network="$(docker network ls | grep 'inception' | awk '{print $1}')"
if [ -n "$network" ]; then
	echo "--> removing network"
	docker network rm $network
	echo "--> network removed [$?]"
else
	echo "--> no network found"
fi

files="$(sudo ls "$HOME/data/mariadb $HOME/data/wordpress")"
if [ -n "$files" ]; then
	echo "--> removing volume files"
	sudo rm -rf "$HOME/data/mariadb/*" "$HOME/data/wordpress/*"
	echo "--> volume files removed [$?]"
else
	echo "--> no volume files"
fi

