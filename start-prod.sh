#!/bin/bash
source .env
source ./lib/lib.sh

docker volume create -o type=xfs -o device=/dev/sdb --name data1-1
docker volume create -o type=xfs -o device=/dev/sdc --name data2-1

start prod
