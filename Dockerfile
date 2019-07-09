FROM php:7.3.2-fpm

# RUN echo "Install libs & PHP extensions"
RUN apt-get update && apt-get install -y \
    zip \
    libzip-dev \
    git \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    gettext \
    locales

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

RUN docker-php-ext-configure gettext --with-gettext=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gettext \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
    zip \
    pdo_mysql \
    gd \
    intl \
    bcmath

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

USER www-data:www-data
