from flask import Flask, make_response
from flask_restful import reqparse, abort, Api, Resource
import mysql.connector
import json

app = Flask(__name__)
api = Api(app)

parser = reqparse.RequestParser()
parser.add_argument('word', location='json', type=str, required=True)

@api.representation('application/json')
def output_json(data, code, headers=None):
    """Makes a Flask response with a JSON encoded body"""
    dumped = json.dumps(data, ensure_ascii=False).encode('utf-8')
    resp = make_response(dumped, code)
    resp.headers.extend(headers or {})
    return resp


def surface_form():
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'sanskrit'
    }
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM surface LIMIT 5')
    results = [{"roman": roman, "devanagari": devanagari} for (id, devanagari, roman, verse, position, line) in cursor]
    cursor.close()
    connection.close()

    return results


@app.route('/')
def index():
    return json.dumps({'surface_from': surface_form()}, ensure_ascii=False).encode('utf-8')


class WordStudy(Resource):
    def post(self):
        args = parser.parse_args()
        return {"response": args['word']}, 201


api.add_resource(WordStudy, '/word')


if __name__ == '__main__':
    app.run(host='0.0.0.0')
