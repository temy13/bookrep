sudo rm /var/lib/docker/volumes/bookrep_tmp-data/_data/pids/server.pid
source ./export.sh
sudo -E docker-compose up -d
sudo -E docker-compose logs -f -t rails
