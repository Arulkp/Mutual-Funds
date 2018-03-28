pragma solidity ^0.4.18;

import "./MutualFundToken.sol";
import "./Timing.sol";
contract BusinessLogic is MutualFund{
    
    

    //Global variable part 
    address owner;
    uint time;
    using DateTime for uint256;


     //ArrayList part

    uint[] Date;
    uint[] Month;
    uint[] Year;
    address[] ListPortfolio;
    address[] ListInvestors;


    //constructor 
    function BusinessLogic() public
    {
        owner = msg.sender;
    }


    //portfolo_manager details structue
      struct Reg{
        string name;
        uint256 _ether;
        bool statuscode;
        
    }
    
    
    //Investor details structre
     struct InvestorDetails{
        address UserAddr;
        string name;
        uint[] count;
    }
    
    //Structure for InvestorProfile 
    struct InvestorProfile
    {
        address InvestorAdd;
        address portfoliomanager;
        uint256 howmuch;
        uint256 time;
        uint256 profitether;
        uint256 howmanyFund;
        
        
    }
    
    
    //structure for Protfolio manager purchase other token
    struct PortfoliomPurchase
    {
        address getAdd;
        uint256 sendEther;
        uint256 getTokenC;
        uint256 time;
    }
    
    //Structure for portfolio manager fundtokens and puchase Tokens
    struct Tokens
    {
        string tkname;
        string tksymbol;
        uint256 tkdecimal;
        uint256 tktotalsup;
    }
    
    //structue for portfoliomanager profile
    struct ProtfolioMProfile
    {
        address ProtfolioMProfileAdd;
        uint256 holdEther;
        uint256 howmanytHold;
        uint256 totalvalue;
        uint256 profit;
        uint256 loss;
        uint256 time;
        
    }
    
    //structure for Investor invest on Portfolio manager
    struct InvestmentD
    {
        address PortfolioMAdd;
        uint256 howmuchSpenETH;
        uint256 howmanyFundTG;
        uint256 oneFTR;
        uint256 time;
    }
    
    
    struct Dividends
    {
        address investorAdd;
        uint256 divident;
        uint256 time;
    }
    
    mapping(address=>Reg) RegMap;  //Map for portfoliomanager 
    mapping(address => Tokens) public PortToken; //Map for portfoliomangertokens
    mapping(address=>mapping(address =>  InvestorProfile )) public InvestorP; //Map for Investor profile page
    mapping(address=>InvestorDetails)InvesMap; //Map for Investorregister
    mapping(address =>  ProtfolioMProfile ) public PortfolioMP; //Map for PortfolioManager Profile
    mapping(address => InvestmentD) public InvestorInvestD; // Map for InestorInvestment details
    mapping(address => mapping(address => Dividends)) public MapDivide; //Map for Divident details
    
    
    //Function for portfolio manager registration
    function Click_Reg(string _name) public payable
    {
        if(msg.value /1000000000000000000 == 5)
        {
            
           RegMap[msg.sender].name = _name;
           RegMap[msg.sender]._ether = msg.value / 1000000000000000000;
           RegMap[msg.sender].statuscode = true;
           RegMap[msg.sender].name = _name;
            owner.transfer(msg.value);
            ListPortfolio.push(msg.sender);
        }
       
    }
    
   
   
   //function for getting the generated token 
    function generatedTK(string _tkname,string _tksymbol,uint256 _tkdecimals,uint256 tktotalsup_) public
    {
        var port_tokD = PortToken[msg.sender];
        port_tokD.tkname = _tkname;
        port_tokD.tksymbol = _tksymbol;
        port_tokD.tkdecimal = _tkdecimals;
        port_tokD.tktotalsup = tktotalsup_; 
        
    }
    
 
    
    /*
    //function for portfoliomanager Autthetication
    function portAuth(address _com_) public 
    {
        if(PortReg[_com_].statuscode == true)
        {
            
        }
    }
    
    
    
    //function for Investor Authentication
    function InvestAuth(address _Inv_) public
    {
        if(InvestorRegister[msg.sender].statuscode == true)
        {
            
        }
    }
    
    */
    
      function Investment(string _name,address _PortfolioAddr) public payable returns(bool){
        InvesMap[msg.sender].UserAddr = msg.sender;
        InvesMap[msg.sender].name = _name;
        owner.transfer(msg.value);
        uint etherValue= msg.value * 100;
        uint value=  etherValue / 1 ether;
        transfer(_PortfolioAddr,value);
        for(uint i=0;i<ListPortfolio.length;i++){
            if(_PortfolioAddr == ListPortfolio[i]){
                InvesMap[msg.sender].count[i] +1;
            }
        }
        time=now;
        getDate();
        return true;
    }
    //the Date Function is used to calculate the investment time
     function getDate() private{
        Date.push(DateTime.getDay(time));
        Month.push(DateTime.getMonth(time));
        Year.push(DateTime.getYear(time));
    }
  

    
  
   //Portfolio manager ArrayList for viewing 
   function PortfolioManagerList() public view returns(address[]){
        return ListPortfolio;
    }

    //Selecting the Portfoliomanager in the arrayoflist by Investor
    function SelectProfolioManager(address search) public returns(bool){
        for(uint i=0;i<ListPortfolio.length;i++){
            if(search == ListPortfolio[i]){
               return true; 
            }
        }
    }
    
    

    //getting the Investor details
    function GetInvestorsDetails(address _UserAddr)public returns(string,uint,uint,uint,uint) {
        for(uint i=0;i<InvesMap[_UserAddr].name.length;i++){
            return (InvesMap[_UserAddr].name[i],InvesMap[_UserAddr].count[i],Date[i],Month[i],Year[i]);  
        }
    }
    
    
    
    
    
}