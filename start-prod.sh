#!/bin/bash
source .env
source ./lib/lib.sh

docker volume create -o type=xfs -o device=/dev/sdb --name data1

start prod
