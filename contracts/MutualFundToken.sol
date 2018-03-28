pragma solidity ^0.4.18;
import "./ERC20Basic.sol";
contract MutualFund is ERC20Basic
{
   
    string public name;
    string public symbol;
    uint256 public totalsupply;
    //uint256  initialallowed;
    uint256 public decimals;
  
    address Owner;

    mapping(address=>uint) public balanceOf;
  

   
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
    
    
        
}