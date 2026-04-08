#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

container stop "$DEV_CONTAINER"
echo "Container '$DEV_CONTAINER' stopped."
