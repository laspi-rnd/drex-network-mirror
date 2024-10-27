const { ethers } = require("ethers");
const NodeRulesContract = require('../permissioning-smart-contracts/src/chain/abis/NodeRules.json');
const url = require('url');

// Configurações
const providerUrl = "http://localhost:8253"; // Exemplo: 'https://rpc.suaRede.org'
const privateKey = "0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3";
const NodeRulesContractAddress = "0x6a9643A0f0D923A53986D757D1DD324AE65BBF19"; // endereço do contrato de Rules

const enode = "enode://4acddb066be73afd694ffc6fb8bff78e2a561293d03c064ddae189b1ea1b209813b1fcf386249fd3907c4342634f7f50705d2c7c8f70d10aaa9426385108f151@172.16.238.16:30303";

// Inicialização
const provider = new ethers.JsonRpcProvider(providerUrl);
const wallet = new ethers.Wallet(privateKey, provider);
const NodeRules = new ethers.Contract(NodeRulesContractAddress, NodeRulesContract.abi, wallet);

// Chamar a Função
async function AdicionarNovoNo() {
    let enodeId, host, port;
    try {
        const node = new URL(enode);
        if (node.protocol === 'enode:') {
            if (node.username.length === 128) {
                enodeId = node.username;
            }

            host = node.hostname
            port = node.port;
        }

        const tx = await NodeRules.connectionAllowed(
            enodeId,
            host,
            parseInt(port)
        );
        //const receipt = await tx.wait(); // Aguardar a confirmação da transação
        console.log("Transação confirmada:", tx);
    } catch (error) {
        console.error("Erro ao interagir com o contrato:", error);
    }
}

AdicionarNovoNo();
