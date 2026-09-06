#!/usr/bin/env bash

set -euo pipefail

required_files=(
  '.devcontainer/devcontainer.json'
  '.devcontainer/Dockerfile'
  '.github/copilot-instructions.md'
  '.github/prompts/opsx-apply.prompt.md'
  '.github/prompts/opsx-archive.prompt.md'
  '.github/prompts/opsx-explore.prompt.md'
  '.github/prompts/opsx-propose.prompt.md'
  '.github/prompts/opsx-sync.prompt.md'
  '.github/prompts/opsx-update.prompt.md'
  '.github/skills/openspec-apply-change/SKILL.md'
  '.github/skills/openspec-archive-change/SKILL.md'
  '.github/skills/openspec-explore/SKILL.md'
  '.github/skills/openspec-propose/SKILL.md'
  '.github/skills/openspec-sync-specs/SKILL.md'
  '.github/skills/openspec-update-change/SKILL.md'
  'config/project-scratch-def.json'
  'config/openspec-version.txt'
  'openspec/config.yaml'
  'openspec/specs/repository-governance/spec.md'
  'sfdx-project.json'
  'README.md'
)

for file in "${required_files[@]}"; do
  [[ -f "$file" ]] || { echo "Missing required file: $file" >&2; exit 1; }
done

for file in '.devcontainer/devcontainer.json' 'config/project-scratch-def.json' 'sfdx-project.json'; do
  jq empty "$file"
done

package_path="$(jq -r '.packageDirectories[0].path // empty' sfdx-project.json)"
[[ -n "$package_path" ]] || { echo 'sfdx-project.json must define a package directory' >&2; exit 1; }
[[ -d "$package_path" ]] || { echo "Package directory does not exist: $package_path" >&2; exit 1; }

pinned_openspec_version="$(tr -d '[:space:]' < config/openspec-version.txt)"
[[ -n "$pinned_openspec_version" ]] || { echo 'config/openspec-version.txt must not be empty' >&2; exit 1; }

echo 'Template configuration is valid.'

if command -v sf >/dev/null 2>&1; then
  sf --version
else
  echo "Salesforce CLI not found; configuration-only validation completed."
fi

if command -v openspec >/dev/null 2>&1; then
  installed_openspec_version="$(npm list --global @fission-ai/openspec --json | jq -r '.dependencies["@fission-ai/openspec"].version // empty')"
  [[ -n "$installed_openspec_version" ]] || { echo 'Could not determine installed OpenSpec version' >&2; exit 1; }
  [[ "$installed_openspec_version" == "$pinned_openspec_version" ]] || {
    echo "OpenSpec version mismatch: expected $pinned_openspec_version but found $installed_openspec_version" >&2
    exit 1
  }
  openspec validate --all --strict --no-interactive
else
  if [[ "${ALLOW_MISSING_OPENSPEC:-0}" == "1" ]]; then
    echo "OpenSpec not found; repository file checks passed but strict OpenSpec validation was skipped."
  else
    echo "OpenSpec is required for the default validation path. Use the Codespace, install the version pinned in config/openspec-version.txt, or rerun with ALLOW_MISSING_OPENSPEC=1 for a reduced file-only check." >&2
    exit 1
  fi
fi
