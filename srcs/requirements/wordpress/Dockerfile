FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install wget vim php php-fpm php-mysql mariadb-client -y

RUN wget https://wordpress.org/wordpress-6.3.2.tar.gz -P /var/www
RUN wget -P /usr/local/bin https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

COPY ./tools/setup.sh /tmp/setup.sh

CMD ["bash", "/tmp/setup.sh"]



