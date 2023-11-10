# download wordpress

#cd /var/www
#tar -xzf wordpress-6.3.2.tar.gz
#rm -rf wordpress-6.3.2.tar.gz
#chown -R root:root /var/www/wordpress

# download CLI
# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# mv wp-cli.phar /usr/local/bin/wp

# mv /usr/local/bin/wp-cli.phar /usr/local/bin/wp
chmod +x /usr/local/bin/wp-cli.phar

# php configuration

INI_FILE="/etc/php/8.2/fpm/pool.d/www.conf"

# if [ $(cat "$INI_FILE" | grep "clear_env" | wc -l) -eq 0 ]; then
# 	echo "clear_env=no" >> $INI_FILE
# else
# 	sed -i "s/^clear_env.*/clear_env=no/" "$INI_FILE"
# fi

if [ $(cat "$INI_FILE" | grep "listen" | wc -l) -eq 0 ]; then
	echo "listen=wordpress:9000" >> $INI_FILE
else
	sed -i "s/^listen.*/listen = 9000/" $INI_FILE
fi

if [ ! -d "/run/php" ]; then
	mkdir "/run/php"
fi

# wordpress configuration

cd /var/www/wordpress

sleep 5

# mv 'wp-config-sample.php' 'wp-config.php'
echo "'config create'"
wp-cli.phar config create \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb:3306 \
	--path='/var/www/wordpress' \
	--allow-root

echo "'core install'"
wp-cli.phar core install \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email="$WP_ADMIN_EMAIL" \
	--skip-email \
	--allow-root

echo "'user create'"
wp-cli.phar user create \
	$WP_USER \
	"$WP_USER_EMAIL" \
	--user_pass=$WP_USER_PASSWORD \
	--role=$WP_USER_ROLE \
	--porcelain \
	--allow-root

/usr/sbin/php-fpm8.2 -F

