# download wordpress

chmod +x /usr/local/bin/wp-cli.phar

# php configuration

if [ ! -d "/run/php" ]; then
	mkdir "/run/php"
fi

# wordpress configuration

cd /var/www/wordpress

sleep 5

if [ ! -f "wp-config.php" ]; then
	echo "--> 'config create'"
	wp-cli.phar config create \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path='/var/www/wordpress' \
		--allow-root

	echo "--> 'core install'"
	wp-cli.phar core install \
		--url=$DOMAIN_NAME \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email \
		--allow-root

	echo "--> 'user create'"
	wp-cli.phar user create \
		$WP_USER \
		"$WP_USER_EMAIL" \
		--user_pass=$WP_USER_PASSWORD \
		--role=$WP_USER_ROLE \
		--porcelain \
		--allow-root
fi

/usr/sbin/php-fpm8.2 -F

