#!/usr/bin/env bash

set -euo pipefail

if ! command -v sf >/dev/null 2>&1; then
  echo "Salesforce CLI is not installed. Reopen this repository in its Codespace."
  exit 1
fi

echo "Salesforce CLI:"
sf --version
echo

if command -v openspec >/dev/null 2>&1; then
  echo "OpenSpec:"
  openspec --version
  echo
else
  echo "OpenSpec: not installed in this shell."
  echo "Run inside the Codespace for the built-in OpenSpec workflow."
  echo
fi

echo "Next steps:"
if command -v openspec >/dev/null 2>&1; then
  echo "  /opsx-explore"
  echo "  /opsx-propose \"your change\""
  echo "  /opsx-apply"
fi
echo "  sf org login web --alias dev --set-default"
echo "  sf org list"
echo "  sf project deploy start --source-dir force-app --target-org dev"
