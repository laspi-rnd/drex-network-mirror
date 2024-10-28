const { ethers } = require("ethers");
const AdminContract = require('../permissioning-smart-contracts/src/chain/abis/Admin.json'); // the ABI of the Admin contract

const providerUrl = "http://localhost:8253"; // any node RPC endpoint
const privateKey = "0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3"; // an admin account private key
const AdminContractAddress = "0x5523c9DD22064014EA5742312b14Cb7d14394A96"; // deployed address of the Admin contract

const provider = new ethers.JsonRpcProvider(providerUrl);
const adminWallet = new ethers.Wallet(privateKey, provider);
const Admin = new ethers.Contract(AdminContractAddress, AdminContract.abi, adminWallet);

const address = "0x9D4b13ADE968d5AB69AbE247A62e0CA281AcDa0c"; // account address to be added to the list of admins

async function AddNewAdmin() {
    try {
        const tx = await Admin.addAdmin(
                address,
        ); // send the transaction to the contract to add the account as an admin

        const receipt = await tx.wait(); // await the transaction receipt
        console.log("Transaction confirmed:", tx);

    } catch (error) {
        console.error("Error handling the contracts:", error);
    }
}

AddNewAdmin();
