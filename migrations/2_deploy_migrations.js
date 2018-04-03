var FundToken = artifacts.require('FundToken')
var DMF = artifacts.require('DMF')
var MarketToken = artifacts.require("MarketToken")

//Problem is resolved The DMF is perfectly deployed ....
module.exports = function (deployer) {
  deployer.deploy(FundToken).then(function () {
    return deployer.deploy(MarketToken,"DTX","AppleToken",0,100000000000000000).then(function()
  {
    return deployer.deploy(MarketToken,"ETX","GrapeToken",0,2000000000000000).then(function()
  {
    return deployer.deploy(DMF,FundToken.address,MarketToken.address,MarketToken.address)
  })
  })
  })
}

/*
module.exports = function(deployer)
{
  deployer.deploy(FundToken).then(function (){
      return FundToken.deployed();
  }).then(function(i)
{
  deployer.deploy(MarketToken,"DTX","AppleToken",0,100000000000000000).then(function()
  {
    return MarketToken.deployed();
  }).then(function(j)
  {
    deployer.deploy(MarketToken,"ETX","GrapeToken",0,2000000000000000).then(function()
    {
      return MarketToken.deployed();
    }).then(function(k)
  {
    return deployer.deploy(DMF,i.address,j.address,k.address)
  })
  })
})
  
}
*/
