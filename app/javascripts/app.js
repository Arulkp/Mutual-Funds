// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import FundToken from '../../build/contracts/FundToken.json'
import DMF from '../../build/contracts/DMF.json'


//import dead from '../../migrations/3_deploy_migrations'


// MetaCoin is our usable abstraction, which we'll use through the code below.
var MetaCoin = contract(FundToken);
var MetaCoins = contract(DMF);



// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;

window.App = {
  start: function() {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MetaCoin.setProvider(web3.currentProvider);
    MetaCoins.setProvider(web3.currentProvider);
   

    // Get the initial account balance so it can be displayed.
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
      //
      self.cadd();
      self.tot();
      self.tnam();
      self.teth();
      self.tdec();
      self.ethb();
      self.pbal();
      self.tnam1();
      self.tdec1();
      self.trat();
      self.tadm();
      
   
     // self.pads();
      
     // self.bal();
      //self.sendCoin();

    });
    
  },
  tnam1:function(){
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.DisplayTotalsupMarkTK1();
    }).then(function(value) {
      var balance_element = document.getElementById("tos");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  tdec1:function(){
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.DisplayDecimalMarkTK1();
    }).then(function(value) {
      var balance_element = document.getElementById("dec");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  trat:function(){
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.DisplayRateMarkTK1();
    }).then(function(value) {
      var balance_element = document.getElementById("tor");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  tadm:function(){
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.DisplayAddressMarkTK1();
    }).then(function(value) {
      var balance_element = document.getElementById("tad");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  
  pbal: function() {
    var self = this;

   var amount = web3.eth.accounts;
 // var addres=document.getElementById("ads").value;
    //this.setStatus("Initiating transaction... (please wait)");

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.balanceOf(web3.eth.accounts, {from: account});
    }).then(function(result) {
     // self.setStatus("Transaction complete!");
     document.getElementById("ads").value=amount;
     var res=document.getElementById("at");
     res.value=result;
      //self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error sending coin; see log.");
    });
  },

 div:function() {
  var self = this;
  var meta;
  MetaCoins.deployed().then(function(instance) {
    meta = instance;
    return meta.Dividends({from:account});
  }).then(function(value) {
    var res = document.getElementById("div");
    //balance_element.value = value;
    res.value=result;
    self.refreshBalance();
  }).catch(function(e) {
    console.log(e);

    //self.setStatus("Error getting balance; see log.");
  });
},
 
  
  cadd:function() {
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.getContractaddress();
    }).then(function(value) {
      var balance_element = document.getElementById("cad");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },

  tot:function(){
    var self = this;

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.totalSupply();
    }).then(function(value) {
      var balance_element = document.getElementById("ts");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  tnam:function(){
    var self = this;

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.name();
    }).then(function(value) {
      var balance_element = document.getElementById("tn");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  teth:function(){
    var self = this;

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.symbol();
    }).then(function(value) {
      var balance_element = document.getElementById("tsy");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  tdec:function(){
    var self = this;

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.decimals();
    }).then(function(value) {
      var balance_element = document.getElementById("td");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  ethb:function(){
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.GetBal();
    }).then(function(value) {
      var balance_element = document.getElementById("eb");
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  

 


  sendCoin: function() {
    var self = this;

    var amount = parseInt(document.getElementById("reg").value);
  
    this.setStatus("Initiating transaction... (please wait)");

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.PortfolioReg( amount, {from: account});
    }).then(function() {
      self.setStatus("Transaction complete!");
      self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      self.setStatus("Error sending coin; see log.");
    });
  },
  Ibal: function() {
    var self = this;

   // var amount = web3.eth.accounts[0];
  var addres=document.getElementById("adr").value;
    //this.setStatus("Initiating transaction... (please wait)");

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.balanceOf(addres, {from: account});
    }).then(function(result) {
     // self.setStatus("Transaction complete!");
     var res=document.getElementById("str");
     res.value=result;
      self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error sending coin; see log.");
    });
  },
  purchase : function (){
    var b=parseInt(document.getElementById("id03").value);
    var x=document.getElementById("tad").value;
    var y=document.getElementById("name").value;
    var z=document.getElementById("sym").value;
    var a=parseInt(document.getElementById("id02").value);
    
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.Purchasingtoken(x,y,z,a, {from: account,value:web3.toWei(b,'ether')});
    }).then(function(result) {
      console.log(result);
      // self.setStatus("Transaction complete!");
      // self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      // self.setStatus("Error sending coin; see log.");
    });
  },
  pdetail:function(){
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.DisplayPurchasedTokendetails();
    }).then(function(value) {
      var balance_element = document.getElementById("4");
      var balance_element = document.getElementById("1");
      var balance_element = document.getElementById("3");
      var balance_element = document.getElementById("5");
      
      balance_element.value = value;
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },

  invest : function (){
    var reg_e = parseInt($("#id03").val());
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.InvesterGetToken({from: account,value:web3.toWei(reg_e,'ether')});
    }).then(function(result) {
      console.log(result);
      // self.setStatus("Transaction complete!");
      // self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      // self.setStatus("Error sending coin; see log.");
    });
  },
  SEL: function (){
    var reg_s = $("#id05").val();
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.ReturnTokenToPortfolioManager(reg_s, {from: account});
    }).then(function(result) {
      console.log(result);
      // self.setStatus("Transaction complete!");
      // self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      // self.setStatus("Error sending coin; see log.");
    });
  },


  bal: function() {
    var self = this;

   // var amount = web3.eth.accounts[0];
  var addres=document.getElementById("ads").value;
    //this.setStatus("Initiating transaction... (please wait)");

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.balanceOf( {from: account});
    }).then(function(result) {
     // self.setStatus("Transaction complete!");
     var res=document.getElementById("at");
     res.value=result;
      self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      //self.setStatus("Error sending coin; see log.");
    });
  },

  register : function (){
    var reg_e = parseInt($("#reg").val());
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.PortfolioReg({from: account,value:web3.toWei(reg_e,'ether')});
    }).then(function(result) {
      console.log(result);
      // self.setStatus("Transaction complete!");
      // self.refreshBalance();
    }).catch(function(e) {
      console.log(e);
      // self.setStatus("Error sending coin; see log.");
    });
  }
};



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
