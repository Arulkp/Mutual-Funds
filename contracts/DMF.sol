pragma solidity ^0.4.18;

import "./MarketToken1.sol";
import "./FundToken.sol";
import "./MarketToken2.sol";

contract DMF {
//rketToken1 public a;
            address public m1;
            address public m2;
           Mam1 ab;
           Man2 bb;
           uint256 public xy;
           uint256 public y;
           
        FundToken public Token; //obj for Fundtoken3
       
         
     //Constructor For initialize the contract Owner Address and Contract Deployed Address
            function DMF(address na,address Mark1,address Mark2)public payable{
                owner=msg.sender;
                newadd=address(this);
                Token=new FundToken();
                 contractAddress=na;
                 m1=Mark1;
                 m2=Mark2;
                bb= Man2(m2);
                 ab= Mam1(m1);
                
            
                
            }
       
        //modifier only access the functions by Portfolio manager 
        modifier OnlyPortfolio()
        {
            if(msg.sender == ToatlportfolioMAddress[0])
            {
                _;
            }
        }
        //Global Variable Declaration part

        address owner; //owner variable for assigning contract Owner
        address public newadd; //For getting the Contract Address
        uint256 rate = 0.001 ether; //rate of Fundtoken For PortfolioManager
        uint256 cost = 0.1 ether; //rate of Fundtokens For Investor 
        uint256 dividendToken = 100; //divident tokens count for give the profit to Investor
        uint256 profitToken = 10; //profit tokens for the Portfolio manager 
        uint256 public PortfolioManagerprofit = 0; //For the Portfoliomanager profit tokens 
        address contractAddress; //Fundtoken
        uint256 public InvestersTotalToken=0; //invester total token count
    
        
        address public Pendingreturnaddress;
    //ArrayList
     address[] ToatlportfolioMAddress; //Array for storing the each register PortfolioManager
     address[] public TotalInvestorAddress; //Array for storing the each register Investors
     uint256 public etherCalculation;


     
    //Phase -2                                                                                                                                                                                                                                                                
                            //Structure Area
     

     //Structure For PortfolioManager Details
            struct PortfolioDetails
            {
                address portfolioM;
                //address contractAdd;
                uint256 Eth;
            }
    //Structure For Investor Details  
            struct InvestorDetails
            {
                address buyer;
                uint256 Eth;
                uint256 TokenCount;
            }

   //Structure For MarketToken Purchase Details
   struct MarketTokenPurchase
   {
       address contractAdd;
       string name;
       string symbol;
       uint256 decimal;
       uint256 totalbuycount;

   }
   
          //For assigning totalsuply 
    //Mapping Area

    mapping(address => PortfolioDetails) public Portfolio ; //Map for getting and storing the PortfolioManager resgistration Details
    mapping(address => mapping( address =>  InvestorDetails)) public invester ; //map for getting and storing the Investor getting token details
    mapping(address => mapping(address => MarketTokenPurchase)) public Market; //Map for getting the MarketToken Purchase details by the Portfoliomanager
    mapping(address => uint256) public PM_soldTK_Ether; //Portfoliomanager Sold Tokens Ether 
      //Fallback Function For Holding the Ether in Contract
     

                                //Function Area
        //Function For PortfolioManager Resgistration
        function PortfolioReg() public payable{
        Portfolio[msg.sender].portfolioM= msg.sender;
        uint256 add = msg.value / 1 ether;
        Portfolio[msg.sender].Eth= Portfolio[msg.sender].Eth + add;
        PM_soldTK_Ether[msg.sender] = PM_soldTK_Ether[msg.sender] + add;
        GetFundToken(msg.value);
        }
        
       

        //Function For Getting the Fundtokens by the PortfolioManager
         function GetFundToken(uint256 value) private{
            uint256 tokens = value / rate;
            FundToken(contractAddress).mintToken(msg.sender,tokens);
            //Transfer(0,msg.sender,msg.value);
           
           
            ToatlportfolioMAddress.push(msg.sender);
         }

        //Function For Getting the Contract Ether Balance 
      function GetBal()public view returns(uint256){
          return this.balance/ 1 ether;
         // 1 ether; //converting wei value to ether
      }
      

      //Function For Getting the Contract Address
      function getContractaddress() public view returns(address)
      {
          return newadd;
      }
      
      
      //Phase-3

      //Function For Buying the FundTokens by the Investor From the PortfolioManager
      function InvesterGetToken(address _portfolioadd_) public payable
      {
          uint256 tokens = msg.value / cost;
          InvestersTotalToken += tokens;
          FundToken(contractAddress).transferFrom(ToatlportfolioMAddress[0],msg.sender,tokens);
          TotalInvestorAddress.push(msg.sender);
          invester[msg.sender][_portfolioadd_].buyer = msg.sender;
          uint256 test = msg.value / 1 ether;
          invester[msg.sender][_portfolioadd_].Eth = test;
          invester[msg.sender][_portfolioadd_].TokenCount = tokens;
          PM_soldTK_Ether[_portfolioadd_] = PM_soldTK_Ether[_portfolioadd_] + test;
          
      }
    
  

    //Phase-4


    //Function For Getting the Investor Balance of Tokens
    function getBalance() public view returns(uint256)
    {
       return FundToken(contractAddress).balanceOf(TotalInvestorAddress[0]);
    }

    //Phase-5
    
    /** The dividends calculations
        Investor1 = (( Investor1_fund TK) / (Inves1_FUndTK + Inves2_FUndTK + ... )) * 90;
     */
    //Function For issue the Dividends yo the User
   function Dividends() public OnlyPortfolio   
    {
        
        FundToken(contractAddress).mintToken(msg.sender,dividendToken); //minting the token 
        PortfolioManagerprofit = (dividendToken* 10) / 100; //taking the portfolio share
        FundToken(contractAddress).mintToken(msg.sender,PortfolioManagerprofit);
       
        
         ShareETK_ToI();
         
         
    }
    
    
    
    
    //function for split the profit to each tokens
    function ShareETK_ToI() private 
    {
        for(uint256 i=0;i<TotalInvestorAddress.length;i++)
        {
            uint256 b = invester[TotalInvestorAddress[i]][msg.sender].TokenCount * (dividendToken - PortfolioManagerprofit);
             uint256 a =  b  / InvestersTotalToken;
           FundToken(contractAddress).mintToken(TotalInvestorAddress[i],a);
           FundToken(contractAddress).tokenDecrease(msg.sender,a);
        }
    }
    //function for split the profit to each tokens
    
    
    //getting All the Investor and PortfolioManager balance 
    function getAllBalance() public view returns(uint256)
    {
     return FundToken(contractAddress).balanceOf(msg.sender);
    }
    
 
      //Phase-6 
      
      //Function for Sell The Tokens to the PortfolioManager
    function ReturnTokenToPortfolioManager(address _portfolioadd_,uint256 value)public payable{
     
        FundToken(contractAddress).transferFrom(msg.sender,_portfolioadd_,value);
        uint256 TR = value * cost;
         address x = msg.sender;
         x.transfer(TR);
        
     }
     
    
   

   function PortfolioManagerList()public view returns(address){
       for(uint256 i=0;i<ToatlportfolioMAddress.length;i++)
       {
           return ToatlportfolioMAddress[i];
       }
   }


   //Phase-7

                //Two Sample Market is successfully created 

    

   //Phase-8
   
   //Function for Purchase the market tokens by the PortfolioManager
 

function PurchasingMarket1token(address _contractadd,string _name,string _symbol,uint256 _totacount) public 
   {
       
        uint256 howmuchEther = PM_soldTK_Ether[msg.sender];
        uint256 PurchaseTkTotalRate = _totacount * 0.01 ether;
        uint256 calculations = PurchaseTkTotalRate / 1 ether;
        require(howmuchEther > calculations);
        xy = _totacount * 0.1 ether;
        m1.call.gas(2500000).value(xy)();
        Market[msg.sender][_contractadd].name = _name;
        Market[msg.sender][_contractadd].symbol = _symbol;
        Market[msg.sender][_contractadd].decimal = 0;
        Market[msg.sender][_contractadd].totalbuycount = _totacount;
        Market[msg.sender][_contractadd].contractAdd = _contractadd;
    }
   function PurchasingMarket2token(address _contractadd,string _name,string _symbol,uint256 _totacount) public 
   {
        uint256 howmuchEther =  PM_soldTK_Ether[msg.sender];
        uint256 PurchaseTkTotalRate = _totacount * 0.01 ether;
        uint256 calculations = PurchaseTkTotalRate / 1 ether;
        require(howmuchEther > calculations);
        y = _totacount * 0.1 ether;
        m2.call.gas(2500000).value(y)();
        Market[msg.sender][_contractadd].name = _name;
        Market[msg.sender][_contractadd].symbol = _symbol;
        Market[msg.sender][_contractadd].decimal = 0;
        Market[msg.sender][_contractadd].totalbuycount = _totacount; 
        Market[msg.sender][_contractadd].contractAdd = _contractadd;
   }

   function DisplayPurchasedTKCount() public view returns(uint256)
   {
       uint256 count1 = Mam1(m1).DisplayBalance(newadd);
       uint256 count2 = Man2(m2).DisplayBalance(newadd);
       uint256 total = count1 + count2;
       return total;
    }



    //Phase-9

    //Function For Many PortfolioManager Details
    function listOfPortfolioManager(address a)public view returns(address,uint256,uint256){
       for(uint i=0;i<ToatlportfolioMAddress.length;i++){
           if(a == Portfolio[a].portfolioM){
                return (Portfolio[a].portfolioM,PM_soldTK_Ether[msg.sender],FundToken(contractAddress).balanceOf(a));
           }
       }
   }


  
}                                                                                     