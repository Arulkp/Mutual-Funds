var FundToken = artifacts.require('FundToken')
var DMF = artifacts.require('DMF')
var MarketToken1 = artifacts.require("MarketToken")
var MarketToken2 = artifacts.require("MarketToken")

/*
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
*/


module.exports = function(deployer) {
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
 };


// module.exports = function(deployer)
// {
//   deployer.deploy(FundToken)
//   deployer.deploy(MarketToken1,"DTX","AppleToken",0,100000000000000000)
//   console.log(deployer.deploy(MarketToken2,"ETX","GrapeToken",0,2000000000000000).address)
//   // return deployer.deploy(DMF,FundToken.address,MarketToken1.address,MarketToken2.address); 
    
  
// //   deployer.deploy(MarketToken2,"ETX","GrapeToken",0,2000000000000000).then(function()
// // {
// //   return deployer.deploy(DMF,FundToken.address,MarketToken1.address,MarketToken2.address)
// // })
  
// }
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
