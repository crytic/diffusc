// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.16;

interface IBinancePool {
    /**
     * Events
     */

    event isRebasing(bool isRebasing);

    event Staked(
        address indexed delegator,
        address intermediary,
        uint256 amount
    );
    event UnstakePending(address indexed claimer, uint256 amount);
    event RewardsDistributed(
        address[] claimers,
        uint256[] amounts,
        uint256 missing /* total amount of claims still waiting to be served*/
    );

    event ManualDistributeExpected(
        address indexed claimer,
        uint256 amount,
        uint256 indexed id
    );

    event MinimalStakeChanged(uint256 minStake);
    event PendingGapReseted();

    event BondContractChanged(address indexed bondContract);
    event CertContractChanged(address indexed bondContract);
    event IntermediaryChanged(address indexed intermediary);
    event TokenHubChanged(address indexed tokenHub);
    event DistributeGasLeftChanged(uint256 gasLeft);
    event ReferralCode(uint256 code);

    event Received(address indexed from, uint256 amount);

    event FailedStakesWithdrawn(uint256 amount);

    function stake() external payable;

    function unstake(uint256 amount) external;

    function distributeManual(uint256 wrId) external;

    function distributeRewards() external payable;

    function pendingUnstakesOf(address account) external returns (uint256);

    function getMinimumStake() external view returns (uint256);

    function getRelayerFee() external view returns (uint256);

    function stakeAndClaimBonds() external payable;

    function stakeAndClaimBondsWithCode(uint256 code) external payable;

    function stakeAndClaimCerts() external payable;

    function stakeAndClaimCertsWithCode(uint256 code) external payable;

    function unstakeBonds(uint256 amount) external;

    function unstakeCerts(uint256 shares) external;

    function unstakeCertsFor(address recipient, uint256 shares) external;

    function unstakeBondsFor(address recipient, uint256 shares) external;
}
