// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    mapping(address => uint) public allowanceMapping;

    function addAllowanceUser(address _user, uint _value) public onlyOwner {
        allowanceMapping[_user] = _value;
    }

    modifier allownaceOrOwner(uint _amount){
        require(owner() == _msgSender() || allowanceMapping[_msgSender()] >=_amount, "the specified requst cannot be fulfilled");
        _;
    }

    function withdraw(address payable _to, uint _value) public allownaceOrOwner(_value) {
        _to.transfer(_value);
        
    }

    fallback() external { }

    receive() external payable { }
}