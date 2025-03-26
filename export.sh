#!/bin/bash

# Ensure the Discord token is provided
DISCORD_TOKEN=$1  # Get the token from the first argument

# Install Discord Chat Exporter if not already installed
if ! command -v DiscordChatExporter.Cli &> /dev/null; then
  echo "Discord Chat Exporter not found, installing..."
  curl -sSL https://github.com/Tyrrrz/DiscordChatExporter/releases/download/v2.44.2/DiscordChatExporter.Cli.linux-x64.zip -o DiscordChatExporter.Cli.linux-x64.zip
  unzip DiscordChatExporter.Cli.linux-x64.zip
fi

# Get the current timestamp for 24 hours ago
AFTER_TIMESTAMP=$(date -d "24 hours ago" +%s)

# Export messages from the Discord channel (make sure to replace channel_id and other necessary parameters)
echo "Starting export..."
./DiscordChatExporter.Cli export --token $DISCORD_TOKEN --channel "497312527550775297" --output "output.html" --after $AFTER_TIMESTAMP

echo "Export completed."
