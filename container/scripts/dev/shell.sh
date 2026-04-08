#!/bin/sh
set -e

. "$(dirname "$0")/../../.env.sh"

container exec -it "$DEV_CONTAINER" sh
