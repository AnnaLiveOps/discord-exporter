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
    curl -L -o "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip" "https://github.com/Tyrrtz/DiscordChatExporter/releases/download/2.44.2/DiscordChatExporter.Cli.linux-x64.zip"
    
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

# Run the export for
