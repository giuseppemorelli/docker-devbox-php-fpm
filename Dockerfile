FROM debian:jessie

MAINTAINER Giuseppe Morelli <info@giuseppemorelli.net>

VOLUME /var/www/

ENV PHP_FPM_USER_UID     33
ENV PHP_FPM_USER_GID     33
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
    && apt-get -y install \
    php5-fpm \
    php5-cli \
    php5-curl \
    php5-dev \
    php5-gd \
    php5-intl \
    php5-mcrypt \
    php5-mysql \
    php5-xsl \
    php-pclzip \
    php5-json \
    php5-xdebug \
    php-soap \
    php-pear \
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
COPY php5/mods-available/devbox.ini /etc/php5/fpm/conf.d/00-devbox.ini
COPY php5/mods-available/xdebug.ini /etc/php5/fpm/conf.d/90-xdebug.ini
COPY php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf

RUN service php5-fpm start

EXPOSE 9000

CMD ["/opt/script/entrypoint.sh"]