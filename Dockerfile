FROM php:7.3-fpm-alpine

LABEL org.label-schema.name="Anam Hossain"

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
    && apk add --no-cache \
    curl \
    git \
    imagemagick \
    mysql-client \
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

RUN git clone --depth 1 --branch v1.2.2 https://github.com/edenhill/librdkafka.git \
    && cd librdkafka \
    && ./configure \
    && make \
    && make install

RUN pecl channel-update pecl.php.net \
    && pecl install rdkafka \
    && docker-php-ext-enable rdkafka

RUN rm -rf /librdkafka \
    && apk del -f .build-deps

WORKDIR /var/www