#!/usr/bin/env bash

set -e

#############################################
# COMPOSER
# (not correct to be here, just a quick install)
#############################################

## adding composer
cd /tmp/
wget https://getcomposer.org/composer.phar
chmod +x ./composer.phar
mv ./composer.phar /usr/local/bin/composer
## get the stable version
/usr/local/bin/composer self-update

#############################################
# PHP-FPM
#############################################

if [ "$PHP_FPM_USER_UID" != false ]; then
    usermod -u $PHP_FPM_USER_UID www-data
fi

if [ "$PHP_FPM_USER_GID" != false ]; then
    groupmod -g $PHP_FPM_USER_GID www-data
fi

chown www-data:www-data /var/www/ -R

/usr/sbin/php5-fpm -F