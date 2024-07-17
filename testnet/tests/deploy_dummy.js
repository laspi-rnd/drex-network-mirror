var DummyContract = artifacts.require("./DummyContract.sol");

module.exports = function(deployer) {
  deployer.deploy(DummyContract, "900000000000000000", {gas: 5000000});
};
