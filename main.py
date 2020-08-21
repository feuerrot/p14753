#!/usr/bin/env python3
import os
import minio

client = minio.Minio(
    'localhost:9000',
    access_key='minioadmin',
    secret_key='minioadmin',
    secure=False,
)
testfile = 'testfile'

buckets = client.list_buckets()
if len(buckets) == 0:
    client.make_bucket('test')

file_stat = os.stat(testfile)
with open(testfile, 'rb') as fd:
    data = fd.read()
    # enforce 'has incomplete body' error
    client._do_put_object('test', testfile + str(os.getpid()), data, len(data) + 1)