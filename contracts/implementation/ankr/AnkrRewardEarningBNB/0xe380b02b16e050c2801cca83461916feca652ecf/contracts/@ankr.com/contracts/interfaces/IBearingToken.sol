// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

import "./ICertificateToken.sol";

interface IBearingToken is ICertificateToken {

    function lockShares(uint256 shares) external;

    function lockSharesFor(address account, uint256 shares) external;

    function unlockShares(uint256 shares) external;

    function unlockSharesFor(address account, uint256 shares) external;

    function totalSharesSupply() external view returns (uint256);
}