#!/bin/bash

ft_get_admin() {
	ans="$(tr A-Z a-z <<< "$1")"
	if [ "$ans" = "y" ] || [ "$ans" = "yes" ]; then
		read -p "What's the admin username? " STP_ADMIN
		read -sp "What's the admin password? " STP_ADMIN_PASSWORD
		echo
		read -p "What's the admin email? " STP_ADMIN_EMAIL
		read -p "What's the wordpress title? " STP_TITLE
	elif [ -n "$ans" ] && { [ "$ans" != "n" ] && [ "$ans" != "no" ]; } then
		echo "Abort."; exit 1
	fi
}

ft_get_user() {
	ans="$(tr A-Z a-z <<< "$1")"
	if [ "$ans" = "y" ] || [ "$ans" = "yes" ]; then
		read -p "What's the user username? " STP_USER
		read -sp "What's the user password? " STP_USER_PASSWORD
		echo
		read -p "What's the user email? " STP_USER_EMAIL
		read -p "What's the user role? (author, reader) " STP_USER_ROLE
	elif [ -n "$ans" ] && { [ "$ans" != "n" ] && [ "$ans" != "no" ]; } then
		echo "Abort."; exit 1
	fi
}

ft_get_mysql() {
	ans="$(tr A-Z a-z <<< "$1")"
	if [ "$ans" = "y" ] || [ "$ans" = "yes" ]; then
		read -sp "What's the root password? " STP_MYSQL_ROOT_PASSWORD
		read -p "What's the database user username? " STP_MYSQL_USER
		read -sp "What's the database user password? " STP_MYSQL_PASSWORD
		echo
		read -p "What's the database name? " STP_MYSQL_DATABASE
	elif [ -n "$ans" ] && { [ "$ans" != "n" ] && [ "$ans" != "no" ]; } then
		echo "Abort."
		exit 1
	fi
}

set_value() {
    name=$1
    value=$2

    if [ -z "${!name+x}" ] || [ -z "${!name}" ]; then
        declare -g "$name=$value"
    fi
}

# changes the value of an attribute in a file
# if it's not in the file then adds it
# arguments:
# 1 -> attribute to change
# 2 -> value to add
# 3 -> separator between attribute and value
# 4 -> file from where you want to change
ft_change_value() {
	attr="$1"
	val="$2"
	sep="$3"
	file="$4"
	if [ -z "$attr" ] || [ -z "$val" ] || [ -z "$file" ]; then
		echo "Error\n'ft_change_attr' void param"; exit 1
	fi
	grep -q "$attr$sep" "$file" && \
	sed -i "s/^$attr$sep.*/$attr$sep$val/" "$file" || \
	echo "$attr$sep$val" >> "$file"
}

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
	sed -i "s/server_name.*;/server_name $STP_DOMAIN;/g" "$STP_NGINX_CONF"
	sed -i "s/CN=.*\//CN=$STP_DOMAIN\//g" "$STP_NGINX_DOCKERFILE"
	sed -i "s/UID=.*\"/UID=$STP_ADMIN\"/g" "$STP_NGINX_DOCKERFILE"
}

STP_ENV="./srcs/.env"
STP_COMPOSE="./srcs/docker-compose.yml"
STP_NGINX_CONF="./srcs/requirements/nginx/conf/nginx.conf"
STP_NGINX_DOCKERFILE="./srcs/requirements/nginx/Dockerfile"

if [ ! -f "$STP_ENV" ]; then
	touch "$STP_ENV"
fi

read -p "Do you want to use different admin infos? [y/N] " ans
ft_get_admin "$ans"

read -p "Do you want to use different user infos? [y/N] " ans
ft_get_user "$ans"

read -p "Do you want to use different database credentials? [y/N] " ans
ft_get_mysql "$ans"

set_value "STP_TITLE" "title"
set_value "STP_ADMIN" "$(whoami)"
set_value "STP_ADMIN_PASSWORD" "password"
set_value "STP_ADMIN_EMAIL" "$STP_ADMIN@gmail.com"
set_value "STP_USER" "user"
set_value "STP_USER_PASSWORD" "password"
set_value "STP_USER_EMAIL" "$STP_USER@gmail.com"
set_value "STP_USER_ROLE" "author"
set_value "STP_MYSQL_USER" "user"
set_value "STP_MYSQL_PASSWORD" "password"
set_value "STP_MYSQL_ROOT_PASSWORD" "$STP_MYSQL_PASSWORD"
set_value "STP_MYSQL_DATABASE" "inception"
set_value "STP_DOMAIN" "$STP_ADMIN.42.$(echo "$LC_TIME" | head -c 2)"

ft_change_value "DOMAIN_NAME" "$STP_DOMAIN" "=" "$STP_ENV"
ft_change_value "WP_TITLE" "$STP_TITLE" "=" "$STP_ENV"
ft_change_value "WP_ADMIN" "$STP_ADMIN" "=" "$STP_ENV"
ft_change_value "WP_ADMIN_PASSWORD" "$STP_ADMIN_PASSWORD" "=" "$STP_ENV"
ft_change_value "WP_ADMIN_EMAIL" "$STP_ADMIN_EMAIL" "=" "$STP_ENV"
ft_change_value "WP_USER" "$STP_USER" "=" "$STP_ENV"
ft_change_value "WP_USER_PASSWORD" "$STP_USER_PASSWORD" "=" "$STP_ENV"
ft_change_value "WP_USER_EMAIL" "$STP_USER_EMAIL" "=" "$STP_ENV"
ft_change_value "WP_USER_ROLE" "$STP_USER_ROLE" "=" "$STP_ENV"
ft_change_value "MYSQL_ROOT_PASSWORD" "$STP_MYSQL_ROOT_PASSWORD" "=" "$STP_ENV"
ft_change_value "MYSQL_USER" "$STP_MYSQL_USER" "=" "$STP_ENV"
ft_change_value "MYSQL_PASSWORD" "$STP_MYSQL_PASSWORD" "=" "$STP_ENV"
ft_change_value "MYSQL_DATABASE" "$STP_MYSQL_DATABASE" "=" "$STP_ENV"

echo "enviroment variables updated successfully"

ft_update_compose
echo "docker-compose updated successfully"

ft_update_nginx

