ARG NODE_IMAGE=mcr.microsoft.com/devcontainers/javascript-node:22-bookworm
FROM ${NODE_IMAGE}

ARG SF_CLI_VERSION=latest
ARG OPENSPEC_VERSION=1.12.0

USER root

RUN apt-get update \
    && apt-get install --yes --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --global "@salesforce/cli@${SF_CLI_VERSION}" "@fission-ai/openspec@${OPENSPEC_VERSION}" \
    && npm cache clean --force

USER node
