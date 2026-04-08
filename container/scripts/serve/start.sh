#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

container start "$SERVE_CONTAINER"

PORT=$(container inspect "$SERVE_CONTAINER" 2>/dev/null | grep -o '"hostPort":[0-9]*' | head -1 | grep -o '[0-9]*' || echo "$DEFAULT_PORT")

echo ""
echo "=== portfolio-serve ==="
echo "  URL:       http://localhost:$PORT"
echo "  Container: $SERVE_CONTAINER"
echo "  Port:      $PORT"
echo "======================="
