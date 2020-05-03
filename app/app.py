from typing import List, Dict
from flask import Flask
import mysql.connector
import json

app = Flask(__name__)


def surface_form() -> List[Dict]:
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'sanskrit'
    }
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM surface')
    results = [{"roman": roman, "devanagari": devanagari} for (id, devanagari, roman, verse, position, line) in cursor]
    cursor.close()
    connection.close()

    return results


@app.route('/')
def index() -> str:
    return json.dumps({'surface_from': surface_form()})


if __name__ == '__main__':
    app.run(host='0.0.0.0')
