#!/bin/bash

ft_update_compose() {
	if [ ! -d "/home/$(whoami)/data/mariadb" ]; then
		mkdir -p "/home/$(whoami)/data/mariadb"
	fi
	if [ ! -d "/home/$(whoami)/data/wordpress" ]; then
		mkdir -p "/home/$(whoami)/data/wordpress"
	fi
	sed -i "s_/home/.*/data_/home/$(whoami)/data_" "$STP_COMPOSE"
}

ft_update_nginx() {
	if [ ! -f "$STP_NGINX_CONF" ]; then
		return 1
	fi
	sed -i "s/server_name.*;/server_name $DOMAIN_NAME;/g" "$STP_NGINX_CONF"
	sed -i "s/CN=.*\//CN=$DOMAIN_NAME\//g" "$STP_NGINX_DOCKERFILE"
	sed -i "s/UID=.*\"/UID=$(whoami)\"/g" "$STP_NGINX_DOCKERFILE"
}

ft_update_hosts() {
	if grep -q "^$STP_IP[[:space:]]*$DOMAIN_NAME$" "$STP_HOSTS"; then
		return 0
	fi
	sudo sed -i "0,/^$/ s/^$/$STP_IP $DOMAIN_NAME\n/" "$STP_HOSTS"
}

STP_IP="127.0.2.1"
STP_ENV="./srcs/.env"
STP_HOSTS="/etc/hosts"
STP_COMPOSE="./srcs/docker-compose.yml"
STP_NGINX_CONF="./srcs/requirements/nginx/conf/nginx.conf"
STP_NGINX_DOCKERFILE="./srcs/requirements/nginx/Dockerfile"

STP_VARS=("DOMAIN_NAME" "WP_TITLE" "WP_ADMIN" "WP_ADMIN_PASSWORD" \
	"WP_ADMIN_EMAIL" "WP_USER" "WP_USER_PASSWORD" "WP_USER_EMAIL" \
	"WP_USER_ROLE" "MYSQL_ROOT_PASSWORD" "MYSQL_USER" "MYSQL_PASSWORD" \
	"MYSQL_DATABASE")

if [ ! -f "$STP_ENV" ]; then
	touch "$STP_ENV"
fi

for var in ${STP_VARS[@]}; do
	tmp="$(grep $var= $STP_ENV | cut -d '=' -f2-)"
	if [ -z "$tmp" ]; then
		if grep -q "PASSWORD" <<< "$var"; then
			read -sp "Insert '$var' value: " value; echo
		else
			read -p "Insert '$var' value: " value
		fi
		declare "$var=$value"
		if grep -q "$var" "$STP_ENV"; then
			sed -i "s/$var=.*/$var=$value/" "$STP_ENV"
		else
			echo "$var=$value" >> "$STP_ENV"
		fi
	else
		declare "$var=$tmp"
	fi
done && echo "'.env' updated"

ft_update_compose && echo "'docker-compose' updated"

ft_update_nginx && echo "'nginx' updated"

ft_update_hosts && echo "'hosts' updated"


