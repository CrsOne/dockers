#!/bin/bash
role=${CONTAINER_ROLE:-web}
if [ -d "/var/www" ]; then
	if [ -z $PRODUCCION ]; then
    	cd /var/www
    	composer install
	fi
fi
touch /var/www/storage/logs/laravel.log

case "$role" in
    web)
        service nginx start
        php-fpm7.1 -y /etc/php/7.1/fpm/php-fpm.conf -R
    ;;
    worker)
        php /var/www/artisan queue:work --verbose
    ;;
esac
tail -f /var/www/storage/logs/laravel.log
