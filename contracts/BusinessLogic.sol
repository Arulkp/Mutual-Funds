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
    address[] UserAddr;
    




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
    
    
    //InvestorInvestnet details structre
     struct InvestorDetails{
        address UserAddr;
        string name;
        uint Date;
        uint Month;
        uint Year;
        uint Hour;
        uint Minute;
        uint256 eth;
    }

    //Structure For Investor registration
     struct InvestorRegister{
        address UserAddr;
        string name;
        uint256 eth;
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
    
    //Structure for portfolio manager fundtokens
    struct Tokens
    {
        string tkname;
        string tksymbol;
        uint256 tkdecimal;
        uint256 tktotalsup;
    }

    //Structure for portfolio manager purchase token
    struct purchaseTK
    {
        string tkname;
        string tksymbol;
        uint256 tkdecimal;
        uint256 tktotalsup;
        uint256 buyrate;
        address vendor;

    }
    

    //Generating the FundToken By the Portfolio manager
     function MutualFund(string _name,string _symbol,uint256 _decimals,uint256 _totalsupply)public
    {
        MutualFundCreation(_name,_symbol,_decimals,_totalsupply);
        var port_tokD = PortToken[msg.sender];
        port_tokD.tkname = _name;
        port_tokD.tksymbol = _symbol;
        port_tokD.tkdecimal = _decimals;
        port_tokD.tktotalsup = _totalsupply; 

        
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
    
    mapping(address=>Reg) public RegMap;  //Map for portfoliomanager 
    mapping(address => Tokens) public PortToken; //Map for portfoliomangertokens
    mapping(address=>mapping(address =>  InvestorProfile )) public InvestorP; //Map for Investor profile page
    mapping(address=>InvestorDetails) InvesMap; //Map for InvestorInvestment
    mapping(address=> InvestorRegister)public IRegMap; //Map for Investorregistration
    mapping(address =>  ProtfolioMProfile ) public PortfolioMP; //Map for PortfolioManager Profile
    mapping(address => InvestmentD) public InvestorInvestD; // Map for InestorInvestment details
    mapping(address => mapping(address => Dividends)) public MapDivide; //Map for Divident details
    mapping(address => purchaseTK) public PURTK; // Map for portfoliomanager purchased token details 
    
    
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
    

    //Function for Investor registration
        function InvestmentRegister(address _UserAddr,string _name)public
        {
          if(msg.value / 1000000000000000000 == 5){ 
        UserAddr.push(msg.sender);
        IRegMap[msg.sender].UserAddr=_UserAddr;
        IRegMap[msg.sender].name=_name;
        owner.transfer(msg.value);
          }
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
    
   function Investment(address _PortfolioAddr) public payable returns(bool){
        owner.transfer(msg.value);
       InvesMap[msg.sender].eth= InvesMap[msg.sender].eth + msg.value;
        uint etherValue= msg.value * 100;
        uint value=  etherValue / 1 ether;
        transfer(_PortfolioAddr,value);
        time=now;
        getDate();
        return true;
    }


    //the Date Function is used to calculate the investment time
      function getDate() private{
        InvesMap[msg.sender].Hour=DateTime.getHour(time);
        InvesMap[msg.sender].Minute=DateTime.getMinute(time);
        InvesMap[msg.sender].Date=DateTime.getDay(time);
        InvesMap[msg.sender].Month=DateTime.getMonth(time);
        InvesMap[msg.sender].Year=DateTime.getYear(time);
    }
  
    //function For purchasing the ERC20 tokens by the portfoliomanager

    function bought(address _vendor,uint256 _amount)
    {
        _vendor.send(_amount);
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
   function GetInvestmentDetails(address _UserAddr)public returns(string,uint256,uint,uint,uint,uint,uint) {
        return (InvesMap[_UserAddr].name,InvesMap[msg.sender].eth,InvesMap[msg.sender].Date,InvesMap[msg.sender].Month,InvesMap[msg.sender].Year,InvesMap[msg.sender].Hour,InvesMap[msg.sender].Minute);
    }
    
    
    
    
    
}