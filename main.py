from flask import Flask
import subprocess
import os

app = Flask(__name__)

@app.route('/')
def home():
    return "Discord Exporter is running. Go to /export to start exporting."

@app.route('/export')
def run_export():
    try:
        # Run the export script
        result = subprocess.run(["bash", "export.sh"], capture_output=True, text=True, timeout=120)
        return f"Export completed:<br><pre>{result.stdout}</pre><br><pre>{result.stderr}</pre>"
    except Exception as e:
        return f"Error executing the script: {str(e)}"

if __name__ == '__main__':
    # Run the server on port 10000 (Render-compatible)
    app.run(host='0.0.0.0', port=10000)
