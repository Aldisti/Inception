#!/bin/bash

STP_ENV="../.env"

STP_ADMIN="$(whoami)"
STP_ADMIN_PASSOWRD="password"

if [ ! -f "$STP_ENV" ]; then
	touch "$STP_ENV"
fi

read -p "Do you want to use different admin info? [y/N] " ans

if [ "$ans" = "y" ] || [ "$ans" = "yes" ]; then
	read -p "What's the admin username? " STP_ADMIN
	read -s -p "What's the admin password?" STP_PASSWORD
	echo ""
	read -p "What's the admin email?" STP_ADMIN_EMAIL
fi

read -p "Do you want to use different user info? [y/N] " ans

if [ "$ans" = "y" ] || [ "$ans" = "yes" ]; then
	read -p "What's the user username? " STP_USER
	read -s -p "What's the user password? " STP_USER_PASSWORD
	echo ""
	read -p "What's the user email? " STP_USER_EMAIL
	read -p "What's the user role? " STP_USER_ROLE
fi

sed -i "s/DOMAIN_NAME"

