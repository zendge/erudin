# INFO: gettext没有安装
# INFO: opcache没有采取静态编译，目前php8都内置了，而且PHP 8.4.9之前在alpine中静态编译opcache会报错
# INFO: apk add --no-cache libevent-dev openssl-dev && pecl install event && docker-php-ext-enable event
# INFO: 上面的event扩展之关安装后有问题所以没有安装

# INFO: printf "yes\nyes\nyes\nyes\nno\nyes\nno\nyes\nno\nno\nyes\nyes\nno\n" | pecl install swoole 选项对应了
# enable sockets support? [no] :
# enable openssl support? [no] :
# enable mysqlnd support? [no] :
# enable curl support? [no] :
# enable cares support? [no] :
# enable brotli support? [yes] :
# enable zstd support? [no] :
# enable PostgreSQL database support? [no] :
# enable ODBC database support? [no] :
# enable Oracle database support? [no] :
# enable Sqlite database support? [no] :
# enable swoole thread support (need php zts support)? [no] : yes
# INFO: 注意下面选no是发现在容里iouring当前编译后执行时会报WARNING Iouring::Iouring() (ERRNO 502): Create io_uring failed, the error code is 1
# 这里可能跟Linux内核有关或是虚拟化限制有关，暂时关掉这个特性，只是降低了一点文件操作性能
# enable iouring for file async support? [no] :
FROM php:8.4-zts-alpine
LABEL name="erudin_zts-25.6" maintainer="andares@foxmail.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        linux-headers \
        zlib-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        freetype-dev \
        gmp-dev \
        libzip-dev \
        libpq-dev \
        autoconf \
        util-linux-dev \
        imagemagick-dev \
        yaml-dev \
        libsodium-dev \
        liburing-dev \
        pcre-dev \
        openssl-dev \
        curl-dev \
    && apk add --no-cache \
        git \
        tzdata \
        libpng \
        libjpeg-turbo \
        freetype \
        gmp \
        libzip \
        libpq \
        imagemagick \
        yaml \
        libsodium \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && pecl channel-update pecl.php.net \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        sodium \
        gmp \
        bcmath \
        pcntl \
        sockets \
        zip \
        pdo_mysql \
        pdo_pgsql \
    && pecl install --nodeps \
        imagick \
        uuid \
        redis \
        yaml \
        msgpack \
    && (printf "yes\nyes\nyes\nyes\nno\nyes\nno\nyes\nno\nno\nyes\nyes\nno\n" | pecl install swoole) \
    && docker-php-ext-enable \
        imagick \
        uuid \
        redis \
        yaml \
        msgpack \
        swoole \
    && apk del --no-cache .build-deps \
    && apk add --no-cache libuuid liburing libstdc++ \
    && pecl clear-cache \
    && rm -rf \
        /var/cache/apk/* \
        /root/.cache \
        /tmp/* \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"