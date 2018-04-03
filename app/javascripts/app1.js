import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import MarketToken from '../../build/contracts/MarketToken.json'
var MetaCoins1 = contract(MarketToken);
var contractInstance = MetaCoins1.at('0x2c2b9c9a4a25e24b174f26114e8926a9f2128fe4');

var accounts;
var account;

window.App = {
  start: function() {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MarketToken.setProvider(web3.currentProvider);
    web3.eth.getAccounts(function(err, accs) {
        if (err != null) {
          alert("There was an error fetching your accounts.");
          return;
        }
  
        if (accs.length == 0) {
          alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
          return;
        }
  
        accounts = accs;
        account = accounts[0];
        self.tnam();
    });
    
},
tnam:function(){
    var self = this;

    var meta;
    contractInstance.deployed().then(function(instance) {
      meta = instance;
      return meta.name();
    }).then(function(value) {
      var balance_element = document.getElementById("name");
      balance_element.value = value;
    }).catch(function(e) {
        alert("hai");
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  }}
  window.addEventListener('load', function() {
    // Checking if Web3 has been injected by the browser (Mist/MetaMask)
    if (typeof web3 !== 'undefined') {
      console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
      // Use Mist/MetaMask's provider
      window.web3 = new Web3(web3.currentProvider);
    } else {
      console.warn("No web3 detected. Falling back to http://127.0.0.1:9545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
      // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
      window.web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:9545"));
    }
  
    App.start();
  });
  