pragma solidity ^0.4.18;

import "./FundToken.sol";


contract DMF is FundToken{
    
        address owner;
        uint256 public rate = 0.001 ether;

                       //Phase -2
            
            struct PortfolioMFTK
            {
                address portfolioM;
                //address contractAdd;
                uint256 Eth;
            }
            function Main()public{
                owner=msg.sender;
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
    
            balanceOf[Owner] = balanceOf[Owner] - tokens;
         }

      function GetBal()public view returns(uint256){
          return this.balance/ 1 ether; //converting wei value to ether
      }
     

}