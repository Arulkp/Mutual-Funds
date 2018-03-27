pragma solidity ^0.4.18;


contract BusinessLogic{
    
    
    //portfolo_manager details structue
     struct register{
        string name;
        string email;
        string password;
        uint256 _ether;
        bool statuscode;
    }
    
    
    //Investor details structre
    struct InvestorReg
    {
        string name;
        string password;
        bool statuscode;
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
    
    mapping(address => register) public PortReg; //Map for portfoliomanager 
    mapping(address => Tokens) public PortToken; //Map for portfoliomangertokens
    mapping(address=>mapping(address =>  InvestorProfile )) public InvestorP; //Map for Investor profile page
    mapping(address =>InvestorReg) public InvestorRegister; //Map for Investorregister
    mapping(address =>  ProtfolioMProfile ) public PortfolioMP; //Map for PortfolioManager Profile
    mapping(address => InvestmentD) public InvestorInvestD; // Map for InestorInvestment details
    mapping(address => mapping(address => Dividends)) public MapDivide; //Map for Divident details
    
    
    //Function for portfolio manager registration
    function Click_Reg(string _name,string _email,string _password) public payable
    {
        if(msg.value /1000000000000000000 == 5)
        {
            
           PortReg[msg.sender].name = _name;
            PortReg[msg.sender].email = _email;
            PortReg[msg.sender].password = _password;
           PortReg[msg.sender]._ether = msg.value / 1000000000000000000;
           PortReg[msg.sender].statuscode = true;
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
    
    
    //Function for investor registration
    function InvestorR(string _name,string _password) public
    {
        var InvestorRegisterV =  InvestorRegister[msg.sender];
        InvestorRegisterV.name = _name;
        InvestorRegisterV.password = _password;
        InvestorRegisterV.statuscode = true;
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
    
    
  
  
  

    
  
   
   
    
    
    
    
    
}