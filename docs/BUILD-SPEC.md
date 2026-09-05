# Build Specification

## Goal

Provide a reusable, generic GitHub Codespaces baseline for Salesforce DX projects without embedding org credentials or project-specific secrets.

## Included

- A non-root Node.js 22 development container with Salesforce CLI.
- Salesforce-aware VS Code extensions and shell defaults.
- Standard Salesforce DX project structure.
- Setup and configuration validation scripts.
- A minimal GitHub Actions workflow for pull requests and pushes.

## Explicitly excluded

- Salesforce usernames, passwords, security tokens, scratch-org credentials, auth URLs, or certificates.
- Org-specific metadata, namespaces, package IDs, and deployment policies.
- Automatic authentication or deployments from the Codespace.

## Safety requirements

- Keep authentication interactive or inject credentials through Codespaces secrets.
- Keep `.sf/`, `.sfdx/`, environment files, and key material out of version control.
- Review deployment commands and target orgs before execution.
