FROM php:7.2-fpm

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

# install php extension
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
        mysqli pdo_mysql soap xsl zip sockets bcmath intl

# install opcache
RUN docker-php-ext-install opcache && docker-php-ext-enable opcache

# install ioncube
RUN curl -fsSL 'https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o ioncube.tar.gz \ 
    && mkdir -p /tmp/ioncube \ 
    && tar -xvvzf ioncube.tar.gz \ 
    && mv ioncube/ioncube_loader_lin_7.2.so `php-config --extension-dir` \ 
    && rm -Rf ioncube.tar.gz ioncube \ 
    && docker-php-ext-enable ioncube_loader_lin_7.2

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.19

RUN groupadd -g 1000 nugraha
RUN useradd -u 1000 -ms /bin/bash -g nugraha nugraha

USER nugraha

EXPOSE 9000

CMD [ "php-fpm" ]
