pragma solidity ^0.4.0;
import "./PortfolioRegistration.sol";
import "./Time.sol";
contract InvestorsModule is PortfolioRegistration{
    address owner;
    uint time;
    uint[] Date;
    uint[] Month;
    uint[] Year;
    using DateTime for uint256;
    struct InvestorDetails{
        address[] UserAddr;
        string[] name;
        string[] password;
        uint[] count;
    }
    mapping(address=>InvestorDetails)InvesMap;
    function InvestorsModule(){
        owner=msg.sender;
    }
    function ListofPortfolioManager() public view returns(address[]) {
        return PortfolioManagerList();
    }
    function SelectProfolioManager(address search) public returns(bool){
        for(uint i=0;i<ListPortfolio.length;i++){
            if(search == ListPortfolio[i]){
               return true; 
            }
        }
    }
    function Investment(address _PortfolioAddr,string _name, string _password) public payable returns(bool){
        InvesMap[msg.sender].UserAddr.push(msg.sender);
        InvesMap[msg.sender].name.push(_name);
        InvesMap[msg.sender].password.push(_password);
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
    function getDate() private{
        Date.push(DateTime.getDay(time));
        Month.push(DateTime.getMonth(time));
        Year.push(DateTime.getYear(time));
    }
    function GetInvestorsDetails(address _UserAddr)public returns(string,uint,uint,uint,uint) {
        for(uint i=0;i<InvesMap[_UserAddr].name.length;i++){
            return (InvesMap[_UserAddr].name[i],InvesMap[_UserAddr].count[i],Date[i],Month[i],Year[i]);  
        }
    }
}