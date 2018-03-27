var Markettoken = artifacts.require("Markettoken");

module.exports = function(deployer) {
    deployer.deploy(Markettoken,"BALA","DTX",18);
    
    };
  