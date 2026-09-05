#!/usr/bin/env bash

set -euo pipefail

required_files=(
  '.devcontainer/devcontainer.json'
  '.devcontainer/Dockerfile'
  'config/project-scratch-def.json'
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

echo 'Template configuration is valid.'

if command -v sf >/dev/null 2>&1; then
  sf --version
else
  echo "Salesforce CLI not found; configuration-only validation completed."
fi
