docker-laravel
==============
Dockerfile for Laravel server.

* Based on Debian Stretch
* php-fpm 7.0
* nginx
* Laravel 5
* git
* composer
* cron configured for schedule
* 3 workers processing default queue
* cron, workers and web server run as www-data with UID 1000