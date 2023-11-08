#!/bin/sh

# echo "a"
service mariadb start
# service mariadb status
# echo "aa"

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mariadb -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

# service mysql stop

# echo "mysqld: ALL" >> /etc/hosts.allow
# mariadb -e "CREATE DATABASE $MARIADB_DATABASE;"
# mariadb -e "CREATE USER '$MARIADB_USER'@'localhost' IDENTIFIED BY '$MARIADB_USER_PASSWORD';"
# mariadb -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD';"
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"
# mariadb -uroot -p$MARIADB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# stop mariadb
# mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
exec mysqld_safe
