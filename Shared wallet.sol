// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./Allowance.sol";

contract SharedWallet is Allowance {

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyRecieved(address indexed _from, uint _amount);
    

    function withdraw(address payable _to, uint _value) public allownaceOrOwner(_value) {
        require(_value <= address(this).balance, "There are not enough funds in the contract");
        if(owner() != msg.sender){
            reduceAllowance(msg.sender, _value);
        }
        emit MoneySent(_to, _value);
        _to.transfer(_value);
    }

    fallback() external { }

    receive() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }
}