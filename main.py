from flask import Flask
import subprocess

app = Flask(__name__)

@app.route('/')
def home():
    return "Discord Exporter is running. Go to /export to start exporting."

@app.route('/export')
def run_export():
    try:
        # Run the export script asynchronously (in the background)
        subprocess.Popen(["bash", "export.sh"])
        # Immediately return a minimal confirmation message
        return "Export triggered successfully", 200
    except Exception as e:
        return f"Error executing export.sh: {str(e)}", 500

if __name__ == '__main__':
    # Run the server on port 10000 (Render-compatible)
    app.run(host='0.0.0.0', port=10000)
