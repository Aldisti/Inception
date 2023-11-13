#!/bin/bash

ft_get_admin() {
	ans="$(tr A-Z a-z <<< "$1")"
	if [ "$ans" = "y" ] || [ "$ans" = "yes" ]; then
		read -p "What's the admin username? " STP_ADMIN
		read -sp "What's the admin password? " STP_ADMIN_PASSWORD
		echo
		read -p "What's the admin email? " STP_ADMIN_EMAIL
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

STP_ENV=".env"

if [ ! -f "$STP_ENV" ]; then
	touch "$STP_ENV"
fi

read -p "Do you want to use different admin infos? [y/N] " ans
ft_get_admin "$ans"

read -p "Do you want to use different user infos? [y/N] " ans
ft_get_user "$ans"

read -p "Do you want to use different database credentials? [y/N] " ans
ft_get_mysql "$ans"

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




