import boto3
from pprint import pprint
import image_helpers

client = boto3.client('rekognition')

imgurl = 'https://i.imgur.com/gVD3NKO.jpg'
#imgurl = 'http://www.idothat.us/images/idothat-img/features/pool-patio-lanai/ft-pool-patio-lanai-2.jpg'

# grab the image from online
imgbytes = image_helpers.get_image_from_url(imgurl)

rekresp = client.detect_labels(Image={'Bytes': imgbytes},
                               MinConfidence=1)
pprint(rekresp['Labels'])
