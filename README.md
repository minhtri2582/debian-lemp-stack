### Start docker
```
docker-compose up -d
``` 

### List docker status
```
docker-compose ps

> Output:

       Name                      Command               State          Ports        
-----------------------------------------------------------------------------------
debian11nginx_app_1   /bin/sh -c chown mysql:mys ...   Up      0.0.0.0:8080->80/tcp

```

### Init database
> Run this for first time. Database shall be store in folder db_data
```
# Create database
docker-compose exec app mysql -e "create database app"

# Create user
docker-compose exec app mysql -e "create user 'app'@'%' identified by 'laravel'"

# Grant permission
docker-compose exec app mysql -e "grant all on app.* to 'app'@'%'"

# List database
docker-compose exec app mysql -e "show databases"
> Output: 
+--------------------+
| Database           |
+--------------------+
| app                |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```

### Configure Laravel App
>  Or any PHP application
```
git clone https://github.com/laravel/laravel.git app
cd app
cp .env.example .env
vim .env
> Replace parameters as previous steps
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=app
DB_USERNAME=app
DB_PASSWORD=laravel
```
> Run Composer
```
docker-compose exec cd /var/www/html && composer install
```

