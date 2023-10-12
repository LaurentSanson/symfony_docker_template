ARG PHP_VERSION=8.2

FROM php:${PHP_VERSION}-fpm as php

RUN apt-get update \
    &&  apt-get install -y --no-install-recommends \
        locales apt-utils git libicu-dev g++ libpng-dev libxml2-dev libzip-dev libonig-dev libxslt-dev unzip nodejs npm \
\
    &&  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen  \
    &&  echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
    &&  locale-gen \
\
    &&  docker-php-ext-configure \
            intl \
    &&  docker-php-ext-install \
            pdo pdo_mysql opcache intl zip calendar dom mbstring gd xsl \
\
    &&  pecl install \
            apcu \
            xdebug \
            pcov\
    && docker-php-ext-enable \
            apcu \
            xdebug;

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -  \
    && apt-get install -y nodejs

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN mkdir /var/www/exemple

WORKDIR /var/www/exemple

RUN npm install --global yarn
