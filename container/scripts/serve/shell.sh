#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

container exec -it "$SERVE_CONTAINER" sh
