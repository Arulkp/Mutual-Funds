var FundToken = artifacts.require('FundToken')
var DMF = artifacts.require('DMF')

//Problem is resolved The DMF is perfectly deployed ....
module.exports = function (deployer) {
  deployer.deploy(FundToken).then(function () {
    return deployer.deploy(DMF, FundToken.address)
  })
}


