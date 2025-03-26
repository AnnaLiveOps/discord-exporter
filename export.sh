#!/bin/bash

# Ensure the Discord token is provided
if [ -z "$1" ]; then
  echo "Error: Discord token not provided!"
  exit 1
fi

DISCORD_TOKEN=$1  # Get the token from the first argument

# Install Discord Chat Exporter if not already installed
if ! command -v discord-chat-exporter &> /dev/null; then
  echo "Discord Chat Exporter not found, installing..."
  # You can modify this based on how you want to install DiscordChatExporter
  curl -sSL https://github.com/Tyrrrz/DiscordChatExporter/releases/download/v3.0.0/DiscordChatExporter.Cli-linux-x64.tar.gz | tar -xz
fi

# Export messages from the Discord channel (make sure to replace channel_id and other necessary parameters)
echo "Starting export..."
./DiscordChatExporter.Cli -t $DISCORD_TOKEN export -c "YOUR_CHANNEL_ID" -f "html" -o "output.html"

echo "Export completed."
