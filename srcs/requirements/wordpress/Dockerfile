FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install wget vim php php-fpm php-mysql mariadb-client -y

RUN wget https://wordpress.org/wordpress-6.3.2.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.3.2.tar.gz && rm -rf wordpress-6.3.2.tar.gz
RUN chown -R root:root /var/www/wordpress
RUN wget -P /usr/local/bin https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

COPY ./tools/setup.sh /tmp/setup.sh

ENTRYPOINT ["bash", "/tmp/setup.sh"]



