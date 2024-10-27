#! /bin/bash

cd mainnet 
source scripts/cleanup.sh $1

cd ../aliennet
source scripts/cleanup.sh

cd ..

echo "Stopping Prometheus and Grafana"
docker compose -f logs/docker-compose-dashboard.yaml down