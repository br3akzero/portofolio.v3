#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

container start "$DEV_CONTAINER"
echo "Container '$DEV_CONTAINER' started."
