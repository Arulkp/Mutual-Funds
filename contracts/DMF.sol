pragma solidity ^0.4.23;


contract ERC20 {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    // function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    // function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}



/*contract Token{
    
    function totalSupplytoken(address _token) public view returns(uint){
        return ERC20(_token).totalSupply();
    }
    
    function balanceOftoken(address _token) public view returns(uint){
        return ERC20(_token).balanceOf(msg.sender);
    }
    
    // before this You need to run approve function on your token contract...
    
    
    function transfer(address _token,address _to,uint _amt) public payable {
        ERC20(_token).transfer(_to,_amt);
    }
    
}*/

contract FundToken is ERC20
{
    string standard="Token 1.0";
    string public name;
    string public symbol;
    uint256 public totalsupply;
    uint256  initialallowed;
    uint256 public decimals;
    address Owner;

    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint256))public allowed;

     constructor()public
    {
        totalsupply=100000;
        balanceOf[msg.sender]=totalsupply;
        symbol="DMF";
        name="DMF";
        initialallowed=500;
        decimals=0;
        Owner = msg.sender;
        
    }
    function transferFrom(address from, address to, uint256 value)public returns(bool) 
    {
        //require(to != address(0));
       //require(value <= balanceOf[from]);
        //require(value <= allowed[from][msg.sender]);
    
        balanceOf[from]=balanceOf[from]-value;
        balanceOf[to] =balanceOf[to]+value;
        //allowed[from][msg.sender] = allowed[from][msg.sender]-(value);
       emit Transfer(from,to,value);
        return true;
    }
    
    
    function transfer(address to, uint256 value) public returns (bool)
    {
        require(value<=balanceOf[msg.sender]);
        balanceOf[msg.sender]=balanceOf[msg.sender]-value;
        balanceOf[to]=balanceOf[to]+value;
       emit Transfer(msg.sender,to,value);
        return true;
    }
    function totalSupply() public view returns (uint256)
    {
       return totalsupply;
    }
    function balanceOf(address _addr) public view returns (uint256)
    {
        return balanceOf[_addr];
    }
    
 function mintToken(address _add_,uint256 _amo) public
 {
     totalsupply=totalsupply + _amo;
     balanceOf[_add_] = balanceOf[_add_] + _amo;
 }
 function tokenDecrease(address _add_,uint256 _amo) public payable
 {
     balanceOf[_add_] = balanceOf[_add_] - _amo;
 }
 
}



