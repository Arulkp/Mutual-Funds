pragma solidity ^0.4.0;
import "./ERC2.sol";
contract PortfolioRegistration is MutualFund{
    address owner;
     string public name;
    string public symbol;
    uint256 public totalsupply;
    uint256 public decimals;
    address[] ListPortfolio;
    struct Reg{
        address[] EtherAcc;
        string[] name;
        bytes32[] password;
    }
    mapping(address=>Reg) RegMap;
    function PortfolioRegistration()public
    {
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    function Register(address _EtherAcc,string _name,bytes32 _password) public payable{
              if(_EtherAcc != owner && _EtherAcc.balance >=5 ether )
              RegMap[_EtherAcc].EtherAcc.push(_EtherAcc);
              ListPortfolio.push(_EtherAcc);
              RegMap[_EtherAcc].name.push(_name);
              RegMap[_EtherAcc].password.push(_password);
              owner.transfer(msg.value);
    }
    function FundTokenCreation(string _name,string _symbol,uint256 _decimals,uint256 _totalsupply)public{
        symbol= _symbol;
        name=_name;
        decimals= _decimals;
        totalsupply=_totalsupply;
        balanceOf[msg.sender]=totalsupply;
    }
    function PortfolioManagerList() public view returns(address[]){
        return ListPortfolio;
    }
}