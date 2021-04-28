#!/bin/bash
role=${CONTAINER_ROLE:-web}
if [ -d "/opt/develop" ]; then
	if [ -z $PRODUCCION ]; then
    	cd /opt/develop
    	composer install
	fi
fi
touch /opt/develop/storage/logs/laravel.log

case "$role" in
    web)
        service nginx start
        php-fpm7.2 -y /etc/php/7.2/fpm/php-fpm.conf -R
    ;;
    worker)
        php /opt/develop/artisan queue:work --verbose
    ;;
esac
tail -f /opt/develop/storage/logs/laravel.log
