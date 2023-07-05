// SPDX-FileCopyrightText: 2021 ShardLabs
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

/// @title Polygon validator share interface.
/// @dev https://github.com/maticnetwork/contracts/blob/v0.3.0-backport/contracts/staking/validatorShare/ValidatorShare.sol
/// @author 2021 ShardLabs
interface IValidatorShare {
    struct DelegatorUnbond {
        uint256 shares;
        uint256 withdrawEpoch;
    }

    function unbondNonces(address _address) external view returns (uint256);

    function activeAmount() external view returns (uint256);

    function validatorId() external view returns (uint256);

    function withdrawExchangeRate() external view returns (uint256);

    function withdrawRewards() external;

    function unstakeClaimTokens() external;

    function minAmount() external view returns (uint256);

    function getLiquidRewards(address user) external view returns (uint256);

    function delegation() external view returns (bool);

    function updateDelegation(bool _delegation) external;

    function buyVoucher(uint256 _amount, uint256 _minSharesToMint)
        external
        returns (uint256);

    function sellVoucher_new(uint256 claimAmount, uint256 maximumSharesToBurn)
        external;

    function unstakeClaimTokens_new(uint256 unbondNonce) external;

    function unbonds_new(address _address, uint256 _unbondNonce)
        external
        view
        returns (DelegatorUnbond memory);

    function getTotalStake(address user)
        external
        view
        returns (uint256, uint256);

    function owner() external view returns (address);

    function restake() external returns (uint256, uint256);

    function unlock() external;

    function lock() external;

    function drain(
        address token,
        address payable destination,
        uint256 amount
    ) external;

    function slash(uint256 _amount) external;

    function migrateOut(address user, uint256 amount) external;

    function migrateIn(address user, uint256 amount) external;

    function exchangeRate() external view returns (uint256);
}
