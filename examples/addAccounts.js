const { ethers } = require("ethers");
const AccountRulesContract = require('../permissioning-smart-contracts/src/chain/abis/AccountRules.json');

// Configurações
const providerUrl = "http://localhost:8253"; // some node RPC url
const privateKey = "0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3";
const AccountRulesContractAddress = "0x09a9f29b4bF233aD82bD0D9075dB3ce88686A851"; // endereço do contrato de Rules

// Inicialização
const provider = new ethers.JsonRpcProvider(providerUrl);
const adminWallet = new ethers.Wallet(privateKey, provider);
const AccountRules = new ethers.Contract(AccountRulesContractAddress, AccountRulesContract.abi, adminWallet);

// Chamar a Função
async function AdicionarNovaCarteira(numAccounts) {
    try {
        const accounts = [];

        for (let i = 0; i < numAccounts; i++) {
            const newWallet = ethers.Wallet.createRandom(provider); // Cria uma nova conta
            accounts.push(newWallet);
        }

        for (let i = 0; i < accounts.length; i++) {
            const tx = await AccountRules.addAccount(
                accounts[i].address,
            );
            const receipt = await tx.wait(); // Aguardar a confirmação da transação
            console.log("Account", accounts[i].address, " added to the list of accounts");
            console.log(accounts[i].privateKey)
            // you SHOULD save the privatekey and address info in a file
        }

    } catch (error) {
        console.error("Erro ao interagir com o contrato:", error);
    }
}

AdicionarNovaCarteira(10);
