// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ManagerContract {
    uint public _goldPrice;
 
    constructor(uint goldPrice){
        _goldPrice = goldPrice;
    }

    function updatePrice(uint newPrice) public {
        _goldPrice = newPrice;
    }

    mapping(address => mapping(uint => bool)) buyers;

    function sendFunds() payable public{
        (bool sent, bytes memory data) = payable(address(this)).call{value: msg.value}("");
        require(sent, "Payment failed");
    }

    function purchaseGold(uint grams) public payable {
        uint price = _goldPrice * grams;
        require(msg.value >= price, "Balance insufficient"); 
        sendFunds();
        buyers[msg.sender][grams] = true;
    }

    function sellGold(uint grams) payable public{
        require(buyers[msg.sender][grams], "Have no purchased gold");
        uint price = _goldPrice * grams;
        (bool sent, bytes memory data) = payable(msg.sender).call{value: price }("");
        require(sent, "Failed");
    }

}
