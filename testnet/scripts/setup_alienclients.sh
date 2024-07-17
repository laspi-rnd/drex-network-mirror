#! /bin/bash

max_retries=30  # Maximum number of retries
retry_delay=1  # Delay in seconds between retries
retry_count=0  # Initialize the retry count

while [ $retry_count -lt $max_retries ]; do
  export ENODE=$(curl -X POST --data '{"jsonrpc":"2.0","method":"net_enode","params":[],"id":1}' http://127.0.0.1:8549 | jq -r '.result')

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
export DOCKER_NODE_1_ADDRESS=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' alien-node-0)
export E_ADDRESS=$(echo $E_ADDRESS | sed -e "s/127.0.0.1/$DOCKER_NODE_1_ADDRESS/g")
echo $E_ADDRESS

sed "s/<ENODE>/enode:\/\/$E_ADDRESS/g" docker/templates/docker-compose-clientnodes.yaml > docker/docker-compose-clientnodes.yaml
echo "Starting nodes"
docker-compose -f docker/docker-compose-clientnodes.yaml up -d