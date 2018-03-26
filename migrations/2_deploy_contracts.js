var ConvertLib = artifacts.require("MutualFund");


module.exports = function(deployer) {
  deployer.deploy(ConvertLib,"BALA","DTX",18,1000);
  
  };
