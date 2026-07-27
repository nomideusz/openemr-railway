FROM openemr/openemr:7.0.4

COPY --chmod=0755 railway-entrypoint.sh /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
