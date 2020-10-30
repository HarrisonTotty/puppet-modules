#!/usr/bin/env bash
# A handy script for carving through firewall logs while avoiding most
# false-positives.

set -e

if [ "$#" -ne 1 ]; then
  echo 'USAGE: fwlog <chain>'
  echo 'EXAMPLE: fwlog OUTPUT'
  exit 0
fi

chain="$1"

if [ "$chain" == "INPUT" ]; then
  exclude_chain='OUTPUT'
elif [ "$chain" == "OUTPUT" ]; then
  exclude_chain='INPUT'
else
  echo 'Error: Invalid chain specified.'
  exit 1
fi

exclude_ports=$(iptables -nL $exclude_chain | grep -oP 'multiport dports [\d,]+' | cut -d ' ' -f 3 | tr ',' '\n' | sort -u | xargs)

journalctl -k -g "FIREWALL:${chain}" --follow --no-tail | grep -vP "SPT=$(echo -n $exclude_ports | tr ' ' '\|')"
