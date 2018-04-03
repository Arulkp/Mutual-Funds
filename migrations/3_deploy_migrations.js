'use strict'
var MarketToken = artifacts.require("MarketToken");

module.exports = function dead(deployer) {
  
    deployer.deploy(MarketToken,"DTX","AppleToken",0,100000000000000000);
    deployer.deploy(MarketToken,"ETX","GrapeToken",0,200000000000000);
   
  };

