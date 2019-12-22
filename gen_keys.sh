#!/bin/bash
source lib/lib.sh

ACCESS_KEY=$(randomString 15)
SECRET_KEY=$(randomString 30)

echo "ACCESS_KEY=$ACCESS_KEY"
echo "SECRET_KEY=$SECRET_KEY"
