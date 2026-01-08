from flask import Flask
import requests

app = Flask(__name__)

be_base_url = "http://backend:5000"

@app.route('/')
def get_message():
    be_response = requests.get(be_base_url + "/hello")
    print(f"Received response: {be_response.json()}")
    if be_response.status_code == 200:
        return be_response.json()["message"], 200,  {'Content-Type': 'application/json'}
    else:
        return "error", 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
