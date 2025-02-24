// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Farm {

    address depositTokenAdd;
    address rewardTokenAdd;
    uint public rewardRate = 100;

    mapping (address user => uint balance) balances;
    mapping (address user => uint time) timeOfLastDeposit;

    event Deposit(address indexed user, uint amount);
    event Harvest(address indexed user, uint amount);

    constructor(address depositTokenAddress, address rewardTokenAddress) {
        require(depositTokenAddress != address(0), "Invalid deposit token");
        require(rewardTokenAddress != address(0), "Invalid reward token");
        depositTokenAdd = depositTokenAddress;
        rewardTokenAdd = rewardTokenAddress;
    }

    function deposit(uint amount) external {

        ERC20 depositToken = ERC20(depositTokenAdd);

        // address(this) contract address 
        depositToken.transfer(address(this), amount);

        balances[msg.sender] += amount;
        // balances[msg.sender] = balances[msg.sender] + amount;
        timeOfLastDeposit[msg.sender] = block.timestamp;

        emit Deposit(msg.sender, amount);
    }

    function harvest() external{
        // grab the user balance
        uint depositBal = balances[msg.sender];
        uint timePassed = block.timestamp - timeOfLastDeposit[msg.sender];
        uint amount = timePassed * rewardRate * depositBal;
        
        ERC20 rewardToken = ERC20(rewardTokenAdd);

        rewardToken.transferFrom(address(this), msg.sender, amount);

        emit Harvest(msg.sender, amount);
    }

    

}
