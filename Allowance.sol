// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable{
    event AllowanceAdded(address indexed _to, uint _value, uint _newValue);
    event AllowanceSent(address indexed _by, address indexed _to, uint _value);

    mapping(address => uint) public allowanceMapping;

    function addAllowanceUser(address _user, uint _value) public onlyOwner {
        emit AllowanceAdded(_user, _value, allowanceMapping[_user]);
        allowanceMapping[_user] = _value;
    }

    modifier allownaceOrOwner(uint _amount){
        require(owner() == msg.sender || allowanceMapping[msg.sender] >=_amount, "the specified requst cannot be fulfilled");
        _;
    }

    function reduceAllowance(address _allowanceUser, uint _allowanceUsed) internal{
        emit AllowanceSent(msg.sender ,_allowanceUser, _allowanceUsed);
        allowanceMapping[_allowanceUser] -= _allowanceUsed;
    }
}