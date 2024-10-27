const Web3 = require("web3").default;
const fs = require("fs");

// Conexão com a rede blockchain (substitua o URL pelo endereço da sua rede)
const web3 = new Web3("http://localhost:8257"); // Participant url

// Configuração do endereço do contrato e da conta de administrador (substitua conforme necessário)
// admin account can be the either the defined one or yours node address
const adminAddress = "0x627306090abaB3A6e1400e9345bC60c78a8BEf57"; // endereço da conta com privilégios administrativos
const adminPrivateKey = "0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3"; // chave privada da conta admin

async function createAndRegisterAccounts(numAccounts) {
  const accounts = [];

  for (let i = 0; i < numAccounts; i++) {
    const account = web3.eth.accounts.create(); // Cria uma nova conta
    accounts.push(account);

    // Aqui você pode precisar de uma transação para registrar o endereço na sua rede
    const tx = {
        from: adminAddress,
        to: account.address,
        gas: 21320,
        maxPriorityFeePerGas: web3.utils.toWei("2", "gwei"),
        maxFeePerGas: web3.utils.toWei("100", "gwei"),
        data: "0x" + account.address.slice(2),
        type: 2, // Define tipo da transação para EIP-1559
    };
      

    // Assine e envie a transação usando a chave privada de admin
    //const signedTx = await web3.eth.accounts.signTransaction(tx, adminPrivateKey);
    //await web3.eth.sendSignedTransaction(signedTx.rawTransaction);

    console.log(`Conta ${i + 1}: ${account.address}`);
  }

  // Opcional: salvar as contas em um arquivo
  fs.writeFileSync("accounts.json", JSON.stringify(accounts, null, 2));
  console.log(`${numAccounts} contas criadas e salvas em accounts.json.`);
}

createAndRegisterAccounts(1); // Ajuste o número conforme necessário
