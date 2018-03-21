pg_ctl -D /usr/local/var/postgres -l logfile start
redis-server /usr/local/etc/redis.conf
bundle exec sidekiq
