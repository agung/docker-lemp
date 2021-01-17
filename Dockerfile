FROM php:7.4-fpm

WORKDIR /home/nugraha/

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
        mysqli pdo_mysql soap xsl zip sockets bcmath intl

RUN docker-php-ext-install opcache

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.19

RUN groupadd -g 1000 nugraha
RUN useradd -u 1000 -ms /bin/bash -g nugraha nugraha

USER nugraha

EXPOSE 9000

CMD [ "php-fpm" ]