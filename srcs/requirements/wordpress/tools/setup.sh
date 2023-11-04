apt update && apt upgrade -y
apt-get install coreutils grep sed -y
apt-get install wget procps vim php php-fpm php-mysql mariadb-client -y

# download wordpress
#wget https://wordpress.org/wordpress-6.3.2.tar.gz -P /var/www
#
#cd /var/www
#tar -xzf wordpress-6.3.2.tar.gz
#rm -rf wordpress-6.3.2.tar.gz
#chown -R root:root /var/www/wordpress

PATH="/etc/php/7.3/cli/php.ini"

if [ $(cat "$PATH" | grep "clear_env" | wc -l) -eq 0 ]; then
	echo "clear_env=no" >> $PATH
else
	sed -i "s/^clear_env.*/clear_env=no/" "$PATH"
fi

if [ $(cat "$PATH" | grep "listen" | wc -l) -eq 0 ]; then
	echo "listen=wordpress:9000" >> $PATH
else
	sed -i "s/^listen.*/listen=wordpress:9000/" $PATH
fi

