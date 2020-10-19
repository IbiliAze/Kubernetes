from flask import Flask, jsonify, request
import requests


app = Flask(__name__)

@app.route('/api/config/', methods=['POST'])
def post_config():
        content = request.get_json()
        print(content)
        return content

if __name__ == '__main__':
        app.run(host='0.0.0.0')
