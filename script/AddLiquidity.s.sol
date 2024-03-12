// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {MayoBear} from "../src/MayoBear.sol";

interface IDexRouter {
    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external payable returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);
}

contract AddLiquidity is Script {
    IDexRouter dexRouter = IDexRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    MayoBear public mayoBear = MayoBear(payable(0xa0Cc4428FbB652C396F28DcE8868B8743742A71c));

    uint256 mayoTokenAmount = 11 ether;
    uint256 ethAmount = 11 ether;

    uint256 deployerPrivateKey = uint256(vm.envBytes32("DEPLOYER_PRIVATE_KEY"));

    function run() public {
        vm.startBroadcast(deployerPrivateKey);
        // approve token transfer to cover all possible scenarios
        mayoBear.approve(address(this), mayoTokenAmount);
        mayoBear.approve(address(dexRouter), mayoTokenAmount);

        // add the liquidity and burn the LP tokens
        dexRouter.addLiquidityETH{value: ethAmount}(
            address(mayoBear),
            mayoTokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(0xdead),
            block.timestamp
        );

        vm.stopBroadcast();
    }
}
