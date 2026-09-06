ARG NODE_VERSION=22
FROM mcr.microsoft.com/devcontainers/javascript-node:${NODE_VERSION}-bookworm

ARG SF_CLI_VERSION=latest
USER root

RUN apt-get update \
    && apt-get install --yes --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

COPY config/openspec-version.txt /tmp/openspec-version.txt

RUN OPENSPEC_VERSION="$(tr -d '[:space:]' < /tmp/openspec-version.txt)" \
    && test -n "${OPENSPEC_VERSION}" \
    && npm install --global "@salesforce/cli@${SF_CLI_VERSION}" "@fission-ai/openspec@${OPENSPEC_VERSION}" \
    && npm cache clean --force

USER node
