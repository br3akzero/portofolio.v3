FROM oven/bun:1-alpine

RUN apk add --no-cache curl git bash openssh-client \
  && curl -fsSL https://opencode.ai/install | bash \
  && bun install -g typescript-language-server typescript

ENV PATH="/root/.opencode/bin:$PATH"

RUN git config --global user.name "BreakZer0" \
  && git config --global user.email "daniel.reshad@proton.me"

RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh \
  && echo 'eval $(ssh-agent -s) && ssh-add ~/.ssh/git.personal' >> ~/.bashrc

ENV OPENCODE_NO_TELEMETRY=true
ENV OPENCODE_EXPERIMENTAL_DISABLE_COPY_ON_SELECT=true

WORKDIR /app

CMD ["sleep", "infinity"]
