#!/usr/bin/env bash

set -euo pipefail

chmod +x scripts/*.sh
sf --version
if command -v openspec >/dev/null 2>&1; then
  openspec --version
else
  echo "OpenSpec is not installed on PATH; continuing to repository validation."
fi
bash scripts/validate.sh

echo "Salesforce Codespaces template is ready."
