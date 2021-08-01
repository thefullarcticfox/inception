FROM	alpine:3.12
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache mariadb mariadb-client
RUN		mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# copy standard cnf and init sql file
COPY	./my.cnf /etc/
COPY	./createdb.sql ./
COPY	./entrypoint.sh ./

EXPOSE		3306
VOLUME		/var/lib/mysql
ENTRYPOINT	sh ./entrypoint.sh
