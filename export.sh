#!/bin/bash

# Define variables
DISCORD_EXPORTER_DIR="DiscordChatExporter"
DISCORD_TOKEN="$DISCORD_TOKEN"

# Ensure Discord Chat Exporter is installed
if [ ! -f "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli" ]; then
    echo "Discord Chat Exporter not found, installing..."
    mkdir -p $DISCORD_EXPORTER_DIR
    curl -L -o $DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip "https://github.com/Tyrrrz/DiscordChatExporter/releases/download/2.44.2/DiscordChatExporter.Cli.linux-x64.zip"
    unzip -o $DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip -d $DISCORD_EXPORTER_DIR
    chmod +x $DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli
fi

# Run the export with the last 24h messages
echo "Starting export..."
./$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli export \
  --token "$DISCORD_TOKEN" \
  --channel "497312527550775297" \
  --format "Json" \
  --output "output.json" \
  --after "$(date -u -d '24 hours ago' +%Y-%m-%dT%H:%M:%SZ)"

echo "Export completed."
