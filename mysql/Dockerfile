FROM mysql:8
# Volume mounts at /var/lib/mysql may contain lost+found; keep the datadir in a subdir.
CMD ["mysqld", "--datadir=/var/lib/mysql/data"]
