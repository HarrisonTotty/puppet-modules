#!/usr/bin/env bash
set -e

echo "base_hostname=$(hostname -s | sed 's/[0-9]\+$//')"
