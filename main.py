from flask import Flask
import subprocess

app = Flask(__name__)

@app.route('/')
def run_export():
    try:
        # Run the export.sh script
        result = subprocess.run(["./export.sh"], capture_output=True, text=True, timeout=60)
        return f"Export completed:<br>Output: {result.stdout}<br>Error: {result.stderr}"
    except Exception as e:
        return f"Error executing the script: {e}"

if __name__ == '__main__':
    # Run the server on port 8080, available to the world
    app.run(host='0.0.0.0', port=8080)
