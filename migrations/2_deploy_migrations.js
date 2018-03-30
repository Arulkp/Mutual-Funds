var  FundToken = artifacts.require("FundToken");
var DMF =  artifacts.require("DMF");
module.exports = function(deployer) {
  deployer.deploy(FundToken).then(function(){
    deployer.deploy(DMF,FundToken.address)});
};