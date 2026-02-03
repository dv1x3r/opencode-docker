FROM node:23-slim

ARG PACKAGES="git curl make zip unzip ca-certificates python3 python3-pip python3-venv golang-go"

RUN apt-get update && \
  apt-get install -y --no-install-recommends ${PACKAGES} && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY --from=oven/bun:1 /usr/local/bin/bun /usr/local/bin/bun
RUN ln -s /usr/local/bin/bun /usr/local/bin/bunx

USER node

WORKDIR /app

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH

ENV BUN_INSTALL=/home/node/.bun
ENV PATH=$BUN_INSTALL/bin:$PATH

RUN npm install -g opencode-ai

ENTRYPOINT ["opencode"]

