pragma solidity ^0.4.18;

import "./MarketToken1.sol";
import "./FundToken.sol";
import "./MarketToken2.sol";

contract DMF 
{

// Object Creation 

        FundToken public Token;
        Mam1 ab;
        Man2 bb;

           
//Global Variable Declaration part

        uint public TR;
        uint256 rate = 0.001 ether; //rate of Fundtoken For PortfolioManager
        uint256 cost = 0.1 ether; //rate of Fundtokens For Investor 
        uint256 dividendToken = 100; //divident tokens count for give the profit to Investor
        uint256 profitToken = 10; //profit tokens for the Portfolio manager 
        uint256 public PortfolioManagerprofit = 0; //For the Portfoliomanager profit tokens 
        uint256 public InvestersTotalToken=0; //invester total token count
        uint256 public takecommission;
        uint256 public calculations;
        uint256 public commissionForDmf;
        uint256 public etherCalculation;
        address public m1;
        address public m2;
        address contractAddress; //Fundtoken
        address public Pendingreturnaddress;
        address owner; //owner variable for assigning contract Owner
        address public newadd; //For getting the Contract Address

//ArrayList

        address[] public ToatlportfolioMAddress; //Array for storing the each register PortfolioManager
        address[] public TotalInvestorAddress; //Array for storing the each register Investors

        
//Structure Area
     
//Structure For PortfolioManager Details

        struct PortfolioDetails
        {
            address portfolioM;
            uint256 Eth;
            string tokenName;
            uint256 count1;
            uint256 count2;
            uint commissionForPortfolio;
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

//Mapping Area

//Map for getting and storing the PortfolioManager resgistration Details
        mapping(address => PortfolioDetails) public Portfolio ;

//map for getting and storing the Investor getting token details
        mapping(address => mapping( address =>  InvestorDetails)) public invester ; 

//Map for getting the MarketToken Purchase details by the Portfoliomanager
        mapping(address => mapping(address => MarketTokenPurchase)) public Market; 

//Portfoliomanager Sold Tokens Ether 
        mapping(address => uint256) public PM_soldTK_Ether; 
            
//Constructor For initialize the contract Owner Address and Contract Deployed Address

        function DMF(address na,address Mark1,address Mark2)public payable
        {
            owner=msg.sender;
            newadd=address(this);
            Token=new FundToken();
            contractAddress=na;
            m1=Mark1;
            m2=Mark2;
            bb= Man2(m2);
            ab= Mam1(m1);
        }
       
//Function Area
         
//Function For PortfolioManager Resgistration

        function PortfolioReg() public payable
        {
            Portfolio[msg.sender].portfolioM= msg.sender;
            uint256 add = msg.value / 1 ether;
            uint256 a= add * 10;
            uint256 trim = a /100;
            takecommission += trim;
            uint256 show = add - trim;
            Portfolio[msg.sender].Eth= Portfolio[msg.sender].Eth + show;
            PM_soldTK_Ether[msg.sender] = PM_soldTK_Ether[msg.sender] + show;
            GetFundToken(msg.value);
        }
        
//Function For Getting the Fundtokens by the PortfolioManager

        function GetFundToken(uint256 value) private
        {
            uint256 tokens = value / rate;
            FundToken(contractAddress).mintToken(msg.sender,tokens);
            ToatlportfolioMAddress.push(msg.sender);
        }

//Function For Getting the Contract Ether Balance 

        function GetBal()public view returns(uint256)
        {
            return this.balance/ 1 ether;
        }
      
 //Function For Getting the Contract Address

        function getContractaddress() public view returns(address)
        {
            return newadd;
        }
      
 //Function For Buying the FundTokens by the Investor From the PortfolioManager

        function InvesterGetToken(address _add_) public payable
        {
            uint256 tokens = msg.value / cost;
            InvestersTotalToken += tokens;
            FundToken(contractAddress).transferFrom(_add_,msg.sender,tokens);
            TotalInvestorAddress.push(msg.sender);
            invester[msg.sender][_add_].buyer = msg.sender;
            invester[msg.sender][_add_].Eth = invester[msg.sender][_add_].Eth + msg.value;
            uint256 test = msg.value / 1 ether;
            invester[msg.sender][_add_].Eth = test;
            invester[msg.sender][_add_].TokenCount = tokens;
            PM_soldTK_Ether[_add_] = PM_soldTK_Ether[_add_] + test;
            Portfolio[_add_].Eth = Portfolio[_add_].Eth + test;
        }
    
//Function For Getting the Investor Balance of Tokens

        function getBalance() public view returns(uint256)
        {
            return FundToken(contractAddress).balanceOf(TotalInvestorAddress[0]);
        }

 /** The dividends calculations
        Investor1 = (( Investor1_fund TK) / (Inves1_FUndTK + Inves2_FUndTK + ... )) * 90;
*/

//Function For issue the Dividends yo the User

        function Dividends() public  
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

//getting All the Investor and PortfolioManager balance 

        function getAllBalance() public view returns(uint256)
        {
            return FundToken(contractAddress).balanceOf(msg.sender);
        }
    

      
//Function for Sell The Tokens to the PortfolioManager

        function ReturnTokenToPortfolioManager(address _add_,uint256 value)public payable
        {
            FundToken(contractAddress).transferFrom(msg.sender,_add_,value);
            TR = value * cost;
            commissionForDmf += TR * 10 / 100;
            uint256 dash = commissionForDmf / 1 ether;
            takecommission += dash;
            Portfolio[_add_].commissionForPortfolio += TR * 10 /100; 
            uint256 a= commissionForDmf + Portfolio[_add_].commissionForPortfolio;
            uint256 b= TR - a + commissionForDmf;
            _add_.transfer(Portfolio[_add_].commissionForPortfolio);
            address x = msg.sender;
            newadd.call.gas(2500000).value(commissionForDmf)();
            x.transfer(b);
            invester[msg.sender][_add_].Eth= invester[msg.sender][_add_].Eth - TR;
        }
     
    
   

        function PortfolioManagerList()public view returns(address)
        {
            for(uint256 i=0;i<ToatlportfolioMAddress.length;i++)
            {
                return ToatlportfolioMAddress[i];
            }
        }

//Function for Purchase the market tokens by the PortfolioManager
 
       function PurchasingMarket1token(address _contractadd,string _name,string _symbol,uint256 _totacount) public 
       {
            uint256 howmuchEther = PM_soldTK_Ether[msg.sender];
            uint256 PurchaseTkTotalRate = _totacount * 0.1 ether;
            calculations = PurchaseTkTotalRate / 1 ether;
            require(howmuchEther > calculations);
            m1.call.gas(2500000).value(PurchaseTkTotalRate)();
            Market[msg.sender][_contractadd].name = _name;
            Market[msg.sender][_contractadd].symbol = _symbol;
            Market[msg.sender][_contractadd].decimal = 0;
            Market[msg.sender][_contractadd].totalbuycount = _totacount;
            Market[msg.sender][_contractadd].contractAdd = _contractadd;
            Portfolio[msg.sender].tokenName=_name;
            Portfolio[msg.sender].count1=_totacount;
            uint256 fg = Portfolio[msg.sender].Eth - calculations;
            Portfolio[msg.sender].Eth= fg;    
       }

        function PurchasingMarket2token(address _contractadd,string _name,string _symbol,uint256 _totacount) public 
        {
            uint256 howmuchEther =  PM_soldTK_Ether[msg.sender];
            uint256 PurchaseTkTotalRate = _totacount * 0.1 ether;
            calculations = PurchaseTkTotalRate / 1 ether;
            require(howmuchEther > calculations);
            m2.call.gas(2500000).value(PurchaseTkTotalRate)();
            Market[msg.sender][_contractadd].name = _name;
            Market[msg.sender][_contractadd].symbol = _symbol;
            Market[msg.sender][_contractadd].decimal = 0;
            Market[msg.sender][_contractadd].totalbuycount = _totacount; 
            Market[msg.sender][_contractadd].contractAdd = _contractadd;
            Portfolio[msg.sender].tokenName=_name;
            Portfolio[msg.sender].count2=_totacount;
            uint256 fg = Portfolio[msg.sender].Eth - calculations;
            Portfolio[msg.sender].Eth= fg;
        }

        function DisplayPurchasedTKCount() public view returns(uint256)
        {
            uint256 count1 = Mam1(m1).DisplayBalance(newadd);
            uint256 count2 = Man2(m2).DisplayBalance(newadd);
            uint256 total = count1 + count2;
            return total;
        }


        function DisplayPurchasedTK1() public view returns(address,string,string,uint256,uint256)
        {
            string _nn = Market[msg.sender][m1].name;
            string _sm = Market[msg.sender][m1].symbol;
            uint256 _dd =  Market[msg.sender][m1].decimal;
            uint256 _pp = Market[msg.sender][m1].totalbuycount;
            return(m1,_nn,_sm,_dd,_pp);
        }

        function DisplayPurchasedTK2() public view returns(address,string,string,uint256,uint256)
        {
            string _nn = Market[msg.sender][m2].name;
            string _sm = Market[msg.sender][m2].symbol;
            uint256 _dd =  Market[msg.sender][m2].decimal;
            uint256 _pp = Market[msg.sender][m2].totalbuycount;
            return(m2,_nn,_sm,_dd,_pp);
        }

//Function For Many PortfolioManager Details

        function listOfPortfolioManager(address a)public view returns(address,uint256,uint256,uint256,uint256)
        {
            for(uint i=0;i<ToatlportfolioMAddress.length;i++)
            {
                if(a == Portfolio[a].portfolioM)
                {
                    return (Portfolio[a].portfolioM,Portfolio[a].Eth,FundToken(contractAddress).balanceOf(a),Portfolio[a].count1,Portfolio[a].count2);
                }
            }
        }


        function Pcount() public view returns(uint256)
        {
            return ToatlportfolioMAddress.length;
        }

        function getPortfolioAddress(uint a) public view returns(address)
        {
            return ToatlportfolioMAddress[a];
        }

        function getInvesterAddress(uint a,uint a1) public view returns(address,address)
        {
            return (ToatlportfolioMAddress[a],TotalInvestorAddress[a1]);
        }

        function Icount() public view returns(uint256)
        {
            return TotalInvestorAddress.length;
        }
  
}                                                                                     