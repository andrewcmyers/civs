#!/bin/sh

HOSTNAME="${1:-$THISHOST}"

cd /civs || exit 1

envsubst '${CGIBINDIR} ${HOSTNAME} ${HTMLDIR}' < docker/civs.conf > /usr/local/apache2/conf/extra/civs.conf

./install-civs

chown -R www-data:www-data /var/www
# allow the daemon to create new subdirectories
chown -R daemon:daemon /data

exec "$@"
