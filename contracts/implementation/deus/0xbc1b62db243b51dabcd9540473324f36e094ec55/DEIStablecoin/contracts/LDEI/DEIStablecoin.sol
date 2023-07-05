// SPDX-License-Identifier: GPLv3
pragma solidity 0.8.4;

import "./@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./LERC20Upgradable.sol";

/**
 * @title DEI Stablecoin
 * @author DEUS Finance
 * @notice Multichain stablecoin
 */
contract DEIStablecoin is
    Initializable,
    LERC20Upgradable,
    AccessControlUpgradeable
{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    function initialize(
        uint256 totalSupply,
        address admin,
        address recoveryAdmin,
        uint256 timelockPeriod,
        address lossless
    ) public initializer {
        __LERC20_init(
            totalSupply,
            "DEI",
            "DEI",
            admin,
            recoveryAdmin,
            timelockPeriod,
            lossless
        );
        __AccessControl_init();
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }
}
