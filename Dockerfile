FROM node:23-slim

ARG PACKAGES="git curl make zip unzip ca-certificates python3 python3-pip python3-venv"

RUN apt-get update && \
  apt-get install -y --no-install-recommends ${PACKAGES} && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV GO_VERSION=1.25.0

RUN curl -fsSL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go.tar.gz && \
    rm -rf /usr/local/go && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH

USER node

WORKDIR /app

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH

RUN npm install -g opencode-ai

ENTRYPOINT ["opencode"]

