pragma solidity ^0.6.11;

import "../../upgrades/@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

interface IFETH is IERC20 {

    function mint(address account, uint256 shares, uint256 sent) external;

    function updateReward(uint256 newReward) external returns (uint256);

    function lockShares(address account, uint256 shares) external;

    function lockSharesFor(address spender, address account, uint256 shares) external;

    function unlockShares(uint256 shares) external;

    function unlockSharesFor(address account, uint256 shares) external;

    function sharesToBonds(uint256 amount) external view returns (uint256);

    function bondsToShares(uint256 amount) external view returns (uint256);
}
