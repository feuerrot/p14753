#!/bin/bash
set -e
set -u
set -o pipefail

echo "start minio"
minio-RELEASE.2020-08-16T18-39-38Z/minio server test/drive{0...3} &
MINPID=$!
sleep 5

echo "run test client"
. venv/bin/activate
./main.py &
PYPID=$!
sleep 10

echo "kill test client"
kill -9 $PYPID
sleep 2

echo "list directory"
ls -lah test/*/.minio.sys/tmp
sleep 2

echo "stop minio"
kill $MINPID