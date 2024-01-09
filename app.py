from flask import Flask, request, jsonify
from paddleocr import PaddleOCR

app = Flask(__name__)


def checkStr(nested_list_or_tuple):
    results = []
    for i in nested_list_or_tuple:
        if isinstance(i, (list, tuple)):
            if len(i) > 1 and isinstance(i[1], (list, tuple)) and len(i[0]) > 1:
                if isinstance(i[1][0], str):
                    results.append(i[1][0]+"\n")
            results += checkStr(i)
    return results


@app.route('/')
def hello_world():
    ocr = PaddleOCR(use_angle_cls=True, lang="ch")
    url = request.args.get('url', '')
    result = ocr.ocr(url, cls=True)
    data = {
        "code": 200,
        "result": "".join(checkStr(result))
    }
    return jsonify(data)


if __name__ == '__main__':
    app.run()
