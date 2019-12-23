#!/bin/bash
source .env
source ./lib/lib.sh

remove prod

docker volume rm data1-1
docker volume rm data2-1
