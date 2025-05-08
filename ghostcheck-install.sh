#!/bin/bash

echo "🛠️  GhostCheck Installer (by Ruben Valencia / GhostOps)"

# 🔍 Check for required tools
MISSING=""
for tool in bash curl jq; do
  if ! command -v $tool >/dev/null 2>&1; then
    MISSING+="$tool "
  fi
done

if [[ -n "$MISSING" ]]; then
  echo "❌ Missing required tools: $MISSING"
  echo "Please install them and re-run this installer."
  exit 1
fi

# 🔄 Install to /usr/local/bin
echo "📂 Copying ghostcheck to /usr/local/bin ..."
sudo cp ghostcheck /usr/local/bin/ghostcheck
sudo chmod +x /usr/local/bin/ghostcheck

# ✅ Done
echo "✅ GhostCheck is installed!"
echo "💡 Try it now: ghostcheck example.com"
echo "📁 Logs will be saved to: ~/logs/domain_health"
