#!/bin/bash
source .env
source ./lib/lib.sh

remove prod

docker volume rm data1
