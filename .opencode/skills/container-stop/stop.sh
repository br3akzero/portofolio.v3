#!/bin/bash
# Stop and remove the portfolio container.
#
# Usage:
#   ./stop.sh              # Defaults: name=portfolio
#   ./stop.sh -n myapp
#
# Options:
#   -n NAME   Container name (default: portfolio)
#   -h        Show help

set -euo pipefail

NAME="portfolio"

usage() {
    echo "Usage: $0 [-n name]"
    echo "  -n  Container name (default: portfolio)"
    exit 0
}

while getopts "n:h" opt; do
    case "$opt" in
        n) NAME="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

echo "==> Stopping container '${NAME}'..."
container stop "$NAME" 2>/dev/null || true

echo "==> Removing container '${NAME}'..."
container rm "$NAME" 2>/dev/null || true

echo "==> Container '${NAME}' stopped and removed."
