pragma solidity ^0.4.11;
import "./Timing.sol";

import "./MutualFundToken.sol";
contract portfolioManagerProfile is MutualFund {
    address owner;
    
    
    function portfolioManagerProfile(string _name,string _symbol,uint256 _decimals,uint256 _totalsupply)public
    {
        totalsupply = _totalsupply;
        balanceOf[msg.sender]=totalsupply;
        symbol= _symbol;
        name=_name;
        initialallowed=500;
        decimals= _decimals;
        owner=msg.sender;
    }
    address[] TotalInvesterDetails;    
  //  address[] portfolioProfile;
    using DateTime for uint16;
   // uint256 d1;
    struct portfolioManager{
     
       bytes32[] tokennames;
       uint256[] OnetokenRate;
        address pAddress;
        address[] InvesterForThisParticularPortfolio;
       // uint256 time;
        uint256 totalether;
        uint256[] totalNoOfToken;
   
    }
    mapping(address=>portfolioManager) portfolio;
     function setPortfoliodetail(bytes32 tokennames,uint256 OnetokenRate,uint totalsupply)public{
         address pAddress=owner;
         portfolio[pAddress].pAddress=pAddress;
         portfolio[pAddress].tokennames.push(tokennames);
         portfolio[pAddress].totalether;
         portfolio[pAddress].totalNoOfToken.push(totalsupply);
         portfolio[pAddress].OnetokenRate.push(OnetokenRate);
        
     }
      function getportfoliodetails(address pAddress)public view returns(address,bytes32[],uint256[],uint256,address[])
     {
         return ((portfolio[pAddress].pAddress),(portfolio[pAddress].tokennames),(portfolio[pAddress].totalNoOfToken),(portfolio[pAddress].totalether), portfolio[pAddress].InvesterForThisParticularPortfolio);
     }
    /* function getTotalportfolioAddress()public view returns(address[]){
         return portfolioProfile;
     }*/
     
    
 struct investerStruct
 {
     address investerAddress;
     string fundtoken;
     
 }
    mapping(address=>investerStruct)investDetails;
  mapping(address=>mapping(address=>investerStruct))invester;
  
   
     function investingOnAnyPortfolio(address selectedPortfolio,uint256 valueEther)public payable  returns(bool){
      require(selectedPortfolio!=msg.sender);
      address investerAddress=msg.sender;
       invester[selectedPortfolio][investerAddress].investerAddress=investerAddress;
       TotalInvesterDetails.push(investerAddress);
       if(valueEther!=0){
           transfer(selectedPortfolio,valueEther);
       }
       portfolio[selectedPortfolio].InvesterForThisParticularPortfolio.push(investerAddress);
       invester[selectedPortfolio][investerAddress].fundtoken=name;
       return true;
     }
     function ShowInvesterDetails(address investerAddress)public returns(address,string){
         return (investDetails[investerAddress].investerAddress,investDetails[investerAddress].fundtoken);
     }
     
     
     
      //function getdate()public view returns(uint256,uint256,uint256){
      //   return (DateTime.getDay(d1),DateTime.getMonth(d1),DateTime.getYear(d1));
     //}
     
   
        
  
    
     
   
}