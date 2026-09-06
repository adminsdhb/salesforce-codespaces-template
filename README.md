# Salesforce Codespaces Template

Reusable GitHub Codespaces starter for Salesforce CLI and Salesforce DX development.

The template provides a non-root development container, Salesforce CLI, OpenSpec for spec-driven development, useful VS Code extensions, a baseline `force-app` project structure, setup helpers, and configuration-only CI validation. It intentionally does not authenticate to an org or include org-specific metadata.

## Prerequisites

- A GitHub account with Codespaces access.
- A Salesforce org and permission to use Salesforce CLI.
- VS Code with the Dev Containers extension if you also want to run the container locally.

## Create a project from this template

1. Select **Use this template** on GitHub.
2. Name the new repository for the Salesforce project.
3. Create a Codespace from the new repository.
4. Wait for the container to finish building and run the post-create validation.

For a local checkout, run **Reopen in Container** from VS Code after installing the Dev Containers extension.

## Authenticate safely

Use an interactive web login inside the Codespace:

```bash
sf org login web --alias dev --set-default
sf org list
```

For CI or non-interactive workflows, store credentials in GitHub Actions or Codespaces secrets and follow Salesforce's recommended authentication flow. Never commit usernames, passwords, security tokens, auth URLs, private keys, or certificates. The repository ignores common Salesforce state directories and credential file patterns by default.

## Common commands

```bash
# Check the installed CLI
sf --version
openspec --version

# Create a scratch org from the included definition
sf org create scratch --definition-file config/project-scratch-def.json --alias scratch --set-default --duration-days 7

# Deploy source to the current default org
sf project deploy start --source-dir force-app

# Run local Apex tests after adding test metadata
sf apex run test --target-org scratch --wait 10 --result-format human

# Open the current default org
sf org open
```

The `scripts/setup.sh` file prints a short onboarding sequence, and `scripts/validate.sh` checks that the template's required files, OpenSpec configuration, and JSON configuration remain valid. By default it also requires `openspec` so strict OpenSpec validation runs; for an explicit reduced file-only check outside the Codespace, use `ALLOW_MISSING_OPENSPEC=1 bash scripts/validate.sh`.

## Spec-driven development

This template now ships with OpenSpec already initialized in the repository so every meaningful change can start from a spec before code is edited.

Use the generated GitHub Copilot prompts from this repository:

1. `/opsx-explore` to inspect the codebase before changing it.
2. `/opsx-propose "your change"` to create proposal, design, spec, and task artifacts under `openspec/changes/`.
3. `/opsx-apply` only after the plan is reviewed.
4. `/opsx-sync` and `/opsx-archive` to merge completed deltas back into `openspec/specs/`.

Repository expectations:

- Keep `openspec/` artifacts in version control with the code they describe.
- Start non-trivial repository changes with OpenSpec planning.
- Update the relevant specs whenever template behavior changes.
- Run `bash scripts/validate.sh` inside the Codespace or another environment where `openspec` is installed for the authoritative validation pass.

## Project layout

```text
.
├── .devcontainer/       # Codespaces image and post-create setup
├── .github/prompts/     # GitHub Copilot OpenSpec slash commands
├── .github/skills/      # GitHub Copilot OpenSpec skills
├── .github/workflows/    # Configuration validation
├── config/              # Scratch-org definitions and project config
├── openspec/            # Specs, active change plans, and archive
├── force-app/            # Salesforce source metadata
├── scripts/              # Setup and validation helpers
├── docs/                 # Template design notes
└── sfdx-project.json     # Salesforce DX project manifest
```

## Environment variables and secrets

Keep non-sensitive local defaults in an uncommitted `.env` file only when a tool requires them. Put shared or sensitive values in GitHub Codespaces secrets or repository/environment secrets. Prefer short-lived authentication and least-privilege connected apps. Do not print secret values in scripts or CI logs.

## Updating the template

- Start with `/opsx-explore` or `/opsx-propose` for any non-trivial template change.
- Pin `SF_CLI_VERSION` in `.devcontainer/Dockerfile` when reproducible builds matter.
- Keep the pinned OpenSpec version in `config/openspec-version.txt`; the Codespace image, CI, and local validation all read or enforce that file.
- Update `sourceApiVersion` in `sfdx-project.json` to match the Salesforce API version used by a project.
- Keep the extension list small and project-agnostic.
- Run `bash scripts/validate.sh` before opening a pull request.
