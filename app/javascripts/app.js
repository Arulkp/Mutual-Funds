// Import the page's CSS. Webpack will know what to do with it.
//import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import FundToken from '../../build/contracts/FundToken.json'
import DMF from '../../build/contracts/DMF.json'
import TokenManipulation from '../../build/contracts/Token.json'


//import dead from '../../migrations/3_deploy_migrations'


// MetaCoin is our usable abstraction, which we'll use through the code below.
var MetaCoin = contract(FundToken);
var MetaCoins = contract(DMF);
var token = contract(TokenManipulation);


// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;
var arr;

window.App = {
  start: function() {
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    MetaCoin.setProvider(web3.currentProvider);
    MetaCoins.setProvider(web3.currentProvider);
    token.setProvider(web3.currentProvider);
    // mtok.setProvider(web3.currentProvider);
    // mtok1.setProvider(web3.currentProvider);
   

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
      //self.AR();
     // self.mtad2();
     self.pmdetail();
     // self.Imdetail();
      //self.mtdetail();
     // self.mtdetail1();
      self.ethbb();
      self.ethbbb();
      self.total();
      self.pbal();
      self.pbal1();
      self.divCheck();
      self.ListInvester();
      self.ListPortfolio();
     // self.pads();
      
     // self.bal();
      //self.sendCoin();

    });
    
  },
  
  // tokval:function(){
  //   var self = this;

  //   var meta;
  //   MetaCoins.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.DisplayPurchasedTKCount({from:account,gas:250000});
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("5");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtname1:function(){
  //   var self = this;

  //   var meta;
  //   mtok.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.name();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("name");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //    // console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtsymb1:function(){
  //   var self = this;

  //   var meta;
  //   mtok.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.symbol();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("sym");
  //     var balance_element1 = document.getElementById("tor");
  //     balance_element.value = value;
  //     balance_element1.value = 0.1;

  //   }).catch(function(e) {
  //    // console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtdec1:function(){
  //   var self = this;

  //   var meta;
  //   mtok.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.decimals();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("dec");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtsub1:function(){
  //   var self = this;

  //   var meta;
  //   mtok.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.totalSupply();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("tos");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtad1:function(){
  //   var self = this;

  //   var meta;
  //   mtok.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.DisplayTheAddress();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("tad");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtad2:function(){
  //   var self = this;

  //   var meta;
  //   mtok1.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.DisplayTheAddress();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("tad1");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtname2:function(){
  //   var self = this;

  //   var meta;
  //   mtok1.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.name();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("name1");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtsymb2:function(){
  //   var self = this;

  //   var meta;
  //   mtok1.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.symbol();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("sym1");
  //     var balance_element1 = document.getElementById("tor1");
  //     balance_element.value = value;
  //     balance_element1.value =0.1;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtdec2:function(){
  //   var self = this;

  //   var meta;
  //   mtok1.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.decimals();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("dec1");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtsub2:function(){
  //   var self = this;

  //   var meta;
  //   mtok1.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.totalSupply();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("tos1");
  //     balance_element.value = value;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // AR:function(){
  //   var self = this;

  //   var meta;
  //   mtok1.deployed().then(function(instance) {
  //     meta = instance;
      
  //     return meta.DisplayTheAddress();
  //   }).then(function(value) {
  //     var balance_element = document.getElementById("tad1");
  //     balance_element.value = value;
  //   }).catch(function(e) {
      
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  pmdetail: function() {
    var j=1;
    var myarray=[];
  var self = this;
  var meta;
  MetaCoins.deployed().then(function(instance) {
    meta = instance;
    meta.values().then(function(res,err){
      for (var i=0;i<res[0].toNumber();i++){
        meta.ToatlportfolioMAddress(i).then(function(re,er){
          myarray=re;
          meta.getBalance(re).then(function(ree,errr){
              meta.Portfolio(re).then(function(fi,ers){
                $("#Ptable").append('<tr><td>'+ j++ +'</td><td>'+re+'</td><td>'+fi[0]+'</td><td>'+ree+'</td></tr>')
              });
        });
      });
      }
    });
  });
  
  },

  // Imdetail: function() {
  //   var j=1;
  //   var myarray=[];
  // var self = this;
  // var meta;
  // MetaCoins.deployed().then(function(instance) {
  //   meta = instance;
  //   meta.Icount().then(function(res,err){
  //     for (var i=0;i<res.toNumber();i++){
  //       meta.getInvesterAddress(i,i).then(function(re,er){
  //             meta.invester(re[0],re[1]).then(function(fi,ers){
  //               $("#Itable").append('<tr><td>'+j++ +'</td><td>'+fi[0]+'</td><td>'+fi[1]+'</td></tr>')
              
  //             });
          
  //       });
  //     }
  //   });
  // });
  
  // },
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
     document.getElementById("name111").value=amount;
     var res=document.getElementById("name112");
     res.value=result;
      //self.refreshBalance();
    }).catch(function(e) {
     // console.log(e);
      //self.setStatus("Error sending coin; see log.");
    });
  },


  pbal1: function() {
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
     document.getElementById("name11").value=amount;
     var res=document.getElementById("name12");
     res.value=result;
      //self.refreshBalance();
    }).catch(function(e) {
     // console.log(e);
      //self.setStatus("Error sending coin; see log.");
    });
  },


  divCheck:function() {
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.values({from:account});
    }).then(function(value) {
      arr=value[1];
      self.refreshBalance();
    }).catch(function(e) {
     // console.log(e);
  
      //self.setStatus("Error getting balance; see log.");
    });
  },

 div:function() {
  var self = this;
  var meta;
  if(arr != 0){
  MetaCoins.deployed().then(function(instance) {
    meta = instance;
    return meta.Dividends({from:account});
  }).then(function(value) {
    alert("Successful");
    self.refreshBalance();
  }).catch(function(e) {
   // console.log(e);

    //self.setStatus("Error getting balance; see log.");
  });
}
else{
  alert("No Investor");
}
},
 
  
  cadd:function() {
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.newadd();
    }).then(function(value) {
      var balance_element = document.getElementById("cad");
      balance_element.value = value;
    }).catch(function(e) {
      //console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  },
  cadds:function() {
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.getContractaddress();
    }).then(function(value) {
      var balance_element = document.getElementById("1");
      balance_element.value = value;
    }).catch(function(e) {
     // console.log(e);
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
     // console.log(e);
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
      //console.log(e);
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
      balance_element.value= value;
    }).catch(function(e) {
      //console.log(e);
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
     // console.log(e);
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
     // console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  }, 
  

  ethbb:function(){
    var self = this;

    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.takecommission();
    }).then(function(value) {
      var balance_element = document.getElementById("ebb");
      balance_element.value = value;
    }).catch(function(e) {
     // console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  }, 

  ethbbb:function(){
    var self = this;
    var account=web3.eth.accounts;
    var meta;
    MetaCoins.deployed().then(function(instance) 
    {
      meta = instance;
      return meta.Portfolio(web3.eth.accounts);
    }).then(function(value) {
      document.getElementById("name2").value=account;
      var balance_element = document.getElementById("name3");
      balance_element.value = value[5];
    }).catch(function(e) {
     // console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  }, 


  purchase1:function(){
    var self = this;
    var address = document.getElementById("a111").value;
    var amount = document.getElementById("a222").value;
    var meta;
    MetaCoins.deployed().then(function(instance) 
    {
      meta = instance;
      return meta.purchaseToken(address,amount,{from: account});
    }).then(function(value) {
    }).catch(function(e) {
     // console.log(e);
      //self.setStatus("Error getting balance; see log.");
    });
  }, 
 

// list of investers for portfolio

  ListInvester: function() {
    var j=1;
  var self = this;
  var meta;
  MetaCoins.deployed().then(function(instance) {
    meta = instance;
  
      meta.portfoliocount(web3.eth.accounts).then(function(ress,errr){

            for (var i=0;i<ress;i++){
              meta.PortfolioList(web3.eth.accounts,i).then(function(res1,err1){
              meta.invester(web3.eth.accounts,res1).then(function(reee,errr){
                $("#Ptable1").append('<tr><td>'+ j++ +'</td><td>'+ res1 +'</td><td>'+reee[0]+'</td><td>'+reee[1]+'</td><td>'+'<html> <button type="button" class="btn btn-info " id="1" data-toggle="modal" data-target="#myModal" onclick="purchase1()">SELL</button></html>'+'</td></tr>')
      });
    });
           }
    });
  });

  },



  ListPortfolio: function() {
  var j=1;
  var self = this;
  var meta;
  MetaCoins.deployed().then(function(instance) {
    meta = instance;
   
      meta.Investercount(web3.eth.accounts).then(function(ress,errr){

            for (var i=0;i<ress;i++){
              meta.InvesterList(web3.eth.accounts,i).then(function(re,er){
              meta.invester(re,web3.eth.accounts).then(function(reee,errr){
                $("#Ptable10").append('<tr><td>'+ j++ +'</td><td>'+ re +'</td><td>'+reee[0]+'</td><td>'+reee[1]+'</td></tr>')
      });
    });
           }
    });
  
})
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
     // console.log(e);
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
     // console.log(e);
      //self.setStatus("Error sending coin; see log.");
    });
  },
  purchase : function (){
    
    var x=document.getElementById("tad").value;
    var y=document.getElementById("name").value;
    var z=document.getElementById("sym").value;
    var a=parseInt(document.getElementById("id02").value);
    
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.PurchasingMarket1token(x,y,z,a, {from: account});
    }).then(function(result) {
      console.log(result);
      // self.setStatus("Transaction complete!");
      // self.refreshBalance();
    }).catch(function(e) {
    //  console.log(e);
      // self.setStatus("Error sending coin; see log.");
    });
  },
  purchases : function (){
   
    var x=document.getElementById("tad1").value;
    var y=document.getElementById("name1").value;
    var z=document.getElementById("sym1").value;
    var a=parseInt(document.getElementById("id2").value);
    
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.PurchasingMarket2token(x,y,z,a, {from: account});
    }).then(function(result) {
      console.log(result);
      // self.setStatus("Transaction complete!");
      // self.refreshBalance();
    }).catch(function(e) {
     // console.log(e);
      // self.setStatus("Error sending coin; see log.");
    });
  },
  // pdetail:function(){
  //   var self = this;

  //   var meta;
  //   MetaCoins.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.DisplayPurchasedTokendetails();
  //   }).then(function(value) {
  //     var balance_element1 = document.getElementById("4");
  //     var balance_element2= document.getElementById("1");
  //     var balance_element3= document.getElementById("3");
  //     var balance_element4= document.getElementById("5");
      
  //     balance_element1.value = value[0];
  //     balance_element2.value = value[1];
  //     balance_element3.value = value[2];
  //     balance_element4.value = value[3];
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
  // mtdetail:function(){
  //   var self = this;
  
  //   var meta;
  //   MetaCoins.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.DisplayPurchasedTK1({from:account});
  //   }).then(function(value) {
  //     var balance_element1 = document.getElementById("tads");
  //     var balance_element2= document.getElementById("tns");
  //     var balance_element3= document.getElementById("tnsy");
  //     var balance_element4= document.getElementById("tnde");
  //     var balance_element5= document.getElementById("tat");
      
      
  //     balance_element1.value = value[0];
  //     balance_element2.value = value[1];
  //     balance_element3.value = value[2];
  //     balance_element4.value = value[3];
  //     balance_element5.value = value[4];
  //     balance_element5.value = 0.1;
  //   }).catch(function(e) {
  //     //console.log(e);
  //     //self.setStatus("Error getting balance; see log.");
  //   });
  // },
// mtdetail1:function(){
//   var self = this;

//   var meta;
//   MetaCoins.deployed().then(function(instance) {
//     meta = instance;
//     return meta.DisplayPurchasedTK2({from:account});
//   }).then(function(value) {
//     var balance_element1 = document.getElementById("tads1");
//     var balance_element2= document.getElementById("tns1");
//     var balance_element3= document.getElementById("tnsy1");
//     var balance_element4= document.getElementById("tnde1");
//     var balance_element5= document.getElementById("tat1");
    
    
//     balance_element1.value = value[0];
//     balance_element2.value = value[1];
//     balance_element3.value = value[2];
//     balance_element4.value = value[3];
//     balance_element5.value = value[4];
  
//   }).catch(function(e) {
//     //console.log(e);
//     //self.setStatus("Error getting balance; see log.");
//   });
// },

 
total: function (){

  var self = this;
  var meta;
  MetaCoins.deployed().then(function(instance) {
    meta = instance;
    return meta.ToatlportfolioMAddress({from: account});
  }).then(function(result) {
    console.log(result);
    arr=result;
    // self.setStatus("Transaction complete!");
    // self.refreshBalance();
  }).catch(function(e) {
   // console.log(e);
    // self.setStatus("Error sending coin; see log.");
  });
},


invest : function (){
  var reg_e = parseInt(document.getElementById("a12").value);
  var show =document.getElementById("a11").value;
  var self = this;
  var meta;
  MetaCoins.deployed().then(function(instance) {
    meta = instance;
    return meta.InvesterGetToken(show,{from: account,value:web3.toWei(reg_e,'ether')});
  }).then(function(result) {
    console.log(result);
    // self.setStatus("Transaction complete!");
    // self.refreshBalance();
  }).catch(function(e) {
   // console.log(e);
    // self.setStatus("Error sending coin; see log.");
  });
},
  

  register : function (){
    var reg_e = parseInt(document.getElementById("a1").value);

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
     // console.log(e);
      // self.setStatus("Error sending coin; see log.");
    });
  },



  SEL: function (){
    var reg_s = $("#name2").val();
    var reg = $("#name3").val();
    var self = this;
    var meta;
    MetaCoins.deployed().then(function(instance) {
      meta = instance;
      return meta.ReturnTokenToPortfolioManager(reg_s,reg,{from: account});
    }).then(function(result) {
      console.log(result);
      // self.setStatus("Transaction complete!");
      // self.refreshBalance();
    }).catch(function(e) {
      //console.log(e);
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
      //console.log(e);
      //self.setStatus("Error sending coin; see log.");
    });
  },
 
  
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