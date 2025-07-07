FROM php:8.4-fpm-alpine
LABEL name="erudin_fpm-25.4" maintainer="andares@foxmail.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
  apk add --no-cache tzdata && \
  echo "Asia/Shanghai" > /etc/timezone && \
  cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  apk del --no-cache tzdata

RUN apk add --no-cache linux-headers zlib-dev libpng-dev libjpeg-turbo-dev freetype-dev gettext-dev gmp-dev libzip-dev libpq-dev autoconf util-linux-dev imagemagick-dev yaml-dev libmcrypt-dev libsodium-dev sudo

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
  docker-php-ext-install -j$(nproc) gd && \
  docker-php-ext-configure gettext && \
  docker-php-ext-install -j$(nproc) gettext && \
  docker-php-ext-configure sodium && \
  docker-php-ext-install -j$(nproc) sodium && \
  docker-php-ext-configure opcache   && \
  docker-php-ext-install -j$(nproc) opcache && \
  docker-php-ext-configure gmp && \
  docker-php-ext-install -j$(nproc) gmp && \
  docker-php-ext-configure bcmath && \
  docker-php-ext-install -j$(nproc) bcmath && \
  docker-php-ext-configure pcntl && \
  docker-php-ext-install -j$(nproc) pcntl && \
  docker-php-ext-configure sockets && \
  docker-php-ext-install -j$(nproc) sockets && \
  docker-php-ext-configure zip && \
  docker-php-ext-install -j$(nproc) zip && \
  apk add --no-cache postgresql && \
  docker-php-ext-configure pdo_pgsql && \
  docker-php-ext-install -j$(nproc) pdo_pgsql

# 暂未安装扩展:
# 安装后存在问题
# apk add --no-cache libevent-dev openssl-dev && pecl install event && docker-php-ext-enable event

# TODO: 等imagick 3.8版本正式发布后要改一下不要用RC版
RUN apk add --no-cache g++ gcc libc-dev make && \
  pecl install imagick uuid redis yaml swoole msgpack && \
  docker-php-ext-enable imagick uuid redis yaml swoole msgpack && \
  apk del --no-cache postgresql g++ gcc libc-dev make zlib-dev libpng-dev freetype-dev autoconf libmcrypt-dev libsodium-dev

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN rm -rf /var/cache/apk/* && \
  rm -rf /root/.cache && \
  rm -rf /tmp/*
