#!/usr/bin/env sh

set -e

export $(grep -v '^#' .env | xargs)

if [ -z "${API_PORT}" ]; then
    echo "API_PORT is empty"
    exit 1
fi

output=$(curl -s http://localhost:${API_PORT}/v1/users)

if [ "$1" = "full" ]; then
    echo "$output" | jq
else
    echo "$output" | jq -r '
        .data[] |
        .username as $u |
        (.links.tls[0] // "N/A") as $l |
        (.total_octets / 1048576) as $mb |
        "[\($u)]\ntls: \($l)\ntotal: \($mb | floor | tostring) MB\n"
    '
fi
