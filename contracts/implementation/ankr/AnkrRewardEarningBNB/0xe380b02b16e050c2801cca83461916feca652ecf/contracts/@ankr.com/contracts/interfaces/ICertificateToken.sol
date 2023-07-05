// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

import "../../../@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";

interface ICertificateToken is IERC20Upgradeable {

    function sharesToBonds(uint256 amount) external view returns (uint256);

    function bondsToShares(uint256 amount) external view returns (uint256);

    function ratio() external view returns (uint256);

    function isRebasing() external pure returns (bool);

    function mint(address account, uint256 amount) external;

    function burn(address account, uint256 amount) external;
}