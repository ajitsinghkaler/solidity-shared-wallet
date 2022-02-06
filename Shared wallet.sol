pragma solidity 0.6.0;

contract SharedWallet {
    address owner;
    constructor() public {
        owner = msg.sender;
    }
    mapping(address => bool) public allowanceMapping;



    function getMyBalance() public view returns (uint) {
        return address(this).balance; 
    }

    function addAllowanceUser(address user) public {
        require(msg.sender == owner, "You are not the owner only owner can add allowance user");
        allowanceMapping[user] = true;
    }

    function withdrawAllowance() public{
        require( allowanceMapping[msg.sender], "You are not registered by owner for allowance");
        payable(msg.sender).transfer(1 ether);

    }

    function withdraw(uint _ethValue, address payable _withdrawAddress) public {
        require(msg.sender == owner, "You are not the owner only owner can withdraw");
        _withdrawAddress.transfer(_ethValue);
    }

    fallback() external { }

    receive() external payable { }
}