var BusinessLogic = artifacts.require("BusinessLogic");

module.exports = function(deployer) {
    deployer.deploy(BusinessLogic);
    
    };