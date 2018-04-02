pragma solidity ^0.4.18;
import "./ERC20.sol";
contract MarketToken is ERC20Basic
{
    
    string public name;
    string public symbol;
    uint256 public totalsupply;
    uint256  initialallowed;
    uint256 public decimals;
    uint256 rate = 0;
    address Owner;

    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint256))public allowed;

    function MarketToken(string _sym,string _name,uint256 _decimal,uint256 _ether)public
    {
        totalsupply=100000;
        balanceOf[msg.sender]=totalsupply;
        symbol= _sym;
        name= _name;
        initialallowed=500;
        decimals= _decimal;
        Owner = msg.sender;
        rate = _ether;
        
    }
    function transferFrom(address from, address to, uint256 value)public returns(bool) 
    {
        //require(to != address(0));
       //require(value <= balanceOf[from]);
        //require(value <= allowed[from][msg.sender]);
    
        balanceOf[from]=balanceOf[from]-value;
        balanceOf[to] =balanceOf[to]+value;
        //allowed[from][msg.sender] = allowed[from][msg.sender]-(value);
        Transfer(from,to,value);
        return true;
    }
    
    function allowance(address _owner, address _to) public view returns (uint256) 
    {
        return allowed[_owner][_to];
    }
    function increaseApproval(address _to, uint value) public returns(bool)
    {
        allowed[msg.sender][_to]=allowed[msg.sender][_to]+(value);
        return true;
    }
    function decreaseApproval(address _to, uint value) public returns(bool)
    {
        allowed[msg.sender][_to]=allowed[msg.sender][_to]-(value);
        return true;
    }
    function approve(address spender, uint256 value) public returns (bool)
    {
        allowed[msg.sender][spender]=value;
        return true;
    }
    
    function transfer(address to, uint256 value) public returns (bool)
    {
        require(value<=balanceOf[msg.sender]);
        balanceOf[msg.sender]=balanceOf[msg.sender]-value;
        balanceOf[to]=balanceOf[to]+value;
        Transfer(msg.sender,to,value);
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
    
    
        function buytokens() public payable {
       
     //calculate the tokens per rate form user entered amount
     uint256 tokens = msg.value / rate;
    // Tokens are minted by following way
    balanceOf[msg.sender] = balanceOf[msg.sender] + tokens;
    totalsupply = totalsupply + tokens * 2;
    balanceOf[Owner] = balanceOf[Owner] - tokens;
    Owner.transfer(msg.value);
    Transfer(0,msg.sender,msg.value);

    
   }
}