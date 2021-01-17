FROM php:7.4-fpm

WORKDIR /home/nugraha/sites/

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql

RUN groupadd -g 1000 nugraha
RUN useradd -u 1000 -ms /bin/bash -g nugraha nugraha

USER nugraha

EXPOSE 9000

CMD [ "php-fpm" ]