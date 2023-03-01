### Start docker
```
git clone git@git.elidev.info:tri.do/debian-lemp-stack.git
cd debian-lemp-stack
ls -l
> Output:
total 32
-rw-r--r--   1 trido  staff  1430 Mar  1 14:01 Dockerfile
-rw-r--r--   1 trido  staff  1634 Mar  1 14:11 README.md
drwxr-xr-x  25 trido  staff   800 Mar  1 13:54 app
-rw-r--r--   1 trido  staff   368 Mar  1 13:37 docker-compose.yaml
-rw-r--r--   1 trido  staff   480 Mar  1 13:32 nginx.conf

## Edit docker-compose.yaml to fix your demand.
docker-compose up -d
``` 

### List docker
```
docker-compose ps

> Output:

       Name                      Command               State          Ports        
-----------------------------------------------------------------------------------
debian11nginx_app_1   /bin/sh -c chown mysql:mys ...   Up      0.0.0.0:8080->80/tcp

```

### Init database
> Run this for the first time only. Database shall be stored in folder db_data next time
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
> Configure Laravel
```
docker-compose exec app composer install
docker-compose exec app php artisan migrate
docker-compose exec app php artisan key:generate
chown www-data:www-data app/storage
```

> You can now open http://localhost:8080

