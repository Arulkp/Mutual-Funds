pragma solidity ^0.4.18;

import "./FundToken.sol";


contract DMF is FundToken{
    
        address owner;
        uint256 rate = 0.001 ether;
        
        address public newadd;
   
                       //Phase -2
            
            struct PortfolioMFTK
            {
                address portfolioM;
                //address contractAdd;
                uint256 Eth;
            }
            
            struct InvestorPTk
            {
                address buyer;
                uint256 Eth;
                uint256 howTK;
            }
            function DMF()public{
                owner=msg.sender;
                newadd=address(this);
                
            }
       
            
      
      mapping(address => PortfolioMFTK) public BuyTK;
      function () public payable{
          
      }
      
        function PortfolioReg(address _portfolioM) public payable{
            BuyTK[msg.sender].portfolioM=_portfolioM;
            BuyTK[msg.sender].Eth=BuyTK[msg.sender].Eth + msg.value;
         
            GetFundToken();
        }
         function GetFundToken() private{
            uint256 tokens = msg.value / rate;
            balanceOf[msg.sender] = balanceOf[msg.sender] + tokens;
            Transfer(0,msg.sender,msg.value);
            balanceOf[Owner] = balanceOf[Owner] - tokens;
         }

      function GetBal()public view returns(uint256){
          return this.balance/ 1 ether; //converting wei value to ether
      }
      
      function getContractaddress() public view returns(address)
      {
          return newadd;
      }
      
    

}