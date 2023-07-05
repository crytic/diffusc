pragma solidity ^0.6.11;

interface IStaking {
    function compensateLoss(address provider, uint256 ethAmount) external returns (bool, uint256, uint256);

    function freeze(address user, uint256 amount) external returns (bool);

    function unfreeze(address user, uint256 amount) external returns (bool);

    function frozenStakesOf(address staker) external view returns (uint256);

    function lockedDepositsOf(address staker) external view returns (uint256);

    function stakesOf(address staker) external view returns (uint256);

    function frozenDepositsOf(address staker) external view returns (uint256);

    function depositsOf(address staker) external view returns (uint256);

    function deposit() external;

    function deposit(address user) external;
}
