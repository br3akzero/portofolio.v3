---
name: container-stop
description: Stop and remove the portfolio container. Use when the user wants to stop, tear down, or clean up the running container.
---

# Container Stop

Stop and remove the portfolio container.

## Usage

Run the bundled script from the project root:

```bash
.opencode/skills/container-stop/stop.sh
```

With a custom container name:

```bash
.opencode/skills/container-stop/stop.sh -n myapp
```

Options:
- `-n NAME` -- Container name (default: `portfolio`)

## What the script does

1. Stops the running container
2. Removes the container

## Instructions

1. Run the script using Bash from the project root directory
2. Report the result to the user
