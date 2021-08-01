FROM	alpine:3.14
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache mariadb mariadb-client
RUN		mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# copy standard cnf and init sql file
COPY	./conf/my.cnf           /etc/
COPY	./conf/createdb.sql     ./
COPY	./tools/entrypoint.sh   ./

EXPOSE		3306
VOLUME		/var/lib/mysql
ENTRYPOINT	sh ./entrypoint.sh
