pragma solidity ^0.4.18;

//import "./FundToken.sol";
import "./aa.sol";

contract DMF {
    
        FundToken public Token; //obj for Fundtoken3
    
     //Constructor For initialize the contract Owner Address and Contract Deployed Address
            function DMF(address na)public payable{
                owner=msg.sender;
                newadd=address(this);
                Token=new FundToken();
                 contractAddress=na;
            
    
                
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
        uint256 cost = 0.01 ether;  //rate of FundToken For Investors
        uint256 dividendToken = 100; //divident tokens count for give the profit to Investor
        uint256 profitToken = 10; //profit tokens for the Portfolio manager 
        uint256 public PortfolioManagerprofit = 0; //For the Portfoliomanager profit tokens 
        address contractAddress; //Fundtoken
        uint256 public InvestersTotalToken=0; //invester total token count
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

   
          //For assigning totalsuply 
                             //Mapping Area

      mapping(address => PortfolioDetails) public Portfolio ; //Map for getting and storing the PortfolioManager resgistration Details
      mapping(address => InvestorDetails) public invester ; //map for getting and storing the Investor getting token details
      //Fallback Function For Holding the Ether in Contract
      function () public payable{
          
      }
      

                                //Function Area
        //Function For PortfolioManager Resgistration
        function PortfolioReg() public payable{
        Portfolio[msg.sender].portfolioM= msg.sender;
            Portfolio[msg.sender].Eth=Portfolio[msg.sender].Eth + msg.value;
         
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
      function GetContractEtherBalance()public view returns(uint256){
          return this.balance/ 1 ether; //converting wei value to ether
      }
      

      //Function For Getting the Contract Address
      function getContractaddress() public view returns(address)
      {
          return newadd;
      }
      
      
      //Phase-3

      //Function For Buying the FundTokens by the Investor From the PortfolioManager
      function InvesterGetToken() public payable
      {
          uint256 tokens = msg.value / cost;
          InvestersTotalToken += tokens;
          FundToken(contractAddress).transferFrom(ToatlportfolioMAddress[0],msg.sender,tokens);
          //FundToken(contractAddress).mintToken(msg.sender,tokens);
        //  FundToken(contractAddress).tokende(ToatlportfolioMAddress[0],tokens);
          ToatlportfolioMAddress[0].transfer(msg.value);
          TotalInvestorAddress.push(msg.sender);
          invester[msg.sender].buyer = msg.sender;
          invester[msg.sender].Eth = msg.value;
          invester[msg.sender].TokenCount = tokens;
          
      }
    
  

    //Phase-4


    //Function For Getting the Investor Balance of Tokens
  //  function getBalance() public view returns(uint256)
    //{
      // return  FundToken(contractAddress).gettheD(TotalInvestorAddress[0]);
    //}

    //Phase-5
    
    /** The dividends calculations
        Investor1 = (( Investor1_fund TK) / (Inves1_FUndTK + Inves2_FUndTK + ... )) * 90;
     */
    //Function For issue the Dividends yo the User
   function Dividends() public OnlyPortfolio  returns(uint256)  
    {
        
        FundToken(contractAddress).mintToken(owner,dividendToken); //minting the token 
       PortfolioManagerprofit = (dividendToken* 10) / 100; //taking the portfolio share
        FundToken(contractAddress).mintToken(msg.sender,PortfolioManagerprofit);
       // for(uint256 i =0;i < Investor.length; i++)
        //{
         // total +=  BuyInves[Investor[i]].howTK;
        //}
        
         ShareETK_ToI();
         
         
    }
    
    
    
    
    //function for split the profit to each tokens
    function ShareETK_ToI() private 
    {
        for(uint256 i=0;i<TotalInvestorAddress.length;i++)
        {
            uint256 b = invester[TotalInvestorAddress[i]].TokenCount * (dividendToken - PortfolioManagerprofit);
             uint256 a =  b  / InvestersTotalToken;
           FundToken(contractAddress).mintToken(TotalInvestorAddress[i],a);
        }
    }
    //function for split the profit to each tokens
    
    
    //getting All the Investor and PortfolioManager balance 
    function getAllBalance() public view returns(uint256)
    {
     return FundToken(contractAddress).balanceOf(msg.sender);
    }
    
 
    function ReturnEtherToInvester(  uint256 value)public payable{
     
       //require(value<=invester[msg.sender].TokenCount);
     
      for(uint256 i=0;i<TotalInvestorAddress.length;i++){
          if(msg.sender == TotalInvestorAddress[i]){
              FundToken(contractAddress).transfer(ToatlportfolioMAddress[0],value);
        //etherCalculation=(value*cost)*1 ether; 
        (msg.sender).transfer(etherCalculation);
          }
      }
      
    }
    function TokenDetails() view returns(uint256,string,string,uint256){
        return FundToken(contractAddress).totalSupply();
    }
   
}
