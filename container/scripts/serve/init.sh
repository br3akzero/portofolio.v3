#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

echo "Building serve image..."
container build -f "$PROJECT_DIR/container/serve.Dockerfile" -t "$SERVE_IMAGE" "$PROJECT_DIR"

echo "Removing old container if it exists..."
container rm "$SERVE_CONTAINER" 2>/dev/null || true

PORT="${1:-$DEFAULT_PORT}"

echo "Creating serve container..."
container run -d \
  --name "$SERVE_CONTAINER" \
  -p "$PORT:$PORT" \
  --volume "$PROJECT_DIR:/app" \
  "$SERVE_IMAGE"

echo ""
echo "=== portfolio-serve ==="
echo "  URL:       http://localhost:$PORT"
echo "  Container: $SERVE_CONTAINER"
echo "  Port:      $PORT"
echo "======================="
