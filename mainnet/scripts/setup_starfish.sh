echo "Setting up Firefly Layer"
ff init firefly 3 -p 8000 -v -n besu --chain-id 381660001 --remote-node-url http://172.16.238.2:8545 --remote-node-deploy --connector-config starfish/listrack/evmconnect.yaml
ff start firefly

cd starfish/data_connectors/evm
docker build -t starfish-evm-connector .
cd ../../listrack

npx hardhat compile
docker build -t starfish-middleware .
cd ../../