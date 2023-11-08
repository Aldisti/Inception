FROM debian:bookworm

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf


# RUN sh /tmp/setup.sh
# ENV MYSQL_ROOT_PASSWORD=password
# ENV MYSQL_USER=mysql
# ENV MYSQL_PASSWORD=password
# ENV MYSQL_DATABASE=inceptionDB
# ENV MYSQL_HOST=mariadb
# ENV MARIADB_DATABASE=inceptionDB
# ENV MARIADB_USER=aldisti
# ENV MARIADB_USER_PASSWORD=password
# ENV MARIADB_ROOT_PASSWORD=password

# EXPOSE 3306:3306

#RUN /bin/bash /tmp/setup.sh

#ENTRYPOINT ["mysqld_safe"]
ENTRYPOINT ["/bin/bash", "/tmp/setup.sh"]

