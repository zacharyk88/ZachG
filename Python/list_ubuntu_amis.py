"""
Zachary Goss List the Ubuntu AMI ids for each region based off of a modified version of https://gist.github.com/drpventura/f20aa74e171c4eee047b90f592ae6110
last accessed 10/16/2017
"""
import boto3

ec2 = boto3.client('ec2', 'us-east-1')

resp = ec2.describe_regions()

region_names = sorted([region['RegionName'] for region in resp['Regions']])

filters = [{'Name': 'architecture',
            'Values': ['x86_64']},
           {'Name': 'virtualization-type',
            'Values': ['hvm']},
           {'Name': 'name',
            'Values': ['ubuntu/images/hvm-ssd/ubuntu-xenial-16.04*20170721']}]

apfilters = [{'Name': 'architecture',
            'Values': ['x86_64']},
           {'Name': 'virtualization-type',
            'Values': ['hvm']},
           {'Name': 'name',
            'Values': ['ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20170721']},
           {'Name': 'image-id', 'Values': ['*e8c']}]

cafilters = [{'Name': 'architecture',
            'Values': ['x86_64']},
           {'Name': 'virtualization-type',
            'Values': ['hvm']},
           {'Name': 'name',
            'Values': ['ubuntu/images/hvm-ssd/ubuntu-xenial-16.04*20170414']}]

for region in region_names:
    ec2 = boto3.client('ec2', region)

    if region == "ap-northeast-1":
        resp = ec2.describe_images(Filters=apfilters)
        print('    ' + region + ':')
        print('      AMI: ' + resp['Images'][0]['ImageId'])
    elif region == "ca-central-1":
        resp = ec2.describe_images(Filters=cafilters)
        print('    ' + region + ':')
        print('      AMI: ' + resp['Images'][0]['ImageId'])
    else:
        resp = ec2.describe_images(Filters=filters)
        print('    ' + region + ':')
        print('      AMI: ' + resp['Images'][0]['ImageId'])
#pprint(ec2.describe_images(Filters=[{'Name': 'image-id', 'Values': ['ami-cd0f5cb6']}]))