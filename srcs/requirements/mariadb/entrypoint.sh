#!/bin/sh

# if not initialized
if [ ! -d /var/lib/mysql/mysql ]
then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql
fi

# run mysql server
mysqld --init-file=/srcs/createdb.sql
