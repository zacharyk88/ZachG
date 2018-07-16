from chalice import Chalice
from contextlib import closing
import os
import uuid
from tempfile import gettempdir
import boto3
import requests
import PIL
from PIL import Image, ImageDraw, ImageFont
from pprint import pprint, pformat
from io import BytesIO

'''Zachary Goss app.py 
Chalice Lambda program to pull labels from user uploaded image and say labels in user selected polly voice
modified from SayIt.py program and labels_graphical.py '''

# NOTE: We need to add s3:PutObject to the policy.json file
#       then deploy with chalice deploy --no-autogen-policy
app = Chalice(app_name='VoiceLabel')

BUCKET_NAME = 'gossvoicebucket-s3bucket-ywmlz6rg81e2'

def text_to_speech(text, voice):
    '''
    Uses AWS Polly to convert the given text to speech
    :param text: the text to convert
    :param voice: the voice to use
    :return: the url of where to access the converted file.
    '''
    # code taken from/based on
    # https://aws.amazon.com/blogs/ai/build-your-own-text-to-speech-applications-with-amazon-polly/,
    # last access 10/29/2017
    rest = text

    # Because single invocation of the polly synthesize_speech api can
    # transform text with about 1,500 characters, we are dividing the
    # post into blocks of approximately 1,000 characters.
    print('Setting up textBlocks')
    textBlocks = []
    while (len(rest) > 1100):
        begin = 0
        end = rest.find(".", 1000)

        if (end == -1):
            end = rest.find(" ", 1000)

        textBlock = rest[begin:end]
        rest = rest[end:]
        textBlocks.append(textBlock)
    textBlocks.append(rest)
    print('textBlocks:', textBlocks)

    # For each block, invoke Polly API, which will transform text into audio
    print('Creating polly client')
    polly = boto3.client('polly')
    filename = '{}.mp3'.format(uuid.uuid4())
    print('filename:', filename)
    for textBlock in textBlocks:
        response = polly.synthesize_speech(
            OutputFormat='mp3',
            Text=textBlock,
            VoiceId=voice
        )

        # Save the audio stream returned by Amazon Polly on Lambda's temp
        # directory. If there are multiple text blocks, the audio stream
        # will be combined into a single file.
        if "AudioStream" in response:
            with closing(response["AudioStream"]) as stream:
                output = os.path.join(gettempdir(), filename)
                print('Outputting to', output)
                with open(output, "ab") as file:
                    file.write(stream.read())

    s3 = boto3.client('s3')
    print('Uploading {} to S3'.format(filename))
    s3.upload_file(os.path.join(gettempdir(), filename),
                   BUCKET_NAME,
                   filename)
    print('Setting ACL')
    s3.put_object_acl(ACL='public-read',
                      Bucket=BUCKET_NAME,
                      Key=filename)
    print('Returning URL')
    return 'https://s3.amazonaws.com/{}/{}'.format(BUCKET_NAME, filename)


#@app.route('/voicelabel', cors=True)
@app.route('/gossvoicebucket-s3bucket-ywmlz6rg81e2/{voice}', content_types=['image/png'], methods=['POST'], cors=True)
#@app.route({voice}', content_types=['image/png'], methods=['POST'], cors=True)


def get_labels(img, confidence=50):
    """
    Gets the labels from AWS Rekognition for the given image
    :param img: either the image bytes or a string that is the URL or filename for an image
    :param confidence: the confidence level (defaults to 50)

    """
    # The following code was modified from https://github.com/drpventura/PythonRekognitionDemo/blob/master/labels.py last accessed 10/12/2017
    client = boto3.client('rekognition')

    filename = img
    #imgurl = 'http://www.idothat.us/images/idothat-img/features/pool-patio-lanai/ft-pool-patio-lanai-2.jpg'

    # grab the image from online
    imgbytes = get_image_from_file(filename)

    rekresp = client.detect_labels(Image={'Bytes': imgbytes},
                                   MinConfidence=confidence)
    return rekresp['Labels']

def voicelabel():
    '''
    AWS Gateway API endpoint that converts text into speech
    '''
    from pprint import pprint
    # pprint(app.current_request.query_params)
    text = app.current_request.query_params.get('text', None)
    voice = app.current_request.query_params.get('voice', None)
    if text is None or voice is None:
        return {'Error': 'text and/or voice not set'}
    return {
        'labels': text,
        'voice': voice,
        'url': text_to_speech(text, voice)
    }

import requests

def get_image_from_url(imgurl):
    """
    Loads and returns the bytes of the image from the specified url
    :param imgurl: the url
    """
    resp = requests.get(imgurl)
    imgbytes = resp.content
    return imgbytes

def get_image_from_file(filename):
    """
    Loads and returns the bytes of the image from the specified file
    :param filename: the name of the file
    Based on
       https://docs.aws.amazon.com/rekognition/latest/dg/example4.html,
       last access 10/3/2017
    """
    with open(filename, 'rb') as imgfile:
        return imgfile.read()

def get_image(img):
    """
    Loads and returns the image either from a URL or a file
    :param img: string that is either the URL or file
    :return:
    """
    if img.lower().startswith('http'):
        return get_image_from_url(img)
    else:
        return get_image_from_file(img)