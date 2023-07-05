// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.16;

import "../@ankr.com/contracts/interfaces/IBearingToken.sol";

interface IBondToken is IBearingToken {
    /**
    //  * Events
    //  */

    event BinancePoolChanged(address prevValue, address newValue);

    // event Locked(address indexed account, uint256 amount);
    // event Unlocked(address indexed account, uint256 amount);

    // function transferAndLockShares(address account, uint256 shares) external;

    // function mintBonds(address account, uint256 amount) external;

    // function burnBonds(address account, uint256 amount) external;

    function pendingBurn(address account) external view returns (uint256);

    function burnAndSetPending(address account, uint256 amount) external;

    function burnAndSetPendingFor(
        address owner,
        address account,
        uint256 amount
    ) external;

    function updatePendingBurning(address account, uint256 amount) external;
}
