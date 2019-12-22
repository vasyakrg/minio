#!/bin/bash
source ../.env

SERVER_NAME=${1:-minio}

type mcli >/dev/null 2>/dev/null && {

    mcli config host add $SERVER_NAME $S3_DOMAIN $ACCESS_KEY $SECRET_KEY

} || {
    echo "mcli not installed is you system, please run ./mcli_install.sh before"
    exit 1
}
