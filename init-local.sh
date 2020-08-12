#!/bin/bash

source .env

DISK=/mnt/disk

apt update && apt upgrade -y
apt install -y mc htop zip curl wget git

wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio

mv minio /usr/local/bin

useradd -r minio-user -s /sbin/nologin
chown minio-user:minio-user /usr/local/bin/minio

mkdir -p $DISK
chown minio-user:minio-user $DISK
mkdir -p /etc/minio
chown minio-user:minio-user /etc/minio

tee /etc/default/minio <<EOF &> /dev/null

MINIO_ACCESS_KEY="${ACCESS_KEY}"
MINIO_VOLUMES="$DISK/"
MINIO_OPTS="-C /etc/minio --address 0.0.0.0:9000"
MINIO_SECRET_KEY="${SECRET_KEY}"
EOF

curl -O https://raw.githubusercontent.com/minio/minio-service/master/linux-systemd/minio.service
mv minio.service /etc/systemd/system

systemctl daemon-reload
systemctl enable minio
systemctl start minio

systemctl status minio

curl https://dl.min.io/client/mc/release/linux-amd64/mc -o s3minio
chmod +x s3minio
mv s3minio /usr/local/bin


s3minio alias set local https://${S3_DOMAIN} ${ACCESS_KEY} ${SECRET_KEY}

s3minio mb local/${NEW_BACKET}


mkdir -p /srv/policy
tee /srv/policy/${NEW_BACKET}-rigths.conf <<EOF &> /dev/null
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::$NEW_BACKET/*"
      ],
      "Sid": "$NEW_BACKET-rigths"
    }
  ]
}
EOF

s3minio admin policy add local/ readwrite /srv/policy/${NEW_BACKET}-rigths.conf

s3minio admin user add local/ ${NEW_USER_KEY} ${NEW_USER_SECRET}
s3minio admin policy set local/ writeonly user=${NEW_USER_KEY}
