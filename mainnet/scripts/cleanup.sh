#! /bin/bash

docker compose -f network/docker-compose-mainnet.yaml down 
docker compose -f network/starfish.yaml down

ff stop starfish-firefly

if [[ $1 ]]; then
    echo "Cleaning up data"
    for i in {1..8}; do
    rm -rf network/nodes/node$i/data
    done

    ff rm starfish-firefly
fi