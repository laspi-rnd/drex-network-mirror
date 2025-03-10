echo "Setting up Firefly Layer"
ff init starfish-firefly 3 -p 8000 -v -n besu -c ethconnect --chain-id 381660001 --remote-node-url http://172.16.238.2:8545 --remote-node-deploy --connector-config network/ethconnect
ff start starfish-firefly

cd starfish/data_connectors/evm
docker build -t starfish-evm-connector .
cd ../../listrack

npx hardhat compile

cd ../middleware
docker build -t starfish-middleware .
cd ../../