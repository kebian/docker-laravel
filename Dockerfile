FROM debian:jessie
MAINTAINER robs@codexsoftware.co.uk

# Using this UID / GID allows local and live file modification of web site
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

RUN apt-get clean && apt-get update && apt-get install -y php5-fpm php5-mysql php5-sqlite php5-pgsql php5-mcrypt php5-curl php5-memcached php5-gd nginx supervisor cron git ssmtp sudo

# Install composer
ADD https://getcomposer.org/composer.phar /usr/bin/composer
RUN chmod 0755 /usr/bin/composer

# Set up web site.
ADD nginx-default-server.conf /etc/nginx/sites-available/default
ADD domain.crt /etc/nginx/conf.d/
ADD domain.key /etc/nginx/conf.d/
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm -rf /var/www
RUN sudo -u www-data composer create-project --prefer-dist laravel/laravel /tmp/www && mv /tmp/www /var/

# Set up cron
ADD crontab /var/spool/cron/crontabs/www-data
RUN chown www-data.crontab /var/spool/cron/crontabs/www-data
RUN chmod 0600 /var/spool/cron/crontabs/www-data

# Configure supervisord
ADD supervisord.conf /etc/supervisor/
ADD supervisor_conf/* /etc/supervisor/conf.d/

EXPOSE 80
EXPOSE 443

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
ENTRYPOINT ["/root/docker-entrypoint.sh"]