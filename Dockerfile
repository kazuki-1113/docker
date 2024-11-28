# # ベースイメージとして、pull した openpne の Docker イメージを指定
# FROM openpne/openpne3-env:latest

# COPY ../
# RUN docker-phApache24/conf/httpd.conf /etc/apache2/apache2.conf

# # Apache の設定ファイルに ServerName の設定を追加
# # RUN echo "ServerName localhost:8080" >> /etc/apache2/apache2.conf
# # RUN echo "Listen 8080" >> /etc/apache2/apache2.conf
# # RUN echo "ServerRoot "/etc/apache2"" >> /etc/apache2/apache2.conf

# # Apacheの設定を有効化
# RUN a2enmod rewrite

# # コンテナのポート 80 を公開する設定
# EXPOSE 80

# # コンテナ起動時に Apache をフォアグラウンドで実行するように設定
# CMD ["apache2ctl", "-D", "FOREGROUND"]

# 絶対できる環境
# FROM php:7.4.10-apache-buster
# FROM php:7.4.33-apache-buster
# ↓多分推奨環境に一番近い
FROM php:7.4.33-apache-bullseye

RUN apt update && apt -y upgrade
RUN apt install -y libonig-dev
# 追加
# RUN apt-get update && apt-get -y install libmysqlclient-dev
RUN docker-php-ext-install mbstring
RUN apt install -y libxml2-dev
RUN docker-php-ext-install xml
# RUN docker-php-ext-install pdo_mysql
# RUN docker-php-ext-install pdo pdo_mysql mysqlip-ext-install json
RUN apt -y install zlib1g-dev
RUN apt -y install libpng-dev
RUN apt -y install exif
RUN apt -y install mcrypt
RUN pecl install apcu
RUN docker-php-ext-enable apcu
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli

# COPY ./custom-apache2.conf /etc/apache2/apache2.conf
# COPY ./000-default.conf /etc/apache2/sites-enabled/000-default.conf
# COPY ./php.ini /usr/local/etc/php/php.ini
# COPY ./ports.conf /etc/apache2/ports.conf
# COPY ./index.php /var/www/html/OpenPNE3/web/index.php

# RUN pecl install xdebug
# RUN docker-php-ext-enable xdebug

RUN a2enmod rewrite
RUN docker-php-ext-install exif

WORKDIR /var/www/html/web

# USER root
# RUN echo "ServerName localhost:8080" >> /etc/apache2/apache2.conf
# RUN echo "Listen 8080" >> /etc/apache2/apache2.conf

# コンテナ起動時に Apache をフォアグラウンドで実行するように設定
CMD ["apache2ctl", "-D", "FOREGROUND"]