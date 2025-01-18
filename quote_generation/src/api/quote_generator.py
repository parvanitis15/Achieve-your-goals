# File: src/api/quote_generator.py

from flask import Flask, jsonify
from models.quote_model import generate_query_response


QUERY = "Generate an inspiring quote about building new habits. The quote should be concise, no longer than 20 words."


def generate_quote():
    return generate_query_response(QUERY)


app = Flask(__name__)

@app.route('/generate_quote', methods=['GET'])
def generate_quote_api():
    quote = generate_quote()
    print(quote)
    return jsonify({"quote": quote})


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
