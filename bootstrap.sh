#!/bin/bash
set -e
set -u
set -o pipefail

wget https://github.com/minio/minio/archive/RELEASE.2020-08-16T18-39-38Z.tar.gz
tar xavf RELEASE.2020-08-16T18-39-38Z.tar.gz
cd minio-RELEASE.2020-08-16T18-39-38Z
go build .
cd ..

python3 -m venv venv
. venv/bin/activate
pip install minio

mkdir -p test/drive{0..3}
dd if=/dev/urandom of=testfile bs=1M count=64
