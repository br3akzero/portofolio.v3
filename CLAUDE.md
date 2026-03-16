# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
bun dev      # Start development server (Vite on port 5173)
bun run build    # Type-check with tsc, then build for production
bun run preview  # Preview production build
```

## Tech Stack

- **Vite** with vanilla TypeScript (no framework)
- **Bun** as package manager and runtime
- TypeScript configured with strict mode, ES2020 target, bundler module resolution

## Project Structure

This is a minimal portfolio/landing page. Entry point is `src/main.ts` which imports `src/style.css`. The HTML in `index.html` contains the static content structure.

## Development Environment

Dev container available with Node.js 22 + TypeScript + Bun. Forwards port 5173 for Vite dev server.

## Container (Apple container CLI)

This project includes a `Dockerfile` and can be run locally using Apple's native `container` CLI (no Docker required). Requires Apple silicon and macOS 15.0+.

### Quick start

```bash
container system start                                    # Start the system service (once)
container build --tag portfolio --file Dockerfile .       # Build the image
container run --name portfolio --detach portfolio:latest   # Run in background
container inspect portfolio                               # Get the container's IP address
```

Access the site at `http://<container-ip>:5173`. Each container gets its own dedicated IP (no port mapping needed).

### Common commands

```bash
container ls                # List running containers
container logs portfolio    # View logs
container stop portfolio    # Stop the container
container rm portfolio      # Remove the container
container images            # List built images
```

### Rebuild after changes

```bash
container stop portfolio && container rm portfolio
container build --tag portfolio --file Dockerfile .
container run --name portfolio --detach portfolio:latest
```
