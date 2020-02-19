FROM php:7.4-fpm-alpine

RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    curl-dev \
    libtool \
    libxml2-dev \
    postgresql-dev \
    sqlite-dev \
    freetype-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    oniguruma-dev \
    && apk add --no-cache \
    freetype \
    libjpeg-turbo \
    libpng \
    curl \
    git \
    postgresql-libs \
    libintl \
    icu \
    icu-dev \
    libzip-dev \
    && docker-php-ext-configure gd \
    --enable-gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install \
    bcmath \
    curl \
    iconv \
    mbstring \
    pdo \
    gd \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pcntl \
    tokenizer \
    xml \
    soap \
    zip \
    intl \
    && curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && apk del -f .build-deps
