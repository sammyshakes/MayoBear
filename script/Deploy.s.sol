// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {MayoBear} from "../src/MayoBear.sol";

contract Deploy is Script {
    function setUp() public {}

    uint256 deployerPrivateKey = uint256(vm.envBytes32("DEPLOYER_PRIVATE_KEY"));

    function run() public {
        vm.startBroadcast(deployerPrivateKey);
        new MayoBear();

        console2.log("MayoBear deployed");

        vm.stopBroadcast();
    }
}
