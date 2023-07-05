// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ILiquidTokenStakingPool {
    event BearingTokenChanged(address prevValue, address newValue);

    event CertificateTokenChanged(address prevValue, address newValue);

    event MinimumStakeChanged(uint256 prevValue, uint256 newValue);

    event MinimumUnstakeChanged(uint256 prevValue, uint256 newValue);

    event Staked(
        address indexed staker,
        uint256 amount,
        uint256 shares,
        bool indexed isRebasing
    );

    event Unstaked(
        address indexed ownerAddress,
        address indexed receiverAddress,
        uint256 amount,
        uint256 shares,
        bool indexed isRebasing
    );

    event Received(address indexed from, uint256 value);

    function setBearingToken(address newValue) external;

    function setCertificateToken(address newValue) external;

    function setMinimumStake(uint256 newValue) external;

    function setMinimumUnstake(uint256 newValue) external;

    function stakeBonds() external payable;

    function stakeCerts() external payable;

    function getFreeBalance() external view returns (uint256);

    function getMinStake() external view returns (uint256);

    function getMinUnstake() external view returns (uint256);
}
