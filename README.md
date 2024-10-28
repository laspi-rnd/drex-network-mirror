## Test Environment

The test environment architecture is presented in Figure 1.

![Figure 1 - Test Environment Architecture](assets/network.png)

## Running the Test Environment

To run the test environment, follow these steps:

1. Clone the project repository:

```bash
git clone https://gitlab.laspi.ufrj.br/laspi-rnd/bacen-interoperabilidade/testenv.git
git submodule update --init --recursive
```

2. Initialize the test environment:

```bash
./run_env.sh
```

The `run_env.sh` script will create all the necessary containers for running the test environment. If this is the first run or after resetting the test environment, it's necessary to configure [permissioning in the test environment](#configuring-permissioning-in-the-test-environment).

It’s possible to specify which services will run in the test environment. To do so, pass -l (for Prometheus and Grafana) or -a (for Aliennet) to the `run_env` script.

```bash	
./run_env.sh -la
```

This will run instances of Prometheus, Grafana, and Aliennet along with the test network (mainnet).

## Stopping the Test Environment

To stop the test environment, run the following command:

```bash
./stop_env.sh
```

The `stop_env.sh` script will stop all containers created by the `run_env.sh` script. Temporary files can be removed, COMPLETELY DELETING ALL DATA from the previous network using the -r option.

```bash
./stop_env.sh -r
```

## Configuring Permissioning in the Test Environment
<a name="permissioning"></a>
This step should only be performed during the first execution of the test environment or after a reset. To configure permissioning in the test environment, run the following command:

```bash
cd permissioning-smart-contracts
npm install --force
npm install -g truffle
truffle migrate --reset --network besu
```

Save the permissioning contract deployment addresses, as they will be needed to modify the test network structure.

# Adding wallets, nodes, or administrators:

In the `examples` folder, there are examples of how to add wallets, nodes, or administrators.

# TO DO
   - Migrate from Truffle to Hardhat
   - RPC credentials