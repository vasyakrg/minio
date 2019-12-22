#!/bin/bash
source ../.env
source ../lib/lib.sh

check_mcli || {
    echo "mcli not installed, run ./mcli_install.sh"
    exit 0
}

[ -z $SERVER_NAME ] && {
    SERVER_NAME=${1:-minio}
    echo SERVER_NAME=$SERVER_NAME >> ../.env
}

mcli config host add $SERVER_NAME $S3_DOMAIN $ACCESS_KEY $SECRET_KEY
