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
