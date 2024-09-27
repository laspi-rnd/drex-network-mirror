#! /bin/bash

while getopts 'a:h' opt; do
  case "$opt" in
    a)
      echo "Setting up alien network"
      cd aliennet
      source scripts/setup_alien.sh
      cd ..
      ;;
   
    ?|h)
      echo "Usage: $(basename $0) [-a]"
      exit 1
      ;;
  esac
done

echo "Setting up main network"
cd mainnet
source scripts/setup_main.sh
cd ..

echo "Running Prometheus and Grafana"
docker compose -f logs/docker-compose-dashboard.yaml up -d