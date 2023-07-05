// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

import "../../../@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../../@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

import "../libs/MathUtils.sol";

import "../interfaces/IBearingToken.sol";
import "../interfaces/ILiquidTokenStakingPool.sol";
import "../interfaces/IStakingConfig.sol";
import "../interfaces/IInternetBondRatioFeed.sol";
import "../interfaces/IEarnConfig.sol";
import "../interfaces/IPausable.sol";

contract BearingToken is
    OwnableUpgradeable,
    ERC20Upgradeable,
    IBearingToken,
    IPausable
{
    event LiquidStakingPoolChanged(address prevValue, address newValue);
    event InternetBondRatioFeedChanged(address prevValue, address newValue);
    event CertificateTokenChanged(address prevValue, address newValue);
    event BearingTokenLineReached(uint line);

    // other contract references
    ILiquidTokenStakingPool internal _liquidStakingPool;
    IInternetBondRatioFeed internal _internetBondRatioFeed;
    ICertificateToken internal _certificateToken;

    // earn config
    IEarnConfig internal _earnConfig;

    // re-defined ERC20 fields
    mapping(address => uint256) internal _shares;
    uint256 internal _totalSupply;

    // specific bond fields
    int256 internal _lockedShares;

    // pausable
    bool private _paused;

    // reserve
    uint256[100 - 8] private __reserved;

    function initialize(
        IEarnConfig earnConfig,
        string memory name,
        string memory symbol
    ) external initializer {
        __Ownable_init();
        __ERC20_init(name, symbol);
        __BearingToken_init(earnConfig);
    }

    function __BearingToken_init(IEarnConfig earnConfig) internal {
        _earnConfig = earnConfig;
    }

    modifier onlyGovernance() virtual {
        require(
            msg.sender == _earnConfig.getGovernanceAddress(),
            "BearingToken: only governance allowed"
        );
        _;
    }

    modifier onlyConsensus() virtual {
        require(
            msg.sender == _earnConfig.getConsensusAddress(),
            "BearingToken: only consensus allowed"
        );
        _;
    }

    modifier onlyLiquidStakingPool() virtual {
        emit BearingTokenLineReached(79);
        require(
            msg.sender == address(_liquidStakingPool),
            "BearingToken: only liquid staking pool"
        );
        _;
    }

    modifier onlyInternetBondRatioFeed() virtual {
        require(
            msg.sender == address(_internetBondRatioFeed),
            "BearingToken: only internet bond ratio feed"
        );
        _;
    }

    modifier whenNotPaused() virtual {
        emit BearingTokenLineReached(96);
        require(!paused(), "BearingToken: paused");
        _;
    }

    modifier whenPaused() virtual {
        require(paused(), "BearingToken: not paused");
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

    function setCertificateToken(address newValue) external onlyGovernance {
        address prevValue = address(_certificateToken);
        _certificateToken = ICertificateToken(newValue);
        emit CertificateTokenChanged(prevValue, newValue);
    }

    function mint(
        address account,
        uint256 shares
    ) external override whenNotPaused onlyLiquidStakingPool {
        emit BearingTokenLineReached(130);
        _mint(account, shares);
    }

    function burn(
        address account,
        uint256 shares
    ) external override whenNotPaused onlyLiquidStakingPool {
        _burn(account, shares);
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

    function isRebasing() public pure override returns (bool) {
        return true;
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

    function lockShares(uint256 shares) external override whenNotPaused {
        address treasury = _earnConfig.getTreasuryAddress();
        uint16 swapFeeRatio = _earnConfig.getSwapFeeRatio();
        // transfer tokens from aETHc to aETHb
        require(
            _certificateToken.transferFrom(msg.sender, address(this), shares),
            "BearingToken: can't transfer"
        );
        // calc swap fee
        uint256 fee = (shares * swapFeeRatio) / 1e4;
        if (msg.sender == treasury) {
            fee = 0;
        }
        uint256 sharesWithFee = shares - fee;
        if (fee > 0) {
            _mint(treasury, fee);
        }
        _mint(msg.sender, sharesWithFee);
    }

    function lockSharesFor(
        address account,
        uint256 shares
    ) external override whenNotPaused onlyLiquidStakingPool {
        require(
            _certificateToken.transferFrom(account, address(this), shares),
            "BearingToken: failed to transfer"
        );
        _mint(account, shares);
    }

    function unlockShares(uint256 shares) external override whenNotPaused {
        address treasury = _earnConfig.getTreasuryAddress();
        uint16 swapFeeRatio = _earnConfig.getSwapFeeRatio();
        // calc swap fee
        uint256 fee = (shares * swapFeeRatio) / 1e4;
        if (msg.sender == treasury) {
            fee = 0;
        }
        uint256 sharesWithFee = shares - fee;
        if (fee > 0) {
            _transfer(msg.sender, treasury, sharesToBonds(fee));
        }
        _burn(msg.sender, sharesWithFee);
        // transfer tokens
        require(
            _certificateToken.transfer(msg.sender, sharesWithFee),
            "BearingToken: can't transfer"
        );
    }

    function unlockSharesFor(
        address account,
        uint256 shares
    ) external override whenNotPaused onlyLiquidStakingPool {
        _burn(account, shares);
        _certificateToken.transfer(account, shares);
    }

    function totalSupply()
        public
        view
        virtual
        override(ERC20Upgradeable, IERC20Upgradeable)
        returns (uint256)
    {
        uint256 supply = totalSharesSupply();
        return sharesToBonds(supply);
    }

    function totalSharesSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(
        address account
    )
        public
        view
        virtual
        override(ERC20Upgradeable, IERC20Upgradeable)
        returns (uint256)
    {
        return sharesToBonds(_shares[account]);
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
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        uint256 shares = bondsToShares(amount);
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        _beforeTokenTransfer(from, to, shares);
        uint256 fromBalance = _shares[from];
        require(
            fromBalance >= shares,
            "ERC20: transfer amount exceeds balance"
        );
        _shares[from] = fromBalance - shares;
        _shares[to] += shares;
        emit Transfer(from, to, amount);
        _afterTokenTransfer(from, to, shares);
    }

    function _mint(address account, uint256 shares) internal virtual override {
        // checks whether bearingToken is backed by _certificateToken
        require(
            _totalSupply + shares <= _certificateToken.balanceOf(address(this)),
            "BearingToken: not backed by certificateToken"
        );
        uint256 amount = sharesToBonds(shares);
        require(account != address(0), "ERC20: mint to the zero address");
        _beforeTokenTransfer(address(0), account, shares);
        _totalSupply += shares;
        _shares[account] += shares;
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, shares);
    }

    function _burn(address account, uint256 shares) internal virtual override {
        uint256 amount = sharesToBonds(shares);
        require(account != address(0), "ERC20: burn from the zero address");
        _beforeTokenTransfer(account, address(0), shares);
        uint256 accountBalance = _shares[account];
        require(accountBalance >= shares, "ERC20: burn amount exceeds balance");
        _shares[account] = accountBalance - shares;
        _totalSupply -= shares;
        emit Transfer(account, address(0), amount);
        _afterTokenTransfer(account, address(0), shares);
    }

    // Pausable

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
