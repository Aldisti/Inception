FROM debian:bookworm

RUN apt update
RUN apt upgrade -y
RUN apt install wget vim php php-fpm php-mysql mariadb-client -y

RUN wget https://wordpress.org/wordpress-6.3.2.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.3.2.tar.gz && rm -rf wordpress-6.3.2.tar.gz
RUN chown -R root:root /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /usr/local/bin

COPY ./tools/setup.sh /tmp/setup.sh

ENV DOMAIN_NAME=adi-stef.42.fr
ENV WP_TITLE=title
ENV WP_ADMIN=adi-stef
ENV WP_ADMIN_PASSWORD=password
ENV WP_ADMIN_EMAIL=alessandrodiste99@gmail.com

ENV WP_USER=pino
ENV WP_USER_PASSWORD=password
ENV WP_USER_EMAIL=aldisti.games@gmail.com
ENV WP_USER_ROLE=author

ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_USER=adi-stef
ENV MYSQL_PASSWORD=password
ENV MYSQL_DATABASE=inceptionDB

ENTRYPOINT ["bash", "/tmp/setup.sh"]

