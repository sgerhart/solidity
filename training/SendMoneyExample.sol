// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract SendMoneyExample {

    uint public balanceReceived;
    uint public moneyBlocked;

    function receiveMoney() public payable {
        balanceReceived += msg.value;
        moneyBlocked = block.timestamp + 1 minutes;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getMoney() public {
        if(moneyBlocked < block.timestamp) {
            address payable to = payable(msg.sender);
            to.transfer(getBalance());
        }
    }


    function withdrawMoneyTo(address payable _to) public {
        if (moneyBlocked < block.timestamp) {
           _to.transfer(getBalance());
        }
    }
}