pragma solidity ^0.4.18;
import "./ERC20.sol";
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

    function FundToken()public
    {
        totalsupply=100000;
        balanceOf[msg.sender]=totalsupply;
        symbol="DTX";
        name="PheonixToken";
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
    function name() public constant returns(string){
        return name;
    }
    function symbol() public constant returns(string){
        return symbol;
    }
    

 function mintToken(address _add_,uint256 _amo) public
 {
     balanceOf[_add_] = balanceOf[_add_] + _amo;
 }
 //dDetails
 function tokenDecrease(address _add_,uint256 _amo) public payable
 {
     balanceOf[_add_] = balanceOf[_add_] - _amo;
 }
}