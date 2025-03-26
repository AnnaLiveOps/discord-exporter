#!/bin/bash

# Define variables
DISCORD_EXPORTER_DIR="DiscordChatExporter"
DISCORD_TOKEN="$DISCORD_TOKEN"
MAKE_WEBHOOK_URL="https://hook.eu2.make.com/53nvbfmb02na8mh928dwhvf8vvfku5e8"

# Ensure Discord Chat Exporter is installed
if [ ! -f "$DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli" ]; then
    echo "Discord Chat Exporter not found, installing..."
    mkdir -p $DISCORD_EXPORTER_DIR
    curl -L -o $DISCORD_EXPORTER_DIR/DiscordChatExporter.Cli.linux-x64.zip "https://github.com/Tyrrtz/DiscordChatExporter/releases/download/2.44.2/DiscordChatExporter.Cli.linux-x64.zip"
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

# Send the exported data to Make via the webhook
echo "Sending exported data to Make..."
curl -X POST -H "Content-Type: application/json" -d @output.json "$MAKE_WEBHOOK_URL"
echo "Data sent to Make."
