FROM php:7.3.11-apache-stretch
MAINTAINER Julian Labuschagne "julian.labuschagne@gmail.com"
ENV REFRESHED_AT 2019-11-12

RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	libzip-dev

RUN docker-php-ext-install -j$(nproc) opcache mysqli pdo_mysql zip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

RUN a2enmod rewrite

RUN groupadd -g 1000 php && \
    useradd -r -u 1000 -g php php
