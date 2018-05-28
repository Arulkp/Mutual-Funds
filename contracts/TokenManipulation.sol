pragma solidity ^0.4.18;
import "./ERC20.sol";
contract Token{
    
    function totalSupplytoken(address _token) public view returns(uint){
        return ERC20(_token).totalSupply();
    }
    
    function balanceOftoken(address _token) public view returns(uint){
        return ERC20(_token).balanceOf(msg.sender);
    }
    
    // before this You need to run approve function on your token contract...
    function transfertoken(address _token,address _to,uint _amt) public payable {
        ERC20(_token).transferFrom(msg.sender,_to,_amt);
    }
    
    function transfer(address _token,address _to,uint _amt) public payable {
        ERC20(_token).transfer(_to,_amt);
    }
    
}