#!/bin/bash

# Ensure the Discord token is provided
if [ -z "$DISCORD_TOKEN" ]; then
  echo "Error: Discord token not provided!"
  exit 1
fi

DISCORD_EXPORTER_URL="https://github.com/Tyrrrz/DiscordChatExporter/releases/download/2.44.2/DiscordChatExporter.Cli.linux-x64.zip"
DISCORD_EXPORTER_FILE="DiscordChatExporter.Cli.linux-x64.zip"
DISCORD_EXPORTER_DIR="DiscordChatExporter"

# Check if DiscordChatExporter is already installed
if [ ! -d "$DISCORD_EXPORTER_DIR" ]; then
  echo "Discord Chat Exporter not found, installing..."
  
  # Download the file
  curl -L -o "$DISCORD_EXPORTER_FILE" "$DISCORD_EXPORTER_URL"

  # Verify the file is a valid ZIP
  if ! unzip -tq "$DISCORD_EXPORTER_FILE"; then
    echo "Error: Downloaded file is not a valid ZIP archive!"
    exit 1
  fi

  # Extract and clean up
  unzip -o "$DISCORD_EXPORTER_FILE" -d "$DISCORD_EXPORTER_DIR"
  rm "$DISCORD_EXPORTER_FILE"
fi

# Run the export with the last 24h filter
echo "Starting export..."
./$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli export \
  --token "$DISCORD_TOKEN" \
  --channel "497312527550775297" \
  --output "output.html" \
  --after "$(date -u -d '24 hours ago' +%Y-%m-%dT%H:%M:%S)"

echo "Export completed."

