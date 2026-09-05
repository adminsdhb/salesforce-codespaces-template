#!/usr/bin/env bash

set -euo pipefail

if ! command -v sf >/dev/null 2>&1; then
  echo "Salesforce CLI is not installed. Reopen this repository in its Codespace."
  exit 1
fi

echo "Salesforce CLI:"
sf --version
echo
echo "Next steps:"
echo "  sf org login web --alias dev --set-default"
echo "  sf org list"
echo "  sf project deploy start --source-dir force-app --target-org dev"
