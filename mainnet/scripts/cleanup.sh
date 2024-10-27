#! /bin/bash

docker compose -f network/docker-compose-mainnet.yaml down 

#echo "Cleaning up data"
#for i in {1..8}; do
#  rm -rf network/nodes/node$i/data/*
#done