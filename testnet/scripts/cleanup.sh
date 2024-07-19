#! /bin/bash

echo "Dropping Test Network Nodes..."
sudo docker compose -f docker/docker-compose-nodes.yaml down
sudo docker compose -f docker/docker-compose-bootnode.yaml down

echo "Removing Nodes Data Directories..."
rm -rf node/ genesis _tmp

echo "Removing Solidity Compiler Cache..."
rm -rf cache artifacts
