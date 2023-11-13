FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install openssl nginx -y

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

# ENV DOMAIN_NAME=adi-stef.42.fr
# ENV WP_TITLE=title
# ENV WP_ADMIN=adi-stef
# ENV WP_ADMIN_PASSWORD=password
# ENV WP_ADMIN_EMAIL=alessandrodiste99@gmail.com
# 
# ENV WP_USER=pino
# ENV WP_USER_PASSWORD=password
# ENV WP_USER_EMAIL=aldisti.games@gmail.com
# ENV WP_USER_ROLE=author
# 
# ENV MYSQL_ROOT_PASSWORD=password
# ENV MYSQL_USER=adi-stef
# ENV MYSQL_PASSWORD=password
# ENV MYSQL_DATABASE=inceptionDB

# RUN sh /tmp/setup.sh

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out "/etc/nginx/ssl/certificate.crt" -keyout "/etc/nginx/ssl/private.key" -subj "/C=IT/ST=Lazio/L=Rome/O=42/OU=42/CN=adi-stef.42.fr/UID=adi-stef"

RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# ENTRYPOINT ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["/bin/bash", "/tmp/setup.sh"]

