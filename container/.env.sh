#!/bin/sh

PROJECT_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

DEV_IMAGE="portfolio-dev:latest"
DEV_CONTAINER="portfolio-dev"

SERVE_IMAGE="portfolio-serve:latest"
SERVE_CONTAINER="portfolio-serve"
DEFAULT_PORT=5173
