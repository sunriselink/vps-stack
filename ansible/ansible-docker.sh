#!/usr/bin/env bash

set -e

base_image="alpine/ansible:2.21.0"
ssh_dir="$HOME/.ssh"

if [[ ! -d "$ssh_dir" ]]; then
    echo "ERROR: Directory $ssh_dir does not exist"
    exit 1
fi

docker run -it --rm \
    --network host \
    --volume $(dirname $0)/:/apps:ro \
    --volume $ssh_dir:/root/.ssh:ro \
    --workdir /apps \
    $base_image "$@"
