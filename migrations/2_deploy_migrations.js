var FundToken = artifacts.require('FundToken')
var DMF = artifacts.require('DMF')
// var TokenManipulation=artifacts.require('Token')

module.exports= function(deployer)
{
  // deployer.deploy(TokenManipulation)
  deployer.deploy(FundToken).then(function()
{
  deployer.deploy(DMF,FundToken.address);
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