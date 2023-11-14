FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install openssl nginx -y

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out "/etc/nginx/ssl/certificate.crt" -keyout "/etc/nginx/ssl/private.key" -subj "/C=IT/ST=Lazio/L=Rome/O=42/OU=42/CN=ades.42.it/UID=ades"

RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]

