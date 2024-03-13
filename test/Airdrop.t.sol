// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/MayoBear.sol";

contract AirdropTest is Test {
    MayoBear public mayoBear;

    address public deployerAddress;

    address public mayoLpPair;

    function setUp() public {
        deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
        // Deploy the MayoBear contract
        mayoBear = MayoBear(payable(0x3f6c91d57aa4A115346c84aa13e67f33379CD762)); //Mainnet

        vm.prank(0x4871eAe23ECA5cE33ceff5e0366Ef5d585e13253);
        mayoBear.excludeFromFees(deployerAddress, true);
    }

    function testAirdrop() public {
        uint256 transferAmount = 3_738_235 ether;

        // Verify the initial balance of the owner
        uint256 deployerBalance = mayoBear.balanceOf(deployerAddress);

        mayoBear.approve(address(this), deployerBalance);

        vm.startPrank(deployerAddress);

        for (uint256 i; i < dropArray.length; i++) {
            mayoBear.transfer(dropArray[i], transferAmount);
        }

        vm.stopPrank();
    }

    address[] dropArray = [
        0xaB8C942C388c23A5F66b418347550E1E92123ba3,
        0x9B2Fd77dBF2AAF29f5a6eD885db6FD99bb74EAd6,
        0x25dDb625c18427eE3544613C7df88086e880E5e3,
        0x01F539c74cBb5463d4a75bCEE48C7B94C2bEc531,
        0x271c91BF067356Fa737EB2A78e218694954a2E99,
        0x1AB95d8689c4e03351c80CcA861d0ADf35368d9e,
        0xE1DBa24D7A83B4F0b25Df8f19DC94f90F201fDFA,
        0x100444c7D04A842D19bc3eE63cB7b96682FF3f43,
        0x0B0d524c560093949FC99201e032AF78373AbDd6,
        0xCC45e7e747e7285C9A45738c61Bf155946CC7aB2,
        0xCd10F8461077A014A38886347dFdD4a9ACd109e5,
        0x7b92AfF581099FFf3884aF90a5036346F747040B,
        0x3eCA742EC944dfA23985040d71f5e2DC546290E8,
        0x9c93437D08622b0aC83A7dD7F6125124448C3b0a,
        0xB84a30fB48f65063Ba7B013274F7d303c63f9f4a,
        0x7Fe5a3679f71987b3b23E683Cc8CCA3FdBA28235,
        0xd711B5F1DF62Fb91F8921aec68f670B04E84FdA7,
        0x64dCe143ae1bBFc6BdEee6Db50810337C0dCd260,
        0x8bAAb85939bd17f8F0b69EEac72e6D16A4000ad0,
        0x0E3802B04831cF0650239EA4Bc1895aAd7B0742A,
        0x992c96C0593a823e78B26c1b3471C806883471c2,
        0x7eF613b1B7e8b1D6a2f61ba3B0F2BCEF73B27bc1,
        0x0288aED2E6a103da7853eFc1e4027a87ac769f21,
        0x0E71668a349EF86913B9F25A683Dd74762231893,
        0x7182eE9406c495A62b09a93caa42E87CEC5EAc8B,
        0x066f031dec198b5230C49978F1385F67e6cC41F3,
        0x4C78e1e3B92923C9B814e47f6486a72d450Ec78e,
        0xe845a4960B3421217a72195BFdDd8611b8bc59E4,
        0x51A132Ea95A8d5103e9A463136D759824F268c09,
        0xa278eEfB6a2A3A005cc2d84373ffAc2c7eb2fcAe,
        0xfBD11faF9b01B0f6f0d3Cd312B76b2065B2CF709,
        0x8b233deA5C4a816b3b81F3d7f607AC68Ada54495,
        0xb3F91ca47F90046E5AC54241E422cDdbb105633B,
        0x4D437fEB60094B6fd2E18854622E093d738E273e
    ];
}
