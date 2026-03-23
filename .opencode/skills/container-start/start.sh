#!/bin/bash
# Starts the portfolio container with a bind mount to the project directory.
# File changes on the host are immediately visible inside the container.
# Only rebuilds the image when dependencies (package.json/bun.lock) change.
#
# Usage:
#   ./start.sh                          # Start with defaults
#   ./start.sh --rebuild                # Force image rebuild (e.g. after dependency changes)
#   ./start.sh -n myapp -t myapp -f Dockerfile.prod
#
# Options:
#   -n NAME         Container name        (default: portfolio)
#   -t TAG          Image tag             (default: portfolio)
#   -f DOCKERFILE   Path to Dockerfile    (default: Dockerfile)
#   -r, --rebuild   Force rebuild the image before starting
#   -h              Show help

set -euo pipefail

NAME="portfolio"
TAG="portfolio"
DOCKERFILE="Dockerfile"
REBUILD=false

usage() {
    echo "Usage: $0 [-n name] [-t tag] [-f dockerfile] [-r|--rebuild]"
    echo "  -n          Container name      (default: portfolio)"
    echo "  -t          Image tag           (default: portfolio)"
    echo "  -f          Path to Dockerfile  (default: Dockerfile)"
    echo "  -r,--rebuild  Force rebuild the image (e.g. after dependency changes)"
    exit 0
}

# Parse long options
for arg in "$@"; do
    case "$arg" in
        --rebuild) REBUILD=true; shift ;;
    esac
done

while getopts "n:t:f:rh" opt; do
    case "$opt" in
        n) NAME="$OPTARG" ;;
        t) TAG="$OPTARG" ;;
        f) DOCKERFILE="$OPTARG" ;;
        r) REBUILD=true ;;
        h) usage ;;
        *) usage ;;
    esac
done

IMAGE="${TAG}:latest"
PROJECT_DIR="$(pwd)"

echo "==> Starting container system..."
container system start 2>/dev/null || true

echo "==> Tearing down existing container '${NAME}'..."
container stop "$NAME" 2>/dev/null || true
container rm "$NAME" 2>/dev/null || true

# Check if image exists
IMAGE_EXISTS=$(container image list 2>/dev/null | grep -c "$TAG" || true)

if [ "$REBUILD" = true ] || [ "$IMAGE_EXISTS" -eq 0 ]; then
    if [ "$REBUILD" = true ]; then
        echo "==> Deleting old image '${IMAGE}'..."
        container image delete "$IMAGE" 2>/dev/null || true
    fi
    echo "==> Building image '${IMAGE}' from ${DOCKERFILE}..."
    container build --tag "$TAG" --file "$DOCKERFILE" .
else
    echo "==> Image '${IMAGE}' exists, skipping build (use --rebuild to force)"
fi

echo "==> Starting container '${NAME}' with bind mount to ${PROJECT_DIR}..."
container run \
    --name "$NAME" \
    --detach \
    -v "${PROJECT_DIR}:/app" \
    "$IMAGE"

echo "==> Resolving container IP..."
IP=$(container inspect "$NAME" | python3 -c "import sys,json; print(json.load(sys.stdin)[0]['networks'][0]['address'].split('/')[0])")

echo "==> Waiting for Vite to start..."
sleep 3

STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://${IP}:5173/" 2>/dev/null || echo "000")

if [ "$STATUS" = "200" ]; then
    echo "==> Site is live at http://${IP}:5173"
else
    echo "==> Container running at http://${IP}:5173 (HTTP status: ${STATUS})"
    echo "    Check logs with: container logs ${NAME}"
fi
