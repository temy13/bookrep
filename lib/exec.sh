#!/bin/sh

source ../export.sh
sudo -E docker-compose build
sudo -E docker-compose up -d
sudo -E docker-compose logs -f -t
