ARG NODE_IMAGE=mcr.microsoft.com/devcontainers/javascript-node:22-bookworm
FROM ${NODE_IMAGE}

ARG SF_CLI_VERSION=latest
USER root

RUN apt-get update \
    && apt-get install --yes --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

COPY config/openspec-version.txt /tmp/openspec-version.txt

RUN npm install --global "@salesforce/cli@${SF_CLI_VERSION}" "@fission-ai/openspec@$(tr -d '[:space:]' < /tmp/openspec-version.txt)" \
    && npm cache clean --force

USER node
