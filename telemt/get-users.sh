#!/usr/bin/env sh

set -e

export $(grep -v '^#' .env | xargs)

if [ -z "${API_PORT}" ]; then
    echo "API_PORT is empty"
    exit 1
fi

curl -s http://localhost:${API_PORT}/v1/users | jq -r '.data[] | "\(.username): \(.links.tls[0])"'
