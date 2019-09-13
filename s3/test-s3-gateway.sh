#!/usr/bin/env python
# pip install boto
import boto.s3.connection

access_key = 'Y9HFBFB0QFUHI6SSQ70X'
secret_key = 'Q6ApSdsqU0LYCLF1tevK8kijcWYDID312n6vGnzJ'
conn = boto.connect_s3(
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        host='192.168.44.204', port=7480,
        is_secure=False, calling_format=boto.s3.connection.OrdinaryCallingFormat(),
       )

bucket = conn.create_bucket('tf-be')
for bucket in conn.get_all_buckets():
    print(bucket.name+" "+bucket.creation_date)
