const { ethers } = require("ethers");
const AdminContract = require('../permissioning-smart-contracts/src/chain/abis/Admin.json');

// Configurações
const providerUrl = "http://localhost:8253"; // some node RPC url
const privateKey = "0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3";
const AdminContractAddress = "0x5523c9DD22064014EA5742312b14Cb7d14394A96"; // endereço do contrato Admin

// Inicialização
const provider = new ethers.JsonRpcProvider(providerUrl);
const adminWallet = new ethers.Wallet(privateKey, provider);
const Admin = new ethers.Contract(AdminContractAddress, AdminContract.abi, adminWallet);

const address = "0x9D4b13ADE968d5AB69AbE247A62e0CA281AcDa0c";

// Chamar a Função
async function AdicionarNovaCarteira() {
    try {
        const tx = await Admin.addAdmin(
                address,
            );

        const receipt = await tx.wait(); // Aguardar a confirmação da transação
        console.log("Transação confirmada:", tx);

    } catch (error) {
        console.error("Erro ao interagir com o contrato:", error);
    }
}

AdicionarNovaCarteira(10);
