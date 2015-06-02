FROM debian:jessie
MAINTAINER robs@codexsoftware.co.uk

# Using this UID allows local and live file modification of web site
RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y php5-fpm php5-mysql php5-sqlite php5-pgsql php5-mcrypt nginx supervisor cron

# Set up web site.
ADD nginx-default-server.conf /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD website/ /var/www/
RUN chown -R www-data.www-data /var/www/*

# Set up cron
ADD crontab /var/spool/cron/crontabs/www-data
RUN chown www-data.crontab /var/spool/cron/crontabs/www-data
RUN chmod 0600 /var/spool/cron/crontabs/www-data

ADD supervisord.conf /etc/

VOLUME ["/var/www"]

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/bin/supervisord"]