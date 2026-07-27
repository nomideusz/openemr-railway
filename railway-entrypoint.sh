#!/bin/sh
# Bind Apache to the Railway-injected PORT before OpenEMR's own setup runs.
# Railway terminates TLS at the edge, so only the HTTP vhost matters here —
# the image's self-signed :443 vhost stays but nothing routes to it.
set -e

if [ -n "$PORT" ] && [ "$PORT" != "80" ]; then
  sed -i "s/^Listen 0\.0\.0\.0:80$/Listen 0.0.0.0:${PORT}/" /etc/apache2/httpd.conf
  sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/" /etc/apache2/conf.d/openemr.conf
fi

# openemr.sh is the upstream auto-setup + runtime entrypoint (CMD, relative
# to its WORKDIR) — first boot creates the database and admin user from
# MYSQL_HOST / MYSQL_ROOT_PASS / OE_USER / OE_PASS.
exec ./openemr.sh
