#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

echo "Building dev image..."
container build -f "$PROJECT_DIR/container/dev.Dockerfile" -t "$DEV_IMAGE" "$PROJECT_DIR"

echo "Removing old container if it exists..."
container rm "$DEV_CONTAINER" 2>/dev/null || true

echo "Creating dev container..."
container run -d \
  --name "$DEV_CONTAINER" \
  --memory 8G \
  --volume "$PROJECT_DIR:/app" \
  --volume "$HOME/.config/opencode:/root/.config/opencode" \
  --volume "$HOME/.local/share/opencode:/root/.local/share/opencode" \
  --volume "$HOME/Developer/Agents/Skills:/root/.claude/skills" \
  "$DEV_IMAGE"

echo "Installing opencode plugins for Linux..."
container exec "$DEV_CONTAINER" sh -c "cd /root/.config/opencode && bun install"

echo "Container '$DEV_CONTAINER' is ready. Use scripts/dev/shell.sh to access it."
