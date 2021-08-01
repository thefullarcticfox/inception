FROM	alpine:3.14
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache mariadb-client php7 php7-fpm php7-curl php7-dom php7-ftp \
		php7-gd php7-iconv php7-json php7-mbstring php7-mysqli php7-openssl \
		php7-posix php7-xml php7-xmlrpc php7-soap php7-zip php7-common php7-phar

# nginx user/group from nginx package
RUN		addgroup -Sg 82 www-data || true
RUN		addgroup -S nginx || true
RUN		adduser -S -D -H -h /var/lib/nginx -s /sbin/nologin -G nginx -g nginx nginx || true
RUN		addgroup nginx www-data || true

# download wordpress to be ready on entrypoint
RUN		wget https://wordpress.org/latest.tar.gz -O ./wordpress.tar.gz
RUN		tar -xzvf wordpress.tar.gz
# download wp-cli
ADD		https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ./
RUN		chmod +x ./wp-cli.phar && mv ./wp-cli.phar /usr/local/bin/wp
# copy configs and entrypoint
COPY	./conf/wp-config.php	./wordpress/wp-config.php
COPY	./conf/www.conf			/etc/php7/php-fpm.d/www.conf
COPY	./tools/entrypoint.sh	./

EXPOSE		9000
VOLUME		/var/www/localhost/htdocs/wordpress
ENTRYPOINT	sh ./entrypoint.sh
