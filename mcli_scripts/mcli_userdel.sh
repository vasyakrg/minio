#!/bin/bash
source ../.env
source ../lib/lib.sh

check_mcli || {
    echo "mcli not installed, run ./mcli_install.sh"
    exit 0
}

user=$1

[ -z "$user" ] && {
    echo "Usage: ./mcli_userdel <ACCESS_KEY>"
} || {
    echo "Info of user:"
    mcli admin user info $SERVER_NAME $1

    echo "!!! WARNING! User remove and remove his backets !!!"
    confirm_yes Continue? || exit 1

    mcli admin user remove $SERVER_NAME $1
    [ -f users/$1 ] && rm users/$1
}
