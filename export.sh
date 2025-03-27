#!/bin/bash

# Define variables
DISCORD_EXPORTER_DIR="DiscordChatExporter"
DISCORD_TOKEN="$DISCORD_TOKEN"
MAKE_WEBHOOK_URL="https://hook.eu2.make.com/53nvbfmb02na8mh928dwhvf8vvfku5e8"

# Ensure Discord Chat Exporter is installed
if [ ! -f "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli" ]; then
    echo "Discord Chat Exporter not found, installing..."
    mkdir -p "$DISCORD_EXPORTER_DIR"
    # Download the ZIP file
    curl -L -o "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip" "https://github.com/Tyrrrz/DiscordChatExporter/releases/download/2.44.2/DiscordChatExporter.Cli.linux-x64.zip"
    
    # Check if the downloaded file is a valid ZIP archive
    if ! unzip -tq "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip" > /dev/null 2>&1; then
      echo "Error: Downloaded file is not a valid ZIP archive!"
      exit 1
    fi
    
    # Extract the ZIP file
    unzip -o "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip" -d "$DISCORD_EXPORTER_DIR"
    chmod +x "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli"
    # Remove the ZIP file after extraction
    rm "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip"
fi

# Calculate the timestamp for 24 hours ago in ISO 8601 format (UTC)
AFTER_TIMESTAMP=$(date -u -d "24 hours ago" +%Y-%m-%dT%H:%M:%SZ)

# Run the export for messages from the last 24 hours
echo "Starting export..."
./"$DISCORD_EXPORTER_DIR"/DiscordChatExporter.Cli export \
  --token "$DISCORD_TOKEN" \
  --channel "497312527550775297" \
  --format "Json" \
  --output "output.json" \
  --after "$AFTER_TIMESTAMP"

echo "Export completed."

# Verify that output.json exists and is not empty
if [ -s "output.json" ]; then
    echo "Wrapping exported JSON data..."
    # Wrap the JSON data in an object with key "data"
    WRAPPED_OUTPUT="wrapped_output.json"
    echo "{\"data\": $(cat output.json)}" > "$WRAPPED_OUTPUT"
    
    echo "Sending wrapped exported data to Make..."
    RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}\n" -X POST -H "Content-Type: application/json" -d @"$WRAPPED_OUTPUT" "$MAKE_WEBHOOK_URL")
    echo "Response from webhook: $RESPONSE"
else
    echo "Warning: output.json is empty or does not exist!"
fi
