// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/MayoBear.sol";

contract Burn is Script {
    MayoBear public mayobear;

    uint256 burnAmount = 201_000_000 ether;
    address public deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
    address public burnAddress = 0x000000000000000000000000000000000000dEaD;

    function run() external {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("DEPLOYER_PRIVATE_KEY"));
        mayobear = MayoBear(payable(0x3f6c91d57aa4A115346c84aa13e67f33379CD762)); //Mainnet

        vm.startBroadcast(deployerPrivateKey);

        uint256 deployerbalance = mayobear.balanceOf(deployerAddress);
        // mayobear.approve(address(this), deployerbalance);

        mayobear.transfer(burnAddress, burnAmount);

        vm.stopBroadcast();
    }
}
