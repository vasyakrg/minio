#!/bin/bash

DISK=/mnt/disk

apt update && apt upgrade -y
apt install -y mc htop zip curl wget

wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio

mv minio /usr/local/bin

useradd -r minio-user -s /sbin/nologin
chown minio-user:minio-user /usr/local/bin/minio

mkdir -p $DISK
chown minio-user:minio-user $DISK
chown minio-user:minio-user /etc/minio

tee /etc/default/minio <<EOF &> /dev/null

MINIO_ACCESS_KEY="${ACCESS_KEY}"
MINIO_VOLUMES="$DISK/"
MINIO_OPTS="-C /etc/minio --0.0.0.0:9000"
MINIO_SECRET_KEY="${SECRET_KEY}"
EOF

curl -O https://raw.githubusercontent.com/minio/minio-service/master/linux-systemd/minio.service
mv minio.service /etc/systemd/system

systemctl daemon-reload
systemctl enable minio
systemctl start minio

systemctl status minio
