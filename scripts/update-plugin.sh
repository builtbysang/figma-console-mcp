#!/bin/bash
# update-plugin.sh
# Pull latest from upstream, rebase sang/custom-ui on top, build, copy to stable dir.

set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STABLE_DIR="$HOME/Claude Code/figma-console-mcp/plugin"

cd "$REPO_DIR"

echo "→ Fetching upstream (southleft)..."
git fetch origin

echo "→ Rebasing sang/custom-ui onto origin/main..."
git checkout sang/custom-ui
git rebase origin/main

echo "→ Building..."
pnpm install --frozen-lockfile
pnpm run build:local

echo "→ Copying plugin files to stable dir..."
mkdir -p "$STABLE_DIR"
cp figma-desktop-bridge/ui.html "$STABLE_DIR/ui.html"
cp figma-desktop-bridge/code.js  "$STABLE_DIR/code.js"
cp figma-desktop-bridge/manifest.json "$STABLE_DIR/manifest.json"

echo "✓ Done. Reload the plugin in Figma to apply changes."
