#!/bin/bash
source .env
source ./lib/lib.sh

remove dev

docker volume rm disk1
