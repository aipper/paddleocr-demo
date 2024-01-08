from flask import Flask, request
from paddleocr import PaddleOCR

app = Flask(__name__)


@app.route('/')
def hello_world():  # put application's code here
    ocr = PaddleOCR(use_angle_cls=True, lang="ch")
    # image = "2.png"
    # image = "word_4.jpg"
    url = request.args.get('url', '')
    result = ocr.ocr(url, cls=True, det=False)
    return result


if __name__ == '__main__':
    app.run()
