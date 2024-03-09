// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Imports
import "forge-std/Script.sol";
import "../src/MultiSigWallet.sol";

contract DeployMultisig is Script {
    // Deployments
    MultiSigWallet public wallet;

    address public owner1 = vm.envAddress("MULTISIG_OWNER_1_ADDRESS");
    address public owner2 = vm.envAddress("MULTISIG_OWNER_2_ADDRESS");
    address public owner3 = vm.envAddress("MULTISIG_OWNER_3_ADDRESS");
    address public owner4 = vm.envAddress("MULTISIG_OWNER_4_ADDRESS");
    address public owner5 = vm.envAddress("MULTISIG_OWNER_5_ADDRESS");

    address public requiredConfirmationAddress =
        vm.envAddress("MULTISIG_REQUIRED_CONFIRMATION_ADDRESS");

    uint256 numComfirmations = vm.envUint("MULTISIG_REQUIRED_CONFIRMATIONS");

    function run() external {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("DEPLOYER_PRIVATE_KEY"));

        owner3 = address(0x3);

        address[] memory owners = new address[](5);
        owners[0] = owner1;
        owners[1] = owner2;
        owners[2] = owner3;
        owners[3] = owner4;
        owners[4] = owner5;

        //Deploy Tronic Master Contracts
        vm.startBroadcast(deployerPrivateKey);

        wallet = new MultiSigWallet(owners, requiredConfirmationAddress, numComfirmations);

        vm.stopBroadcast();
    }
}
