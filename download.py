import os
import boto3
s3 = boto3.client('s3')

session = boto3.Session(region_name=os.environ.get('AWS_REGION'))
ssm = session.client('ssm')
bucketname = os.environ.get('BUCKET_NAME')
filekey = os.environ.get('HTML_FILE_KEY')
filename = ssm.get_parameter(Name=filekey)

with open('/var/www/html/index.html', 'wb') as f:
    s3.download_fileobj(bucketname, filename['Parameter']['Value'], f)
