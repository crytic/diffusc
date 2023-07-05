// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.11;

import "./Governable.sol";

contract SystemParameters is Governable {

    // Minimum ankr staking amount to be abel to initialize a pool
    uint256 public PROVIDER_MINIMUM_STAKING;

    // Minimum staking amount for pool participants
    uint256 public REQUESTER_MINIMUM_POOL_STAKING; // 0.1 ETH

    // Ethereum staking amount
    uint256 public ETHEREUM_STAKING_AMOUNT;

    uint256 public EXIT_BLOCKS;

    function initialize() external initializer {
        PROVIDER_MINIMUM_STAKING = 100000 ether;
        REQUESTER_MINIMUM_POOL_STAKING = 500 finney;
        ETHEREUM_STAKING_AMOUNT = 4 ether;
        EXIT_BLOCKS = 24;
    }
}