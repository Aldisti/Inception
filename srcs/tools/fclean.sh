#!/bin/bash

DOCKER_PATH="./srcs/tools/docker-compose.yml"

images="$(docker images -a | \
	grep 'mariadb\|nginx\|wordpress' | \
	awk '{print $3}' | tr '\n' '\ ')"
if [ ! "$images" = "" ]; then
	echo "--> removing images"
	docker image rm "$images"
	echo "--> images removed [$?]"
else
	echo "--> no images found"
fi

network="$(docker network ls | \
	grep 'inception' | \
	awk '{print $1}')"
if [ ! "$network" = "" ]; then
	echo "--> removing network"
	docker network rm "$network"
	echo "--> network removed [$?]"
else
	echo "--> no network found"
fi

echo "--> removing volumes' files"
rm -rf "$HOME/data/mariadb/*" "$HOME/data/wordpress/*"
echo "--> volumes' files removed [$?]"

