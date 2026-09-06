#!/usr/bin/env bash

set -euo pipefail

chmod +x scripts/*.sh
sf --version
openspec --version
bash scripts/validate.sh

echo "Salesforce Codespaces template is ready."
