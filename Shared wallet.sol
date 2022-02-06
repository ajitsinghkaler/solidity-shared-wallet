// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable{
    mapping(address => uint) public allowanceMapping;

    function addAllowanceUser(address _user, uint _value) public onlyOwner {
        allowanceMapping[_user] = _value;
    }

    modifier allownaceOrOwner(uint _amount){
        require(owner() == msg.sender || allowanceMapping[msg.sender] >=_amount, "the specified requst cannot be fulfilled");
        _;
    }

    function reduceAllowance(address _allowanceUser, uint _allowanceUsed) internal{
        allowanceMapping[_allowanceUser] -= _allowanceUsed;
    }
}

contract SharedWallet is Allowance {
    

    function withdraw(address payable _to, uint _value) public allownaceOrOwner(_value) {
        require(_value <= address(this).balance, "There are not enough funds in the contract");
        if(owner() != msg.sender){
            reduceAllowance(msg.sender, _value);
        }
        _to.transfer(_value);
    }

    fallback() external { }

    receive() external payable { }
}