const { ethers } = require("ethers");
const AccountRulesContract = require('../permissioning-smart-contracts/src/chain/abis/AccountRules.json'); // the ABI of the AccountRules contract

const providerUrl = "http://localhost:8253"; // any node RPC endpoint
const privateKey = "0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3"; // an admin account private key
const AccountRulesContractAddress = "0x09a9f29b4bF233aD82bD0D9075dB3ce88686A851"; // deployed address of the AccountRules contract

const provider = new ethers.JsonRpcProvider(providerUrl);
const adminWallet = new ethers.Wallet(privateKey, provider);
const AccountRules = new ethers.Contract(AccountRulesContractAddress, AccountRulesContract.abi, adminWallet);

async function CreateNewAccounts(numAccounts) {
    try {
        const accounts = [];

        for (let i = 0; i < numAccounts; i++) {
            const newWallet = ethers.Wallet.createRandom(provider); // create a new random wallet
            accounts.push(newWallet);
        }

        for (let i = 0; i < accounts.length; i++) {
            const tx = await AccountRules.addAccount( 
                accounts[i].address,
            ); // send the transaction to the contract to add the account

            const receipt = await tx.wait(); // await the transaction receipt
            console.log("Account", accounts[i].address, " added to the list of accounts");
            console.log(accounts[i].privateKey)
            // you SHOULD save the privatekey and address into a file
        }

    } catch (error) {
        console.error("Error handling the contracts:", error);
    }
}

CreateNewAccounts(10);
