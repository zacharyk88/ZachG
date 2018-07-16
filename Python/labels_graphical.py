import PIL
from PIL import Image, ImageDraw, ImageFont
import boto3
from pprint import pprint, pformat
from io import BytesIO
import image_helpers

# --------------------------------------------------------------------
# DO NOT CHANGE THESE FUNCTIONS


def format_text(text, columns):
    '''
    Returns a copy of text that will not span more than the specified number of columns
    :param text: the text
    :param columns: the maximum number of columns
    :return: the formatted text
    '''
    # format the text to fit the specified columns
    import re
    text = re.sub('[()\']', '', pformat(text, width=columns))
    text = re.sub('\n ', '\n', text)
    return text


def text_rect_size(draw, text, font):
    '''
    Returns the size of the rectangle to be used to
    draw as the background for the text
    :param draw: an ImageDraw.Draw object
    :param text: the text to be displayed
    :param font: the font to be used
    :return: the size of the rectangle to be used to draw as the background for the text
    '''
    (width, height) = draw.multiline_textsize(text, font=font)
    return (width * 1.1, height * 1.3)


def add_text_to_img(img, text, pos=(0, 0), color=(0, 0, 0), bgcolor=(255, 255, 255, 128),
                    columns=60,
                    font=ImageFont.truetype('ariblk.ttf', 22)):
    '''
    Creates and returns a copy of the image with the specified text displayed on it
    :param img: the (Pillow) image
    :param text: the text to display
    :param pos: a 2 tuple containing the xpos, and ypos of the text
    :param color: the fill color of the text
    :param bgcolor: the background color of the box behind the text
    :param columns: the max number of columns for the text
    :param font: the font to use
    :return: a copy of the image with the specified text displayed on it
    '''

    # make a blank image for the text, initialized to transparent text color
    txt_img = Image.new('RGBA', img.size, (255, 255, 255, 0))
    draw = ImageDraw.Draw(txt_img)

    # format the text
    text = format_text(text, columns)
    # get the size of the text drawn in the specified font
    (text_width, text_height) = ImageDraw.Draw(img).multiline_textsize(text, font=font)

    # compute positions and box size
    (xpos, ypos) = pos
    rwidth = text_width * 1.1
    rheight = text_height * 1.4
    text_xpos = xpos + (rwidth - text_width) / 2
    text_ypos = ypos + (rheight - text_height) / 2

    # draw the rectangle (slightly larger) than the text
    draw.rectangle([xpos, ypos, xpos + rwidth, ypos + rheight], fill=bgcolor)

    # draw the text on top of the rectangle
    draw.multiline_text((text_xpos, text_ypos), text, font=font, fill=color)

    del draw # clean up the ImageDraw object
    return Image.alpha_composite(img.convert('RGBA'), txt_img)


def get_pillow_img(imgbytes):
    """
    Creates and returns a Pillow image from the given image bytes
    :param imgbytes: the bytes of the image
    """
    return Image.open(BytesIO(imgbytes))

# END DO NOT CHANGE SECTION
# --------------------------------------------------------------------

def get_labels(img, confidence=50):
    """
    Gets the labels from AWS Rekognition for the given image
    :param img: either the image bytes or a string that is the URL or filename for an image
    :param confidence: the confidence level (defaults to 50)

    >>> get_labels('http://www.idothat.us/images/idothat-img/features/pool-patio-lanai/ft-pool-patio-lanai-2.jpg')
    [{'Name': 'Pool', 'Confidence': 96.66264343261719}, {'Name': 'Water', 'Confidence': 96.66264343261719}, {'Name': 'Resort', 'Confidence': 76.01207733154297}, {'Name': 'Swimming Pool', 'Confidence': 76.01207733154297}, {'Name': 'Balcony', 'Confidence': 66.56996154785156}, {'Name': 'Patio', 'Confidence': 62.89345169067383}, {'Name': 'Flagstone', 'Confidence': 59.46694564819336}, {'Name': 'Backyard', 'Confidence': 56.5162467956543}, {'Name': 'Yard', 'Confidence': 56.5162467956543}, {'Name': 'Path', 'Confidence': 52.408050537109375}, {'Name': 'Sidewalk', 'Confidence': 52.408050537109375}, {'Name': 'Walkway', 'Confidence': 52.408050537109375}, {'Name': 'Alley', 'Confidence': 50.79618835449219}, {'Name': 'Alleyway', 'Confidence': 50.79618835449219}, {'Name': 'Road', 'Confidence': 50.79618835449219}, {'Name': 'Street', 'Confidence': 50.79618835449219}, {'Name': 'Town', 'Confidence': 50.79618835449219}, {'Name': 'Plant', 'Confidence': 50.6763801574707}]

    >>> get_labels('http://www.idothat.us/images/idothat-img/features/pool-patio-lanai/ft-pool-patio-lanai-2.jpg', 90)
    [{'Name': 'Pool', 'Confidence': 96.66264343261719}, {'Name': 'Water', 'Confidence': 96.66264343261719}]
    """
    # The following code was modified from https://github.com/drpventura/PythonRekognitionDemo/blob/master/labels.py last accessed 10/12/2017
    client = boto3.client('rekognition')

    imgurl = img
    #imgurl = 'http://www.idothat.us/images/idothat-img/features/pool-patio-lanai/ft-pool-patio-lanai-2.jpg'

    # grab the image from online
    imgbytes = image_helpers.get_image_from_url(imgurl)

    rekresp = client.detect_labels(Image={'Bytes': imgbytes},
                                   MinConfidence=confidence)
    return rekresp['Labels']


def label_image(img, confidence=50):
    '''
    Creates and returns a copy of the image, with labels from Rekognition displayed on it
    :param img: a string that is either the URL or filename for the image
    :param confidence: the confidence level (defaults to 50)
    :return: a copy of the image, with labels from Rekognition displayed on it
    '''
    #The following code was modified from https://github.com/drpventura/PythonRekognitionDemo/blob/master/labels.py last accessed 10/12/2017
    #As well as https://github.com/drpventura/PythonRekognitionDemo/blob/master/face_detect_graphical.py last accessed 10/12/2017
    client = boto3.client('rekognition')

    imgurl = img

    imgbytes = image_helpers.get_image_from_url(imgurl)

    img = Image.open(BytesIO(imgbytes))
    rekresp = client.detect_labels(Image={'Bytes': imgbytes},
                                  MaxLabels=7, MinConfidence=confidence)
    # prepare to draw on the image
    draw = ImageDraw.Draw(img)

    words = []

    for label in rekresp['Labels']:
        words.append((label['Name']))

    img1 = add_text_to_img(img, words, (0,0), (0,0,0), (255, 255, 255, 128), 80)

    return img1

if __name__ == "__main__":
    # can't use input since PyCharm's console causes problems entering URLs
    # img = input('Enter either a URL or filename for an image: ')
    #img = 'https://blog.njsnet.co/content/images/2017/02/trumprecognition.png'
    img = 'https://www.parrots.org/images/uploads/dreamstime_C_47716185.jpg'
    labelled_image = label_image(img)
    labelled_image.show()
