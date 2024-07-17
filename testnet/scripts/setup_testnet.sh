#! /bin/bash

mkdir -p node/besu-0/data
mkdir -p node/besu-1/data
mkdir -p node/besu-2/data
mkdir -p node/besu-3/data

mkdir -p node/alien-0
mkdir -p node/alien-1

mkdir _tmp && cd _tmp
besu operator generate-blockchain-config --config-file=../config/qbftConfigFile.json --to=networkFiles --private-key-file-name=key

cd ..   

counter=0
for folder in _tmp/networkFiles/keys/*; do
  folderName=$(basename "$folder")
  cp _tmp/networkFiles/keys/$folderName/key node/besu-$counter/data/key
  cp _tmp/networkFiles/keys/$folderName/key.pub node/besu-$counter/data/key,pub
  ((counter++))
done

mkdir genesis && cp _tmp/networkFiles/genesis.json genesis/genesis.json

rm -rf _tmp

if ! docker network ls | grep -q test_network; then
  docker network create test_network
fi

echo "Starting bootnode"
docker-compose -f docker/docker-compose-bootnode.yaml up -d

max_retries=30  # Maximum number of retries
retry_delay=1  # Delay in seconds between retries
retry_count=0  # Initialize the retry count

while [ $retry_count -lt $max_retries ]; do
  export ENODE=$(curl -X POST --data '{"jsonrpc":"2.0","method":"net_enode","params":[],"id":1}' http://127.0.0.1:8545 | jq -r '.result')

  if [ -n "$ENODE" ]; then
    # check if the enode is not null
    if [ "$ENODE" != "null" ]; then
      echo "ENODE retrieved successfully."
      break  # Exit the loop if successful
    fi
  else
    echo "Failed to retrieve ENODE. Retrying in $retry_delay seconds..."
    sleep $retry_delay
    ((retry_count++))
  fi
done

if [ $retry_count -eq $max_retries ]; then
  echo "Max retries reached. Unable to retrieve ENODE."
fi

echo "ENODE: $ENODE"

export E_ADDRESS="${ENODE#enode://}"
export DOCKER_NODE_1_ADDRESS=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' test-node-0)
export E_ADDRESS=$(echo $E_ADDRESS | sed -e "s/127.0.0.1/$DOCKER_NODE_1_ADDRESS/g")
echo $E_ADDRESS

sed "s/<ENODE>/enode:\/\/$E_ADDRESS/g" docker/templates/docker-compose-nodes.yaml > docker/docker-compose-nodes.yaml
echo "Starting nodes"
docker-compose -f docker/docker-compose-nodes.yaml up -d