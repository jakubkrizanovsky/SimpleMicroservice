from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/hello')
def hello():
    message = f'Hello!'
    response = f'{{ "message": "{message}" }}\r\n'
    code = 200
    return response, code,  {'Content-Type': 'application/json'}

@app.route("/healthcheck")
def healthcheck():
    return jsonify({"status": "OK"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0")
