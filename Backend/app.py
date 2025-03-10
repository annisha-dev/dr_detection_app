from flask import Flask, request, jsonify
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)  # Allow Flutter app to access backend

UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)  # Ensure upload folder exists

@app.route("/")
def home():
    return "Backend is Running!"

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
