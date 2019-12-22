#!/bin/bash
function start() {

    case $1 in
        "dev")
            file=docker-compose-dev.yml
        ;;
        "prod")
            file=docker-compose-prod.yml
        ;;
        *)
            echo "not set type, exit"
            exit 1
    esac

    [ ! -f .env ] && {
        cp .env.example .env
        echo "please, fill data in .env file and try again"
        exit 1
    }

    docker-compose -f $file up -d
    echo "Go to browser in $S3_DOMAIN:$NGINX_PORT"
}

function stop() {
    case $1 in
        "dev")
            file=docker-compose-dev.yml
        ;;
        "prod")
            file=docker-compose-prod.yml
        ;;
        *)
            echo "not set type, exit"
            exit 1
    esac

    docker-compose -f $file stop
}

function remove() {
    echo "!!! WARNING! This will remove all containers and DELETE all volumes with DATA !!!"
    confirm_yes Continue? || exit 1

    case $1 in
        "dev")
            file=docker-compose-dev.yml
        ;;
        "prod")
            file=docker-compose-prod.yml
        ;;
        *)
            echo "not set type, exit"
            exit 1
    esac

    docker-compose -f $file down
}

function confirm () {
     [[ "${QUIET_MODE}" == "true" ]] && return 0

    case "$1" in
    "@number")
        local check=$( randomNumber 100 999 )
        local mes="input '$check'"
    ;;
    "@yes")
        local check=yes
        local mes="yes/NO"
    ;;
    "@y")
        local check=y
        local mes="y/N"
    ;;
    *)
        local check=$1
        local mes="input \'$check\'"
    ;;
    esac
    shift

    args=$@
    read -p "${args} ($mes): " res
    if [[ "$res" == "$check" ]]; then return 0; else echo "Aborted."; return 1; fi
}

# funcs of confirm
function confirm_string () {
    confirm $@
    return $?
}

function confirm_yes () {
    confirm "@yes" $@
    return $?
}

function confirm_y () {
    confirm "@y" $@
    return $?
}

function confirm_number () {
    confirm "@number" $@
    return $?
}

function randomNumber() {
    local start=$1
    local end=$2

    if [[ -z "$start" ]] || [[ -z "$end" ]]; then echo 0; return 1; fi
    local range=$(( $end - $start ))

    echo $(( $start + $RANDOM % $range ))
}
