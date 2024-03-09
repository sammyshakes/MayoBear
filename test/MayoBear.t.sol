// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/MayoBear.sol";

contract MayoBearTest is Test {
    MayoBear public mayoBear;
    IERC20 public paiToken;

    // dex router address
    // address public router = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    address public router = address(0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008);

    IDexRouter dexRouter = IDexRouter(router);

    address public owner = address(this);
    address public user1 = address(0x1);
    address public user2 = address(0x2);

    address public mayoLpPair;

    function setUp() public {
        // Deploy the MayoBear contract
        mayoBear = new MayoBear();
        paiToken = IERC20(0xa0Cc4428FbB652C396F28DcE8868B8743742A71c);

        // Verify the initial balance of the owner
        uint256 ownerBalance = mayoBear.balanceOf(address(this));
        assertEq(ownerBalance, 1e9 * 1e18);

        // Prepare by transferring some tokens to the user1 for testing transfers
        mayoBear.transfer(user1, 1_000_000 * 1e18);
        mayoBear.transfer(owner, 500_000_000 * 1e18);

        // Prepare by transferring some tokens to the lppair for testing transfers
        mayoBear.transfer(mayoBear.lpPair(), 1000 * 1e18);

        // deal ether to users
        vm.deal(user1, 1000 * 1e18);
        vm.deal(user2, 1000 * 1e18);
        vm.deal(owner, 1000 * 1e18);
    }

    //test buying tokens via dex
    function test_BuyTokens() public {
        mayoBear.enableTrading(0);

        //disable transfer delay
        mayoBear.removeLimits();

        //get user1 balance
        uint256 user1Balance = mayoBear.balanceOf(user1);

        uint256 user2Balance = mayoBear.balanceOf(user2);

        uint256 ownerBalance = mayoBear.balanceOf(address(this));

        uint256 lpPairBalance = mayoBear.balanceOf(mayoBear.lpPair());

        mayoBear.approve(address(dexRouter), 50_000_000 * 1e18);
        //owner adds liquidity via dex
        dexRouter.addLiquidityETH{value: 200e18}(
            address(mayoBear), 50_000_000e18, 40_000_000e18, 2e18, owner, block.timestamp + 15
        );

        //get user1 balance
        uint256 user1BalanceAfter = mayoBear.balanceOf(user1);

        address[] memory path = new address[](2);
        path[0] = dexRouter.WETH();
        path[1] = address(mayoBear);

        //user1 buys tokens via dex
        vm.prank(user1);
        dexRouter.swapExactETHForTokensSupportingFeeOnTransferTokens{value: 10e18}(
            0, // accept any amount of MayoBear
            path,
            user1,
            block.timestamp + 15
        );

        // check mayo bear tokens for pai buyback
        console2.log("=============================================");
        console2.log("PAI Back: ", mayoBear.tokensForPAIBuyback());
        console2.log("Liquidity: ", mayoBear.tokensForLiquidity());
        console2.log("marketing: ", mayoBear.tokensForMarketing());
        console2.log("oper: ", mayoBear.tokensForOperations());

        // user2 buys tokens via dex
        vm.prank(user2);
        dexRouter.swapExactETHForTokensSupportingFeeOnTransferTokens{value: 10e18}(
            0, // accept any amount of MayoBear
            path,
            user2,
            block.timestamp + 15
        );

        // check mayo bear tokens for pai buyback
        console2.log("=============================================");
        console2.log("PAI Back: ", mayoBear.tokensForPAIBuyback());
        console2.log("Liquidity: ", mayoBear.tokensForLiquidity());
        console2.log("marketing: ", mayoBear.tokensForMarketing());
        console2.log("oper: ", mayoBear.tokensForOperations());

        //user1 sells tokens via dex
        path[1] = dexRouter.WETH();
        path[0] = address(mayoBear);

        uint256 user1BalanceBefore = mayoBear.balanceOf(user1);
        uint256 user1EthBefore = address(user1).balance;

        vm.startPrank(user1);
        mayoBear.approve(address(dexRouter), user1BalanceBefore);
        dexRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            user1BalanceBefore,
            0, // accept any amount of ETH
            path,
            user1,
            block.timestamp + 15
        );
        vm.stopPrank();

        // check mayo bear tokens for pai buyback
        console2.log("=============================================");
        console2.log("PAI Back: ", mayoBear.tokensForPAIBuyback());
        console2.log("Liquidity: ", mayoBear.tokensForLiquidity());
        console2.log("marketing: ", mayoBear.tokensForMarketing());
        console2.log("oper: ", mayoBear.tokensForOperations());

        //user2 sells tokens via dex
        uint256 user2BalanceBefore = mayoBear.balanceOf(user2);
        uint256 user2EthBefore = address(user2).balance;

        vm.startPrank(user2);
        mayoBear.approve(address(dexRouter), user2BalanceBefore);
        dexRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            user2BalanceBefore,
            0, // accept any amount of ETH
            path,
            user2,
            block.timestamp + 15
        );
        vm.stopPrank();

        // check mayo bear tokens for pai buyback
        console2.log("=============================================");
        console2.log("PAI Back: ", mayoBear.tokensForPAIBuyback());
        console2.log("Liquidity: ", mayoBear.tokensForLiquidity());
        console2.log("marketing: ", mayoBear.tokensForMarketing());
        console2.log("oper: ", mayoBear.tokensForOperations());

        // user1 buys tokens via dex
        path[0] = dexRouter.WETH();
        path[1] = address(mayoBear);

        vm.prank(user1);
        dexRouter.swapExactETHForTokensSupportingFeeOnTransferTokens{value: 10e18}(
            0, // accept any amount of MayoBear
            path,
            user1,
            block.timestamp + 15
        );

        // check mayo bear tokens for pai buyback
        console2.log("=============================================");
        console2.log("PAI Back: ", mayoBear.tokensForPAIBuyback());
        console2.log("Liquidity: ", mayoBear.tokensForLiquidity());
        console2.log("marketing: ", mayoBear.tokensForMarketing());
        console2.log("oper: ", mayoBear.tokensForOperations());

        // user2 buys tokens via dex
        vm.prank(user2);
        dexRouter.swapExactETHForTokensSupportingFeeOnTransferTokens{value: 10e18}(
            0, // accept any amount of MayoBear
            path,
            user2,
            block.timestamp + 15
        );

        // check mayo bear tokens for pai buyback
        console2.log("=============================================");
        console2.log("PAI Back: ", mayoBear.tokensForPAIBuyback());
        console2.log("Liquidity: ", mayoBear.tokensForLiquidity());
        console2.log("marketing: ", mayoBear.tokensForMarketing());
        console2.log("oper: ", mayoBear.tokensForOperations());
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
        assertEq(mayoBear.maxBuyAmount(), 2_500_000 * 1e18);
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
        uint256 newMaxBuyAmount = 15_000_000;
        mayoBear.updateMaxBuyAmount(newMaxBuyAmount);
        assertEq(mayoBear.maxBuyAmount(), newMaxBuyAmount * 1e18);
    }
}
