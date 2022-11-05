#!/usr/bin/env sh

for script in scripts/[0-9][0-9]_*.sh; do
  $script
done