library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract DMF 
{
        using SafeMath for uint256;
        uint256  InvestersTotalToken=0; //invester total token count
        uint256 public takecommission;
        address contractAddress; //Fundtoken
        address public newadd; 
//ArrayList
        address[] public ToatlportfolioMAddress; //Array for storing the each register PortfolioManager
        address[] public TotalInvestorAddress; //Array for storing the each register Investors
        address public TokenInterface;
//Structure For PortfolioManager Details
        struct PortfolioDetails
        {
            uint256 Eth;
          address[] investerAddressForPortfolio;
            uint commissionForPortfolio;
        }
//Structure For Investor Details  
        struct InvestorDetails
        {
            address[] PortfolioHolders; 
            uint256 Eth;
            uint256 TokenCount;
        }


       
//Mapping Area
//Map for getting and storing the PortfolioManager resgistration Details
        mapping(address => PortfolioDetails) public Portfolio;
//map for getting and storing the Investor getting token details
        mapping(address=> InvestorDetails) public Investment;
        mapping(address => mapping( address =>  InvestorDetails)) public invester; 
//Map for getting the MarketToken Purchase details by the Portfoliomanager
//Portfoliomanager Sold Tokens Ether 
       // mapping(address => uint256) public PM_soldTK_Ether; 
//Constructor For initialize the contract Owner Address and Contract Deployed Address
        constructor(address na) public payable
        {
          
            newadd=address(this);
            contractAddress=na;
        }
//Function For PortfolioManager Resgistration
        function PortfolioReg() public payable
        {
            uint256 add = msg.value.div(1 ether);
            uint256 a= (add.mul(10)).div(100);
            takecommission=takecommission.add(a);
            uint256 show = add.sub(a);
            Portfolio[msg.sender].Eth= Portfolio[msg.sender].Eth.add(show);
            //PM_soldTK_Ether[msg.sender] = PM_soldTK_Ether[msg.sender].add(show);
            GetFundToken(msg.value,msg.sender);
        }
        
        // function checkingPortfolio()public view returns(bool){
        //     for(uint256 i=0;i<ToatlportfolioMAddress.length;i++){
        //         if(msg.sender==ToatlportfolioMAddress[0]){
        //             return true;
        //         }
                
                
            // }
            
        // }
//Function For Getting the Fundtokens by the PortfolioManager
        function GetFundToken(uint256 value,address add) private
        {
            uint256 tokens = value.div(0.001 ether);
            FundToken(contractAddress).mintToken(msg.sender,tokens);
            ToatlportfolioMAddress.push(add);
        }
//Function For Getting the Contract Ether Balance 
        function GetBal()public view returns(uint256)
        {
            return newadd.balance.div(1 ether);
        }
 //Function For Getting the Contract Address
    
 //Function For Buying the FundTokens by the Investor From the PortfolioManager
        function InvesterGetToken(address _add_) public payable
        {
            uint256 tokens = msg.value.div(0.1 ether);
            InvestersTotalToken=InvestersTotalToken.add(tokens);
            FundToken(contractAddress).transferFrom(_add_,msg.sender,tokens);
            TotalInvestorAddress.push(msg.sender);
            Investment[msg.sender].PortfolioHolders.push(_add_);
            invester[msg.sender][_add_].Eth=invester[msg.sender][_add_].Eth.add(msg.value);
            invester[msg.sender][_add_].TokenCount=invester[msg.sender][_add_].TokenCount.add(tokens);
            
           // Investment[msg.sender].Eth = Investment[msg.sender].Eth.add(msg.value);
            uint256 test = msg.value.div(1 ether);
           // invester[msg.sender][_add_].Eth = test;
          //  Investment[msg.sender].TokenCount = tokens;
           // PM_soldTK_Ether[_add_] = PM_soldTK_Ether[_add_].add(test);
            Portfolio[_add_].Eth = Portfolio[_add_].Eth.add(test);
            Portfolio[_add_].investerAddressForPortfolio.push(msg.sender);
        }
//Function For Getting the Investor Balance of Tokens
        function getBalance(address a) public view returns(uint256)
        {
            return FundToken(contractAddress).balanceOf(a);
        }
 /** The dividends calculations
        Investor1 = (( Investor1_fund TK) / (Inves1_FUndTK + Inves2_FUndTK + ... )) * 90;
*/
//Function For issue the Dividends yo the User
        function Dividends() public  returns (bool)
        {
             uint256 dividendToken = 100; 
             uint256 PortfolioManagerprofit = 0;
            FundToken(contractAddress).mintToken(msg.sender,dividendToken); //minting the token 
            PortfolioManagerprofit = (dividendToken.mul(10)).div(100); //taking the portfolio share
            // FundToken(contractAddress).mintToken(msg.sender,PortfolioManagerprofit);
            for(uint256 i=0;i<TotalInvestorAddress.length;i++)
            {
                uint256 b = (invester[TotalInvestorAddress[i]][msg.sender].TokenCount.mul((dividendToken.sub(PortfolioManagerprofit)))).div(InvestersTotalToken);
                // FundToken(contractAddress).mintToken(TotalInvestorAddress[i],b);
                FundToken(contractAddress).transferFrom(msg.sender,TotalInvestorAddress[i],b);
            }
            
        }
        function ReturnTokenToPortfolioManager(address _add_,uint256 value)public payable
        {
             uint  TR;
            FundToken(contractAddress).transferFrom(msg.sender,_add_,value);
            TR = value.mul(0.1 ether);
           uint256 commissionForDmf= commissionForDmf.add((TR.mul(10)).div(100));
        
            takecommission = takecommission.add((commissionForDmf.div(1 ether)));
            Portfolio[_add_].commissionForPortfolio = Portfolio[_add_].commissionForPortfolio.add((TR.mul(10)).div(100)); 
            uint256 a= (TR.sub(commissionForDmf.add(Portfolio[_add_].commissionForPortfolio))).add(commissionForDmf);
            _add_.transfer(Portfolio[_add_].commissionForPortfolio);
            (msg.sender).transfer(a);
            invester[msg.sender][_add_].Eth= invester[msg.sender][_add_].Eth.sub(TR);
        }
        
        function purchaseToken(address buyToken,uint256 amountoftoken) public payable{
           transfertoken(buyToken,msg.sender,amountoftoken);
           buyToken.transfer(amountoftoken.mul(0.1 ether));
        }
        function transfertoken(address _token,address _to,uint _amt) public payable {
        ERC20(_token).transferFrom(msg.sender,_to,_amt);
    }
     

//Function For Many PortfolioManager Details
        function values() public view returns(uint256,uint256)
        {
            return (ToatlportfolioMAddress.length,TotalInvestorAddress.length);
        }
        function Investercount(address a) public view returns(uint256){
            return Portfolio[a].investerAddressForPortfolio.length;
        }
        function  portfoliocount(address a) public view returns(uint256){
            return (Investment[a].PortfolioHolders.length);
        }

        function InvesterList(address a,uint256 i)public view returns(address){
            
            return Portfolio[a].investerAddressForPortfolio[i];
            
        }
        function PortfolioList(address a,uint256 i)public view returns(address){
           return Investment[a].PortfolioHolders[i];
        }
}                                                                                                            
