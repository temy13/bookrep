#!/bin/sh
git pull origin master
source ./export.sh
sudo -E docker-compose build
sudo rm -f /var/lib/docker/volumes/bookrep_tmp-data/_data/pids/server.pid
sudo -E docker-compose up -d
sudo -E docker-compose exec rails bundle exec whenever --update-crontab
sudo -E docker-compose exec rails rake db:migrate
sudo -E docker-compose logs -f -t
