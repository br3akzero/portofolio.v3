#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

container stop "$SERVE_CONTAINER"
echo "Container '$SERVE_CONTAINER' stopped."
