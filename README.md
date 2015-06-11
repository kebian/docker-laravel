docker-laravel
==============
Dockerfile for Laravel server.

* Based on Debian Jessie
* php-fpm 5.6
* nginx
* Laravel 5
* git
* composer
* cron configured for schedule
* 3 workers processing default queue
* cron, workers and web server run as www-data with UID 1000