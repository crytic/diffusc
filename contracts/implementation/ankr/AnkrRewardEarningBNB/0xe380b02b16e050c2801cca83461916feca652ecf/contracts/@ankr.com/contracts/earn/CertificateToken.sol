// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

import "../../../@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../../@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

import "../libs/MathUtils.sol";

import "../interfaces/ICertificateToken.sol";
import "../interfaces/ILiquidTokenStakingPool.sol";
import "../interfaces/IStakingConfig.sol";
import "../interfaces/IInternetBondRatioFeed.sol";
import "../interfaces/IEarnConfig.sol";
import "../interfaces/IPausable.sol";

contract CertificateToken is
    OwnableUpgradeable,
    ERC20Upgradeable,
    ICertificateToken,
    IPausable
{
    event LiquidStakingPoolChanged(address prevValue, address newValue);
    event InternetBondRatioFeedChanged(address prevValue, address newValue);

    ILiquidTokenStakingPool internal _liquidStakingPool;
    IInternetBondRatioFeed internal _internetBondRatioFeed;

    // earn config
    IEarnConfig internal _earnConfig;

    // pausable
    bool private _paused;

    // reserve some gap for the future upgrades
    uint256[100 - 4] private __reserved;

    function initialize(
        IEarnConfig earnConfig,
        string memory name,
        string memory symbol
    ) external initializer {
        __Ownable_init();
        __ERC20_init(name, symbol);
        __CertificateToken_init(earnConfig);
    }

    function __CertificateToken_init(IEarnConfig earnConfig) internal {
        _earnConfig = earnConfig;
    }

    modifier onlyGovernance() virtual {
        require(
            msg.sender == _earnConfig.getGovernanceAddress(),
            "CertificateToken: only governance allowed"
        );
        _;
    }

    modifier onlyConsensus() virtual {
        require(
            msg.sender == _earnConfig.getConsensusAddress(),
            "CertificateToken: only consensus allowed"
        );
        _;
    }

    modifier onlyLiquidStakingPool() virtual {
        require(
            msg.sender == address(_liquidStakingPool),
            "CertificateToken: only liquid staking pool"
        );
        _;
    }

    modifier onlyInternetBondRatioFeed() virtual {
        require(
            msg.sender == address(_internetBondRatioFeed),
            "CertificateToken: only internet bond ratio feed"
        );
        _;
    }

    modifier whenNotPaused() virtual {
        require(!paused(), "CertificateToken: paused");
        _;
    }

    modifier whenPaused() virtual {
        require(paused(), "CertificateToken: not paused");
        _;
    }

    function setLiquidStakingPool(address newValue) external onlyGovernance {
        address prevValue = address(_liquidStakingPool);
        _liquidStakingPool = ILiquidTokenStakingPool(newValue);
        emit LiquidStakingPoolChanged(prevValue, newValue);
    }

    function setInternetBondRatioFeed(
        address newValue
    ) external onlyGovernance {
        address prevValue = address(_internetBondRatioFeed);
        _internetBondRatioFeed = IInternetBondRatioFeed(newValue);
        emit InternetBondRatioFeedChanged(prevValue, newValue);
    }

    function transfer(
        address to,
        uint256 amount
    )
        public
        virtual
        override(ERC20Upgradeable, IERC20Upgradeable)
        whenNotPaused
        returns (bool)
    {
        address ownerAddress = _msgSender();
        _transfer(ownerAddress, to, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    )
        public
        virtual
        override(ERC20Upgradeable, IERC20Upgradeable)
        whenNotPaused
        returns (bool)
    {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function approve(
        address spender,
        uint256 amount
    )
        public
        virtual
        override(ERC20Upgradeable, IERC20Upgradeable)
        whenNotPaused
        returns (bool)
    {
        address ownerAddress = _msgSender();
        _approve(ownerAddress, spender, amount);
        return true;
    }

    function mint(
        address account,
        uint256 amount
    ) external override whenNotPaused onlyLiquidStakingPool {
        _mint(account, amount);
    }

    function burn(
        address account,
        uint256 amount
    ) external override whenNotPaused onlyLiquidStakingPool {
        _burn(account, amount);
    }

    function sharesToBonds(
        uint256 amount
    ) public view override returns (uint256) {
        return MathUtils.multiplyAndDivideCeil(amount, 1 ether, ratio());
    }

    function bondsToShares(
        uint256 amount
    ) public view override returns (uint256) {
        return MathUtils.multiplyAndDivideFloor(amount, ratio(), 1 ether);
    }

    function ratio() public view override returns (uint256) {
        return _internetBondRatioFeed.getRatioFor(address(this));
    }

    function isRebasing() external pure override returns (bool) {
        return false;
    }

    function paused() public view returns (bool) {
        return _paused;
    }

    function pause() external whenNotPaused onlyGovernance {
        _paused = true;
        emit Paused(_msgSender());
    }

    function unpause() external whenPaused onlyGovernance {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}
