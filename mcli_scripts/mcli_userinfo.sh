#!/bin/bash
source ../.env
source ../lib/lib.sh

check_mcli || {
    echo "mcli not installed, run ./mcli_install.sh"
    exit 0
}

user=$1

[ -z "$user" ] && {
    echo "Usage: ./mcli_userinfo <ACCESS_KEY>"
} || {
    echo "Info of user:"
    mcli admin user info $SERVER_NAME $1
}
