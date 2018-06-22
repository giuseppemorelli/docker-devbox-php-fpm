FROM debian:stretch

MAINTAINER Giuseppe Morelli <info@giuseppemorelli.net>

VOLUME /var/www/

ENV PHP_FPM_USER_UID     33
ENV PHP_FPM_USER_GID     33
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
    && apt-get -y install \
    php7.0-fpm \
    php7.0-cli \
    php7.0-curl \
    php7.0-dev \
    php7.0-gd \
    php7.0-intl \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-mbstring \
    php7.0-xml \
    php7.0-xsl \
    php7.0-zip \
    php7.0-json \
    php7.0-xdebug \
    php7.0-soap \
    php7.0-bcmath \
    wget \
    git \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

RUN mkdir /var/www/html

COPY script /opt/script/
COPY php/7.0/mods-available/devbox.ini /etc/php/7.0/fpm/conf.d/00-devbox.ini
COPY php/7.0/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/90-xdebug.ini
COPY php/7.0/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN service php7.0-fpm start

EXPOSE 9000

CMD ["/opt/script/entrypoint.sh"]