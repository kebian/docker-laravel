docker-laravel
==============
Dockerfile for Laravel server.

* Based on Debian Jessie
* php-fpm 5.6
* nginx
* Laravel 5
* cron configured for schedule
* 3 workers processing default queue
* /var/www data volume
* cron, workers and web server run as www-data with UID 1000