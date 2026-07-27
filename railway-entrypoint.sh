#!/bin/sh
# Adapt OpenEMR to Railway: seed the sites volume, bind Apache to $PORT,
# then hand off to the upstream auto-setup entrypoint.
set -e

SITES=/var/www/localhost/htdocs/openemr/sites

# Railway volumes mount EMPTY (docker named volumes would auto-copy the
# image's content; Railway's don't) — so on first boot the packaged sites/
# tree is hidden and setup dies on a missing sites/default/sqlconf.php.
# Seed the volume from the pristine copy baked in at build time.
if [ ! -f "$SITES/default/sqlconf.php" ]; then
  echo "railway-entrypoint: seeding empty sites volume from image"
  cp -a /openemr-sites-dist/. "$SITES/"
fi

# Bind Apache to the Railway-injected PORT. Railway terminates TLS at the
# edge, so only the HTTP vhost matters — the self-signed :443 vhost stays
# but nothing routes to it.
if [ -n "$PORT" ] && [ "$PORT" != "80" ]; then
  sed -i "s/^Listen 0\.0\.0\.0:80$/Listen 0.0.0.0:${PORT}/" /etc/apache2/httpd.conf
  sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/" /etc/apache2/conf.d/openemr.conf
fi

# openemr.sh is the upstream auto-setup + runtime entrypoint (CMD, relative
# to its WORKDIR) — first boot creates the database and admin user from
# MYSQL_HOST / MYSQL_ROOT_PASS / OE_USER / OE_PASS.
exec ./openemr.sh
