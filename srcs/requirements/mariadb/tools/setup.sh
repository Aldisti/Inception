#!/bin/sh

service mariadb start && \

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" && \
sleep .1 && \

mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" && \
sleep .1 && \

mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" && \
sleep .1 && \

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" && \
sleep .1 && \

mariadb -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;" && \
sleep .1 && \

mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

unset MYSQL_PASSWORD MYSQL_ROOT_PASSWORD

exec mysqld_safe
