'use strict'
var MarketToken = artifacts.require("MarketToken");

module.exports = function dead(deployer) {
  
    deployer.deploy(MarketToken,"DTX","AppleToken",0,100000000000000000);
    deployer.deploy(MarketToken,"ETX","GrapeToken",0,2000000000000000);
    deployer.deploy(MarketToken,"FTX","OrangeToken",0,10000000000000000);
    deployer.deploy(MarketToken,"GTX","MinimusToken",0,300000000000000000);
    deployer.deploy(MarketToken,"HTX","TetrixToken",0,1000000000000000);
    deployer.deploy(MarketToken,"ITX","JelatrixToken",0,500000000000000000);
    deployer.deploy(MarketToken,"JTX","PentrixToken",0,1000000000000000000);
    deployer.deploy(MarketToken,"KTX","MedrixToken",0,800000000000000000);
    deployer.deploy(MarketToken,"LTX","MNWToken",0,400000000000000000);
    deployer.deploy(MarketToken,"MTX","MeridiusToken",0,90000000000000000);
    deployer.deploy(MarketToken,"NTX","MaximusToken",0,200000000000000000);
    deployer.deploy(MarketToken,"OTX","VivoToken",0,60000000000000000);
    deployer.deploy(MarketToken,"PTX","PheonixToken",0,5000000000000000);
    deployer.deploy(MarketToken,"QTX","CrystelToken",0,200000000000000000);
    deployer.deploy(MarketToken,"RTX","InfinityToken",0,70000000000000000);
    deployer.deploy(MarketToken,"STX","RaidusToken",0,5000000000000000);
    deployer.deploy(MarketToken,"TTX","TetrixToken",0,30000000000000000);
    deployer.deploy(MarketToken,"DTX","AppleToken",0,20000000000000000);
    deployer.deploy(MarketToken,"DTX","AppleToken",0,700000000000000000);
    deployer.deploy(MarketToken,"DTX","AppleToken",0,300000000000000000);
  };

