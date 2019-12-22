#!/bin/bash
source ../.env
source ../lib/lib.sh

check_mcli || {
    echo "mcli not installed, run ./mcli_install.sh"
    exit 0
}

mcli admin user list $SERVER_NAME
