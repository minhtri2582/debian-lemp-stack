FROM debian:11

RUN apt update && apt-get install curl software-properties-common dirmngr wget -y
RUN curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup && \
	bash mariadb_repo_setup --os-type=debian  --os-version=buster --mariadb-server-version=10.6 && \
	wget http://ftp.us.debian.org/debian/pool/main/r/readline5/libreadline5_5.2+dfsg-3+b13_amd64.deb && \
	dpkg -i libreadline5_5.2+dfsg-3+b13_amd64.deb
# INSTALL MARIADB 10.6
RUN apt update && apt-get install mariadb-server mariadb-client -y

# INSTALL PHP8.2
RUN apt update && apt install lsb-release apt-transport-https ca-certificates software-properties-common -y
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt update && apt install php8.2 php8.2-fpm php8.2-cli php8.2-mysql php8.2-zip php8.2-curl php8.2-xml -y
# INSTALL NGINX
RUN apt-get install nginx -y
COPY nginx.conf /etc/nginx/sites-available/default

## INSTALL COMPOSER
RUN apt install php8.2-mbstring git unzip -y
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

EXPOSE 80
STOPSIGNAL SIGTERM
CMD chown mysql:mysql /var/lib/mysql -Rf && /etc/init.d/mariadb start && /etc/init.d/php8.2-fpm start && nginx -g "daemon off;"
