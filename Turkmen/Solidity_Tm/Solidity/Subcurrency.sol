// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract Coin {
    // "public" açar söz üýtgeýjileri döredýär.
    // beýleki şertnamalardan alyp bolýar.
    address public minter;
    mapping (address => uint) public balances;

    // Events, müşderilere jikme-jikliklere reaksiýa bildirmäge mümkinçilik berýär.
    // yglan edýän şertnama üýtgetmeler.
    event Sent(address from, address to, uint amount);

    // Konstruktor kody diňe şertnama baglaşylanda işleýär 
    // we döredilyar
    constructor() {
        minter = msg.sender;
    }

    // Täze döredilen mukdarda adrese pul iberýär.
    // Diňe şertnamany döreden adam çagyryp biler.
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // Yalnyşlar barada maglumat bermäge mümkinçilik berýär
    // operasiýa näme üçin şowsuz boldy. Yzyna gaýtaryldy
    // funksiýany çagyrýan adama.
    error InsufficientBalance ( uint requested, uint available);

    // Bar bolan mukdarda pul iberýär.
    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
