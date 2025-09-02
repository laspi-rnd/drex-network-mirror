#! /bin/bash

echo "Setting up main network"
cd mainnet
source scripts/setup_main.sh
cd ..

while getopts 'alh' opt; do
  case "$opt" in
    a)
      echo "Setting up alien network"
      cd aliennet
      source scripts/setup_alien.sh
      cd ..
      ;;
    
    l)
      echo "Running Prometheus and Grafana"
      docker compose -f logs/docker-compose-dashboard.yaml up -d
      ;;
   
    ?|h)
      echo "Usage: $(basename $0) [-als]"
      exit 1
      ;;
  esac
done
