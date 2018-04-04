var FundToken = artifacts.require('FundToken')
var DMF = artifacts.require('DMF')
var MarketToken1 = artifacts.require("Mam1")
var MarketToken2 = artifacts.require("Man2")


module.exports= function(deployer)
{
  deployer.deploy(FundToken);
  deployer.deploy(MarketToken1)
  deployer.deploy(MarketToken2).then(function()
{
  return deployer.deploy(DMF,FundToken.address,MarketToken1.address,MarketToken2.address);
})
}
/*
module.exports = function(deployer) {vbn
  deployer.deploy(FundToken).then(function(){
    return FundToken.deployed();
  }).then(function(i) {
    fun_tok = i;
    deployer.deploy(MarketToken1,"DTX","AppleToken",0,100000000000000000).then(function(){
      return MarketToken1.deployed();
    }).then(function(M1){
      deployer.deploy(MarketToken2,"DTX","AppleToken",0,300000000000000000).then(function(){
        return MarketToken2.deployed();
      }).then(function(M2){
        deployer.deploy(DMF,i.address,M1.address,M2.address);
      });
    });
  });
 };*/