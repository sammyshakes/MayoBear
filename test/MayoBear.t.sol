// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/MayoBear.sol";

contract MayoBearTest is Test {
    MayoBear public mayoBear;
    IPAIToken public paiToken;

    // dex router address
    address public router = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    IDexRouter _dexRouter = IDexRouter(router);

    address public owner;
    address public user1 = address(0x1);
    address public user2 = address(0x2);

    address public mayoLpPair;

    function setUp() public {
        // Deploy the MayoBear contract
        mayoBear = new MayoBear();
        paiToken = IPAIToken(0xa0Cc4428FbB652C396F28DcE8868B8743742A71c);

        // Verify the initial balance of the owner
        uint256 ownerBalance = mayoBear.balanceOf(address(this));
        assertEq(ownerBalance, 1e9 * 1e18);

        // Prepare by transferring some tokens to the user1 for testing transfers
        mayoBear.transfer(user1, 1000 * 1e18);

        // Prepare by transferring some tokens to the lppair for testing transfers
        mayoBear.transfer(mayoBear.lpPair(), 1000 * 1e18);
    }

    // test all the initial values and public variables
    function test_InitialTokenValues() public {
        // Verify the initial values of the token
        assertEq(mayoBear.name(), "Mayo Bear");
        assertEq(mayoBear.symbol(), "MAYO");
        assertEq(mayoBear.decimals(), 18);
        assertEq(mayoBear.totalSupply(), 1e9 * 1e18);
        assertEq(mayoBear.owner(), address(this));
        assertEq(mayoBear.tradingActive(), false);
        assertEq(mayoBear.maxBuyAmount(), 2500000 * 1e18);
        assertEq(mayoBear.paiBuybackThreshold(), 1000 * 1e18);

        //console current block
        console.log(block.number);
    }

    function test_EnableTrading() public {
        // Initially, trading should not be active
        assertFalse(mayoBear.tradingActive());

        // Enable trading and verify
        mayoBear.enableTrading(2); // Enable trading after 2 blocks
        assertTrue(mayoBear.tradingActive());

        //get user1 balance
        uint256 user1Balance = mayoBear.balanceOf(user1);

        //attempt to trade

        vm.startPrank(mayoBear.lpPair());
        mayoBear.transfer(user1, 500 * 1e18); // Transfer some tokens

        vm.stopPrank();

        //get user1 balance
        uint256 user1BalanceAfter = mayoBear.balanceOf(user1);

        uint256 blockNumber = block.number;

        // Fast forward 2 blocks
        vm.roll(blockNumber + 3);

        // attempt to trade
        vm.startPrank(mayoBear.lpPair());
        mayoBear.transfer(user1, 500 * 1e18); // Transfer some tokens

        // Now trading should be active
        assertTrue(mayoBear.tradingActive());
    }

    function test_UpdateMaxBuyAmount() public {
        uint256 newMaxBuyAmount = 15000000;
        mayoBear.updateMaxBuyAmount(newMaxBuyAmount);
        assertEq(mayoBear.maxBuyAmount(), newMaxBuyAmount * 1e18);
    }
}
