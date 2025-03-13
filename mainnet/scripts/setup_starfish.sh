echo "Setting up Firefly Layer"
ff init starfish-firefly 3 -p 8000 -v -n remote-rpc --chain-id 381660001 --remote-node-url http://84.247.184.185:8253 --remote-node-deploy --connector-config starfish/listrack/evmconnect.yaml
ff start starfish-firefly

cd starfish/data_connectors/evm
docker build -t starfish-evm-connector .
cd ../../listrack

npx hardhat compile

cd ../middleware
docker build -t starfish-middleware .
cd ../../

sleep 10
docker compose -f network/starfish.yaml up -d
