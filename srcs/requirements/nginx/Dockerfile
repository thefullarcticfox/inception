FROM	alpine:3.12
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache nginx openssl openssh
RUN		mkdir -p /run/nginx && chown -R nginx:nginx /run/nginx

# copy indexpage and configs
COPY	./conf/localhost.conf		/etc/nginx/conf.d/default.conf
COPY	./conf/localhost.csr.cnf	/etc/ssl/certs/localhost.csr.cnf
COPY	./conf/sshd_config			/etc/ssh/
COPY	./conf/v3.ext				/etc/ssl/certs/v3.ext
COPY	./tools/index.html			/var/www/localhost/htdocs

# checking www-data: 82 is the standard uid/gid for "www-data" in Alpine
# RUN	addgroup -g 82 -S www-data; adduser -u 82 -D -S -G www-data www-data
# RUN	sed -i 's/user nginx;/user www-data;/g' /etc/nginx/nginx.conf
RUN		chown -R nginx:nginx /var/www/localhost/htdocs

# ssl rootCA cert/key generation
RUN		openssl genrsa -out /etc/ssl/private/rootCA.key 4096
RUN		openssl req -x509 -new -nodes -key /etc/ssl/private/rootCA.key \
		-sha256 -days 365 -out /etc/ssl/certs/rootCA.crt \
		-subj "/C=RU/ST=Moscow/L=Moscow/O=42/OU=21/CN=localhost"
# ssl server cert/key generation
RUN		openssl req -new -sha256 -nodes -out /etc/ssl/certs/localhost.csr \
		-newkey rsa:4096 -keyout /etc/ssl/private/localhost.key \
		-config /etc/ssl/certs/localhost.csr.cnf
RUN		openssl x509 -req -in /etc/ssl/certs/localhost.csr \
		-CA /etc/ssl/certs/rootCA.crt -CAkey /etc/ssl/private/rootCA.key \
		-CAcreateserial -out /etc/ssl/certs/localhost.crt \
		-days 365 -sha256 -extfile /etc/ssl/certs/v3.ext
# dhparam for tls
RUN		openssl dhparam -out /etc/ssl/certs/dhparam.pem 1024

# ssh keys generation and config + user creation/password change
RUN		ssh-keygen -A
RUN		adduser -D admin && \
		echo "admin:admin42" | chpasswd && echo "root:admin42" | chpasswd

EXPOSE		22 80 443
ENTRYPOINT	nginx -g "daemon off;"
