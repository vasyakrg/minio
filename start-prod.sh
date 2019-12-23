#!/bin/bash
source .env
source ./lib/lib.sh

docker volume create -o type=ext4 -o device=/srv/service/data/disk1 --name data1-1
docker volume create -o type=ext4 -o device=/srv/service/data/disk2 --name data2-1

start prod
