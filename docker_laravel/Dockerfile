FROM debian:11

RUN apt update && apt-get install curl software-properties-common dirmngr wget -y

# INSTALL PHP8.2
RUN apt update && apt install lsb-release apt-transport-https ca-certificates software-properties-common -y
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt update && apt install php8.2 php8.2-fpm php8.2-cli php8.2-mysql php8.2-zip php8.2-curl php8.2-xml -y

# INCLUDING .INI
COPY ./laravel.ini /etc/php/8.2/fpm/conf.d/laravel.ini

# INSTALL NGINX
RUN apt-get install nginx -y
COPY nginx.conf /etc/nginx/
COPY sites/default.conf /etc/nginx/sites-available/default

## INSTALL COMPOSER
RUN apt install php8.2-mbstring git unzip -y
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN apt install supervisor -y
COPY supervisord.conf /etc/supervisor/

# INSTALL VIM
RUN apt update && apt install vim -y

WORKDIR /var/www/html
EXPOSE 80 443
STOPSIGNAL SIGTERM
CMD /etc/init.d/php8.2-fpm start && /usr/bin/supervisord

