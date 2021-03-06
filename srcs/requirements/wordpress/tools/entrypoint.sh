#!/bin/sh

until echo "\q" | mariadb -h "mariadb" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" serverdb ; do
  >&2 echo "MariaDB is unavailable - sleeping"
  sleep 1
done

# if not already installed
if [ ! -f /var/www/localhost/htdocs/index.php ]
then
	cp -r /srcs/wordpress /var/www/localhost/htdocs/
	if ! $(wp core is-installed --path=/var/www/localhost/htdocs/wordpress --allow-root)
	then
		# wp installation
		wp core install --url="https://localhost/wordpress/" \
		--title=inception --admin_user=arcticfox --admin_password=admin42 \
		--admin_email=thefullarcticfox@users.noreply.github.com --skip-email \
		--path=/var/www/localhost/htdocs/wordpress --allow-root
		# wp generate some random users
		wp user generate --count=14 \
		--path=/var/www/localhost/htdocs/wordpress --allow-root
		# wp create non-admin users with password
		wp user create evaluator evaluator@21school.com \
		--role=contributor --user_pass=admin42 \
		--path=/var/www/localhost/htdocs/wordpress --allow-root
		wp user create bocal bocal@21school.com \
		--role=author --user_pass=admin42 \
		--path=/var/www/localhost/htdocs/wordpress --allow-root
		# set website theme
		wp theme install bappi --activate \
		--path=/var/www/localhost/htdocs/wordpress --allow-root
		chown -R nginx:nginx /var/www/localhost/htdocs
	fi
fi

/usr/sbin/php-fpm7 -F
