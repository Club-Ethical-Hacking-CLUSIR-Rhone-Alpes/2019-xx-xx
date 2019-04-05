FROM alpine:edge
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk upgrade && apk add \
	bash apache2 php7-apache2 curl ca-certificates openssl openssh git php7 php7-phar php7-json php7-iconv php7-openssl tzdata openntpd nano
RUN apk add \
	php7-ftp \
	php7-xdebug \
	php7-mcrypt \
	php7-mbstring \
	php7-soap \
	php7-gmp \
	php7-pdo_odbc \
	php7-dom \
	php7-pdo \
	php7-zip \
	php7-mysqli \
	php7-sqlite3 \
	php7-pdo_pgsql \
	php7-bcmath \
	php7-gd \
	php7-odbc \
	php7-pdo_mysql \
	php7-pdo_sqlite \
	php7-gettext \
	php7-xmlreader \
	php7-xmlwriter \
	php7-tokenizer \
	php7-xmlrpc \
	php7-bz2 \
	php7-pdo_dblib \
	php7-curl \
	php7-ctype \
	php7-session \
	php7-redis \
	php7-exif
RUN apk add php7-simplexml
RUN cp /usr/bin/php7 /usr/bin/php \
    && rm -f /var/cache/apk/*
RUN echo '${CEH_LeShellAuxSeychelles}' > /flag
RUN echo "ssh igor@172.31.254.200 -p 2222 | echo \"Zh1v0yPut1n\"" > /connection.sh
RUN mkdir -p /run/apache2 \
    && sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ headers_module/LoadModule\ headers_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ security2_module/LoadModule\ security2_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_module/LoadModule\ session_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_cookie_module/LoadModule\ session_cookie_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_crypto_module/LoadModule\ session_crypto_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ deflate_module/LoadModule\ deflate_module/" /etc/apache2/httpd.conf \
    && sed -i "s#^DocumentRoot \".*#DocumentRoot \"/app/server\"#g" /etc/apache2/httpd.conf \
    && sed -i "s#/var/www/localhost/htdocs#/app/server#" /etc/apache2/httpd.conf \
    && printf "\n<Directory \"/app/server\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf
RUN mkdir /app && mkdir /app/server && mkdir /app/server/api && chown -R apache:apache /app && chmod -R 777 /app && mkdir bootstrap
RUN chown -R apache:apache /app
ADD src/entrypoint.sh /bootstrap/
ADD src/dist/web /app/server
ADD src/db.json /app/server/api/db.json
ADD src/img/ /app/server/api/img/
ADD src/index.php /app/server/api/index.php
ADD src/.htaccess /app/server/.htaccess
RUN chmod 777 -R /app/server/api/img
RUN chmod +x /bootstrap/entrypoint.sh
EXPOSE 80
ENTRYPOINT ["/bootstrap/entrypoint.sh"]
