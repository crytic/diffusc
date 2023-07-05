// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../@ankr.com/contracts/interfaces/ICertificateToken.sol";

interface ICertToken is ICertificateToken {
    event AirDropFinished();

    event BinancePoolChanged(address prevValue, address newValue);

    function balanceWithRewardsOf(address account) external returns (uint256);
}
