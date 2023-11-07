apt update && apt upgrade -y
apt-get install wget procps vim php php-fpm php-mysql mariadb-client -y

# download wordpress
wget https://wordpress.org/wordpress-6.3.2.tar.gz -P /var/www

cd /var/www
tar -xzf wordpress-6.3.2.tar.gz
rm -rf wordpress-6.3.2.tar.gz
chown -R root:root /var/www/wordpress

# download CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# php configuration

INI_FILE="/etc/php/7.3/fpm/php.ini"

if [ $(cat "$INI_FILE" | grep "clear_env" | wc -l) -eq 0 ]; then
	echo "clear_env=no" >> $INI_FILE
else
	sed -i "s/^clear_env.*/clear_env=no/" "$INI_FILE"
fi

if [ $(cat "$INI_FILE" | grep "listen" | wc -l) -eq 0 ]; then
	echo "listen=wordpress:9000" >> $INI_FILE
else
	sed -i "s/^listen.*/listen=wordpress:9000/" $INI_FILE
fi

if [ ! -d "/run/php" ]; then
	mkdir "/run/php"
fi

# wordpress configuration

cd /var/www/wordpress

# mv 'wp-config-sample.php' 'wp-config.php'

wp config create \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=$MYSQL_HOST \
	--path='/var/www/wordpress' \
	--allow-root

wp core install \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root

wp user create \
	$WP_USER \
	$WP_USER_EMAIL \
	--user_pass=$WP_USER_PASSWORD \
	--role=$WP_USER_ROLE \
	--porcelain \
	--allow-root

