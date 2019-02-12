FROM php:5.6-apache-stretch
MAINTAINER Julian Labuschagne "julian.labuschagne@gmail.com"
ENV REFRESHED_AT 2019-02-12

RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev

RUN docker-php-ext-install -j$(nproc) opcache mysqli pdo_mysql zip mbstring && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

RUN a2enmod rewrite

COPY config/php.ini /usr/local/etc/php/
