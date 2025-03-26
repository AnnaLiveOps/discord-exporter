from flask import Flask
import subprocess
import os  # To access the secrets from environment variables

app = Flask(__name__)

@app.route('/')
def run_export():
    try:
        # Fetch Discord token from GitHub secrets
        discord_token = os.getenv("DISCORD_TOKEN")  # Get the Discord token from the environment

        # Ensure the token is available before proceeding
        if not discord_token:
            return "Error: DISCORD_TOKEN not found in environment variables!"

        # Run the export.sh script with the token as an environment variable
        result = subprocess.run(
            ["./export.sh", discord_token],  # Pass the token to the script if necessary
            capture_output=True, 
            text=True, 
            timeout=60
        )

        return f"Export completed:<br>Output: {result.stdout}<br>Error: {result.stderr}"

    except Exception as e:
        return f"Error executing the script: {e}"

if __name__ == '__main__':
    # Run the server on port 8080, available to the world
    app.run(host='0.0.0.0', port=8080)

