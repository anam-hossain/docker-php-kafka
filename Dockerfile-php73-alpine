FROM php:7.3-fpm-alpine

LABEL org.label-schema.name="Anam Hossain"

ENV LIBRDKAFKA_VERSION 1.2.2
ENV PHP_RDKAFKA_VERSION 4.0.0

RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    autoconf \
    gcc \
    g++ \
    make \
    bash \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    postgresql-dev \
    sqlite-dev \
    && apk add --update --no-cache nodejs npm \
    && apk add --no-cache \
    curl \
    git \
    imagemagick \
    postgresql-libs \
    libintl \
    icu \
    icu-dev \
    libzip-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install \
    bcmath \
    curl \
    iconv \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pcntl \
    tokenizer \
    xml \
    zip \
    intl \
    && curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN git clone --depth 1 --branch v$LIBRDKAFKA_VERSION https://github.com/edenhill/librdkafka.git \
    && cd librdkafka \
    && ./configure \
    && make \
    && make install

RUN pecl channel-update pecl.php.net \
    && pecl install rdkafka-$PHP_RDKAFKA_VERSION \
    && docker-php-ext-enable rdkafka

RUN rm -rf /librdkafka \
    && apk del -f .build-deps

WORKDIR /var/www