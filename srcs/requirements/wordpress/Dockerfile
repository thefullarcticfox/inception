FROM	alpine:3.12
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache php7 php7-fpm php7-curl php7-dom php7-ftp \
		php7-gd php7-iconv php7-json php7-mbstring php7-mysqli php7-openssl \
		php7-posix php7-xml php7-xmlrpc php7-soap php7-zip php7-common php7-phar

# download wordpress to be ready on entrypoint
ADD		https://wordpress.org/latest.tar.gz ./wordpress.tar.gz
RUN		tar -xzvf wordpress.tar.gz
# download wp-cli
ADD		https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ./
RUN		chmod +x ./wp-cli.phar && mv ./wp-cli.phar /usr/local/bin/wp
# copy configs and entrypoint
COPY	./wp-config.php ./wordpress/wp-config.php
COPY	./entrypoint.sh ./

EXPOSE		5050
VOLUME		/var/www/localhost/htdocs
ENTRYPOINT	sh ./entrypoint.sh
