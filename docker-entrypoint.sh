#!/bin/bash
set -e

SETUP_SCRIPT=/root/setup.sh

if [ -x $SETUP_SCRIPT ]; then
	echo 'Running one-time setup.'

	# Set # of hard links to 1 to keep cron happy.
	touch /etc/cron.d/php5 /var/spool/cron/crontabs/www-data /etc/crontab

	source $SETUP_SCRIPT
	rm -f $SETUP_SCRIPT
fi

exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf