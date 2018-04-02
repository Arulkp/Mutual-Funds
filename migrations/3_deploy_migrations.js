'use strict'
var MarketToken = artifacts.require("MarketToken");

module.exports = function dead(deployer) {
  
    deployer.deploy(MarketToken,"DTX","AppleToken",18,100000000000000000);
    deployer.deploy(MarketToken,"ETX","GrapeToken",18,2000000000000000);
    deployer.deploy(MarketToken,"FTX","OrangeToken",18,10000000000000000);
    deployer.deploy(MarketToken,"GTX","MinimusToken",18,300000000000000000);
    deployer.deploy(MarketToken,"HTX","TetrixToken",18,1000000000000000);
    deployer.deploy(MarketToken,"ITX","JelatrixToken",18,500000000000000000);
    deployer.deploy(MarketToken,"JTX","PentrixToken",18,1000000000000000000);
    deployer.deploy(MarketToken,"KTX","MedrixToken",18,800000000000000000);
    deployer.deploy(MarketToken,"LTX","MNWToken",18,400000000000000000);
    deployer.deploy(MarketToken,"MTX","MeridiusToken",18,90000000000000000);
    deployer.deploy(MarketToken,"NTX","MaximusToken",18,200000000000000000);
    deployer.deploy(MarketToken,"OTX","VivoToken",18,60000000000000000);
    deployer.deploy(MarketToken,"PTX","PheonixToken",18,5000000000000000);
    deployer.deploy(MarketToken,"QTX","CrystelToken",18,200000000000000000);
    deployer.deploy(MarketToken,"RTX","InfinityToken",18,70000000000000000);
    deployer.deploy(MarketToken,"STX","RaidusToken",18,5000000000000000);
    deployer.deploy(MarketToken,"TTX","TetrixToken",18,30000000000000000);
  };

