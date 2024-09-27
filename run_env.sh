#! /bin/bash

while getopts 'amlh' opt; do
  case "$opt" in
    a)
      echo "Setting up alien network"
      cd aliennet
      source scripts/setup_alien.sh
      cd ..
      ;;

    m)
      echo "Setting up main network"
      cd mainnet
      source scripts/setup_main.sh
      cd ..
      ;;
    
    l)
      echo "Running Prometheus and Grafana"
      docker compose -f logs/docker-compose-dashboard.yaml up -d
      ;;
   
    ?|h)
      echo "Usage: $(basename $0) [-a]"
      exit 1
      ;;
  esac
done