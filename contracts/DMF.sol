pragma solidity ^0.4.18;

import "./FundToken.sol";


contract DMF is FundToken{
    
                            //Global Variable Declaration part

        address owner; //owner variable for assigning contract Owner
        address public newadd; //For getting the Contract Address
        uint256 rate = 0.001 ether; //rate of Fundtoken For PortfolioManager
        uint256 cost = 0.01 ether;  //rate of FundToken For Investors
        uint256 dividendTK = 100; //divident tokens count for give the profit to Investor
        uint256 profitTk = 10; //profit tokens for the Portfolio manager 
        uint256 public total = 0;
        
    //ArrayList
     address[] portfolioMAdd; //Array for storing the each register PortfolioManager
     address[] Investor; //Array for storing the each register Investors
   
    //Phase -2
                            //Structure Area


     //Structure For PortfolioManager Details
            struct PortfolioMFTK
            {
                address portfolioM;
                //address contractAdd;
                uint256 Eth;
            }
    //Structure For Investor Details  
            struct InvestorPTk
            {
                address buyer;
                uint256 Eth;
                uint256 howTK;
            }

    //Constructor For initialize the contract Owner Address and Contract Deployed Address
            function DMF()public{
                owner=msg.sender;
                newadd=address(this);
                
            }
       
           
                             //Mapping Area

      mapping(address => PortfolioMFTK) public BuyTK; //Map for getting and storing the PortfolioManager resgistration Details
      mapping(address => InvestorPTk) public BuyInves; //map for getting and storing the Investor getting token details
      //Fallback Function For Holding the Ether in Contract
      function () public payable{
          
      }
      

                                //Function Area
        //Function For PortfolioManager Resgistration
        function PortfolioReg() public payable{
            BuyTK[msg.sender].portfolioM= msg.sender;
            BuyTK[msg.sender].Eth=BuyTK[msg.sender].Eth + msg.value;
         
            GetFundToken();
        }

        //Function For Getting the Fundtokens by the PortfolioManager
         function GetFundToken() private{
            uint256 tokens = msg.value / rate;
            balanceOf[msg.sender] = balanceOf[msg.sender] + tokens;
            Transfer(0,msg.sender,msg.value);
            portfolioMAdd.push(msg.sender);
         }

        //Function For Getting the Contract Ether Balance 
      function GetBal()public view returns(uint256){
          return this.balance/ 1 ether; //converting wei value to ether
      }
      

      //Function For Getting the Contract Address
      function getContractaddress() public view returns(address)
      {
          return newadd;
      }
      
      
      //Phase-3

      //Function For Buying the FundTokens by the Investor From the PortfolioManager
      function getTokens() public payable
      {
          uint256 tokens = msg.value / cost;
          balanceOf[msg.sender] = balanceOf[msg.sender] + tokens;
          balanceOf[portfolioMAdd[0]] = balanceOf[portfolioMAdd[0]] - tokens;
          portfolioMAdd[0].transfer(msg.value);
          Investor.push(msg.sender);
          BuyInves[msg.sender].buyer = msg.sender;
          BuyInves[msg.sender].Eth = msg.value;
          BuyInves[msg.sender].howTK = tokens;
          
      }
    
  

    //Phase-4


    //Function For Getting the Investor Balance of Tokens
    function getBalance() public view returns(uint256)
    {
        return balanceOf[Investor[0]];
    }

    //Phase-5

    function Dividends() public payable returns(uint256)  
    {
        for(uint256 i =0;i < Investor.length; i++)
        {
          total +=  BuyInves[Investor[i]].howTK; 
          return total;
        }
    }
    

   
}