---
name: container-start
description: Build and run the portfolio site locally using Apple's container CLI. Handles teardown of existing containers, builder cache clearing, full rebuild, and startup.
---

# Container Start

Build and run the portfolio site in a local Apple container.

## Usage

Run the bundled script from the project root:

```bash
.opencode/skills/container-start/start.sh
```

Force rebuild the image (after dependency changes):

```bash
.opencode/skills/container-start/start.sh --rebuild
```

With custom arguments:

```bash
.opencode/skills/container-start/start.sh -n myapp -t myapp -f Dockerfile.prod
```

Options:
- `-n NAME` -- Container name (default: `portfolio`)
- `-t TAG` -- Image tag (default: `portfolio`)
- `-f DOCKERFILE` -- Path to Dockerfile (default: `Dockerfile`)
- `-r, --rebuild` -- Force rebuild the image (e.g. after dependency changes)

## How it works

The project directory is bind-mounted into the container (`-v host:container`). File changes on the host are immediately visible inside the container without rebuilding. The image only contains installed dependencies.

Only rebuild with `--rebuild` when `package.json` or `bun.lock` change.

## What the script does

1. Starts the container system service
2. Stops and removes any existing container with the given name
3. Builds the image if it does not exist (or if `--rebuild` is set)
4. Runs the container with the project directory bind-mounted to `/app`
5. Resolves the container IP and verifies the site is reachable
6. Prints the URL

## Instructions

1. Run the script using Bash from the project root directory
2. Report the final URL to the user
3. Only use `--rebuild` when dependencies have changed

## Important

- Always run from the project root (the bind mount uses the current directory)
- No rebuild needed for file changes - they are reflected immediately via the bind mount
