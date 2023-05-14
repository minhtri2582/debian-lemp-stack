#!/bin/bash

cd /var/www/html/
git clone -b main https://cicd:$GITLAB_TOKEN@gitlab.com/evobio/evobio.link.git
cd /var/www/html/evobio.link/ && composer install
chown -R www-data:www-data /var/www/html/evobio.link/storage

exec "$@"
