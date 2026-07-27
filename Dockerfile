FROM openemr/openemr:7.0.4

# Pristine copy of sites/ — the entrypoint seeds Railway's empty volume
# from it on first boot (Railway volumes don't auto-copy image content).
RUN cp -a /var/www/localhost/htdocs/openemr/sites /openemr-sites-dist

COPY --chmod=0755 railway-entrypoint.sh /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
