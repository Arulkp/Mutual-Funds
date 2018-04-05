pragma solidity ^0.4.18;
import "./ERC20.sol";
contract Mam1 is ERC20Basic
{
    
    string public name;
    string public symbol;
    uint256 public totalsupply;
    uint256  initialallowed;
    uint256 public decimals;
    uint256 rate = 0.1 ether;
    address Owner;
    address public newadd;
    
    

    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint256))public allowed;

    function Mam1()public
    {
        totalsupply=100000;
        
        symbol= "FETX";
        name= "DostrixToken";
        initialallowed=500;
        decimals= 0;
        Owner = msg.sender;
         newadd=address(this);
        
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
        //require(value<=balanceOf[msg.sender]);
       // balanceOf[Owner]=balanceOf[Owner]-value;
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
    
    
    function () public payable
    {
        uint256 tokens = msg.value / rate;
        transfer(msg.sender,tokens);
    }
    
   
   

   //Omitting

   function DisplayTotalsupply() public view returns(uint256)
   {
       return  totalsupply;
   }

   function DisplayDecimal() public view returns(uint256)
   {
       return decimals;
   }
   function DisplaytheRate() public view returns(uint256)
   {
       return rate;
   }

   function DisplayBalance(address _addr) public view returns(uint256)
   {
       return balanceOf[_addr];
   }
   
   function DisplayTheAddress() public view returns(address)
   {
       return newadd;
   }
   
     function GetBal()public view returns(uint256){
          return this.balance/ 1 ether;
         // 1 ether; //converting wei value to ether
      }
  
   
}