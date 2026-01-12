from flask import Flask, request, render_template
from requests.exceptions import ConnectionError, Timeout
import requests

app = Flask(__name__)

be_base_url = "http://backend:5000"

@app.route('/', methods=['GET', 'POST'])
def index():
    message = None
    secret = None

    if request.method == 'POST':
        name = request.form.get('username', '')

        if name:
            try:
                response = requests.get(f"{be_base_url}/message/{name}")
                if response.status_code == 200:
                    message = response.json()['message']

                response = requests.get(f"{be_base_url}/secret-message/{name}")
                if response.status_code == 200:
                    secret = response.json()['message']

            except (ConnectionError, Timeout):
                return render_template('error.html'), 503

    return render_template('index.html', message=message, secret=secret)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
