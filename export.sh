#!/bin/bash

# Ensure the Discord token is provided via environment variable
if [ -z "$DISCORD_TOKEN" ]; then
  echo "Error: Discord token not provided in environment variable!"
  exit 1
fi

# Use the Discord token from the environment variable
DISCORD_TOKEN=$DISCORD_TOKEN  # Get the token from the environment variable

# Install Discord Chat Exporter if not already installed
if ! command -v discord-chat-exporter &> /dev/null; then
  echo "Discord Chat Exporter not found, installing..."
  # You can modify this based on how you want to install DiscordChatExporter
  curl -sSL https://github.com/Tyrrrz/DiscordChatExporter/releases/download/v3.0.0/DiscordChatExporter.Cli-linux-x64.tar.gz | tar -xz
fi

# Calculate the Unix timestamp for 24 hours ago
timestamp=$(date -d "24 hours ago" +%s)

# Export messages from the Discord channel for the last 24 hours
echo "Starting export..."
./DiscordChatExporter.Cli -t $DISCORD_TOKEN export -c "497312527550775297" -f "html" -o "output.html" --after $timestamp

echo "Export completed."

