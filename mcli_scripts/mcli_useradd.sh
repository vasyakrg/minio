#!/bin/bash
source ../.env
source ../lib/lib.sh

check_mcli || {
    echo "mcli not installed, run ./mcli_install.sh"
    exit 0
}

ACCESS_KEY=$(randomString 15)
SECRET_KEY=$(randomString 30)

mcli admin user add $SERVER_NAME $ACCESS_KEY $SECRET_KEY

[ ! -d users ] && mkdir users

touch users/$ACCESS_KEY
echo $SECRET_KEY >> users/$ACCESS_KEY

echo "ACCESS_KEY=$ACCESS_KEY"
echo "SECRET_KEY=$SECRET_KEY"
echo "saved to /users"
