from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/message/<name>')
def hello(name: str):
    message = f'Hello {name}!'
    response = f'{{ "message": "{message}" }}\r\n'
    code = 200
    return response, code,  {'Content-Type': 'application/json'}

@app.route('/secret-message/<name>')
def secret(name: str):
    response:dict = {'message': None}
    code:int = -1
    if name.lower() == 'jakub':
        response['message'] = 'Super secret message!'
        code = 200
    else:
        code = 418
        
    return response, code,  {'Content-Type': 'application/json'}
    

@app.route("/healthcheck")
def healthcheck():
    return jsonify({"status": "OK"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0")
