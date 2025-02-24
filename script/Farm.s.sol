// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Farm.sol";
import "../src/Token.sol";

contract FarmScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy mock tokens first (for testing)
        Token depositToken = new Token("Deposit Token", "DT");
        Token rewardToken = new Token("Reward Token", "RT");

        // Deploy Farm contract
        Farm farm = new Farm(address(depositToken), address(rewardToken));

        vm.stopBroadcast();
    }
}