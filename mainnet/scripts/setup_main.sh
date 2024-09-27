#! /bin/bash

echo "Cleaning up previous data"
for i in {1..8}; do
  rm -rf network/nodes/node$i/data/*
  cp network/nodes/node$i/keys/key network/nodes/node$i/data/key
done

echo "Creating segregated networks"
if ! docker network ls | grep -q main_network; then
  docker network create --subnet=172.16.238.0/24 main_network
fi


docker compose -f network/docker-compose.yaml up -d --remove-orphans