// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.6;

interface IBondToken_R1 {
    /**
     * Events
     */

    event RatioUpdated(uint256 newRatio);
    event BinancePoolChanged(address indexed binancePool);
    event OperatorChanged(address indexed operator);
    event CertTokenChanged(address indexed certToken);
    event CrossChainBridgeChanged(address indexed crossChainBridge);

    event Locked(address indexed account, uint256 amount);
    event Unlocked(address indexed account, uint256 amount);

    function mintBonds(address account, uint256 amount) external;

    function burnBonds(address account, uint256 amount) external;

    function pendingBurn(address account) external view returns (uint256);

    function burnAndSetPending(address account, uint256 amount) external;

    function burnAndSetPendingFor(
        address owner,
        address account,
        uint256 amount
    ) external;

    function updatePendingBurning(address account, uint256 amount) external;

    function ratio() external view returns (uint256);

    function lockShares(uint256 shares) external;

    function lockSharesFor(
        address spender,
        address account,
        uint256 shares
    ) external;

    function transferAndLockShares(address account, uint256 shares) external;

    function unlockShares(uint256 shares) external;

    function unlockSharesFor(address account, uint256 bonds) external;

    function totalSharesSupply() external view returns (uint256);

    function sharesToBonds(uint256 amount) external view returns (uint256);

    function bondsToShares(uint256 amount) external view returns (uint256);

    function isRebasing() external returns (bool);
}
