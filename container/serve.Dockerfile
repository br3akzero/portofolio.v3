FROM oven/bun:1

RUN groupadd -r app && useradd -r -g app app

WORKDIR /app
COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile
RUN chown -R app:app /app

USER app

EXPOSE 5173

CMD ["bun", "dev", "--host", "0.0.0.0"]
