#!/bin/bash
source ../.env
source ../lib/lib.sh

INSTALL_PATH=/usr/local/bin

check_mcli && {
    echo "mcli already installed."
    exit 0
}

case "$OSTYPE" in
    "darwin"*)
        echo "MacOS type, installing.."
        link=https://dl.min.io/client/mc/release/darwin-amd64/mc
    ;;
    "linux"*)
        echo "Linux-type OS, installing.."
        link=https://dl.min.io/client/mc/release/linux-amd64/mc
    ;;
    *)
        echo "Unknown OS type, please install mcli from https://github.com/minio/mc"
        exit 1
    ;;
esac

wget $link
chmod +x ./mc
sudo mv ./mc $INSTALL_PATH/mcli

echo "mcli Installed"
echo ""

$INSTALL_PATH/mcli --version
