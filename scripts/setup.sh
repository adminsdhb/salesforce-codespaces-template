#!/usr/bin/env bash

set -euo pipefail

if ! command -v sf >/dev/null 2>&1; then
  echo "Salesforce CLI is not installed. Reopen this repository in its Codespace."
  exit 1
fi

if ! command -v openspec >/dev/null 2>&1; then
  echo "OpenSpec is not installed. Rebuild or reopen this repository in its Codespace."
  exit 1
fi

echo "Salesforce CLI:"
sf --version
echo
echo "OpenSpec:"
openspec --version
echo
echo "Next steps:"
echo "  /opsx-explore"
echo "  /opsx-propose \"your change\""
echo "  /opsx-apply"
echo "  sf org login web --alias dev --set-default"
echo "  sf org list"
echo "  sf project deploy start --source-dir force-app --target-org dev"
