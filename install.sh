#!/bin/bash
echo "🧪 Installing GhostCheck..."
INSTALL_DIR="/usr/local/bin"
SCRIPT_PATH="$HOME/scripts/domain_health_check.sh"

if [ ! -f "$SCRIPT_PATH" ]; then
  echo "❌ Script not found at $SCRIPT_PATH"
  exit 1
fi

sudo ln -sf "$SCRIPT_PATH" "$INSTALL_DIR/ghostcheck"
sudo chmod +x "$INSTALL_DIR/ghostcheck"
echo "✅ Installed! Try: ghostcheck google.com"
