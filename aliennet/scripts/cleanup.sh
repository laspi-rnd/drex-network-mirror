#! /bin/bash

echo "Dropping Main Network Nodes..."
docker compose -f docker/docker-compose-nodes.yaml down --remove-orphans
docker compose -f docker/docker-compose-bootnode.yaml down --remove-orphans

echo "Dropping Alien Network Clients..."
docker compose -f docker/docker-compose-clientnodes.yaml down --remove-orphans

echo "Removing Nodes Data Directories..."
rm -rf node/ genesis _tmp

echo "Removing Solidity Compiler Cache..."
rm -rf cache artifacts
