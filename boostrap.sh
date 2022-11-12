#!/usr/bin/env sh

CURRENT_DIR="$(pwd)"
cd $(dirname "${0}")
for script in scripts/[0-9][0-9]_*.sh; do
  $script
done

cd "${CURRENT_DIR}"
