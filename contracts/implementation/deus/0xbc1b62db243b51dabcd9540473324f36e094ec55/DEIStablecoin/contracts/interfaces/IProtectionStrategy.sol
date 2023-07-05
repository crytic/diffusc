// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ProtectionStrategy {
    function isTransferAllowed(address token, address sender, address recipient, uint256 amount) external;
}