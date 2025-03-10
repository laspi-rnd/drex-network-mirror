#! /bin/bash

for i in {1..8}; do
  if [ ! -d "network/nodes/node$i/data" ]; then
    mkdir network/nodes/node$i/data
    cp network/nodes/node$i/keys/key network/nodes/node$i/data/key
  fi
done 

echo "Creating segregated networks"
if ! docker network ls | grep -q main_network; then
  docker network create --subnet=172.16.238.0/24 main_network
fi

docker compose -f network/docker-compose-mainnet.yaml up -d
sleep 15
source scripts/setup_starfish.sh
#docker compose -f network/starfish.yaml up -d