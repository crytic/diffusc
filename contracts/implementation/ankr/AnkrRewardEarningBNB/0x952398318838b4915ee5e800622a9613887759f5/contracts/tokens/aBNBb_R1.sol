// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.16;

import "../@ankr.com/contracts/earn/BearingToken.sol";
import "../@ankr.com/contracts/interfaces/IEarnConfig.sol";

import "../interfaces/IBondToken.sol";

contract aBNBb_R1 is BearingToken, IBondToken {
    mapping(address => uint256) private _pendingBurn;
    uint256 public pendingBurnsTotal;
    // prev pool
    address internal _binancePool;

    modifier onlyLiquidStakingPool() override {
        require(
            msg.sender == address(_liquidStakingPool) ||
                msg.sender == address(_binancePool),
            "BearingToken: only liquid staking pool"
        );
        _;
    }

    function initialize(IEarnConfig earnConfig) external initializer {
        __Ownable_init();
        __ERC20_init("Ankr Reward Earning BNB", "aBNBb");
        __BearingToken_init(earnConfig);
    }

    // BinancePool specific functions

    function pendingBurn(address account) external view returns (uint256) {
        return _pendingBurn[account];
    }

    function burnAndSetPending(address account, uint256 amount)
        external
        override
        whenNotPaused
        onlyLiquidStakingPool
    {
        _pendingBurn[account] += amount;
        pendingBurnsTotal += amount;
        uint256 sharesToBurn = bondsToShares(amount);
        _burn(account, sharesToBurn);
        emit Transfer(account, address(0), amount);
    }

    function burnAndSetPendingFor(
        address ownerAddress,
        address account,
        uint256 amount
    ) external override whenNotPaused onlyLiquidStakingPool {
        _pendingBurn[account] += amount;
        pendingBurnsTotal += amount;
        uint256 sharesToBurn = bondsToShares(amount);
        _burn(ownerAddress, sharesToBurn);
        emit Transfer(account, address(0), amount);
    }

    function updatePendingBurning(address account, uint256 amount)
        external
        override
        whenNotPaused
        onlyLiquidStakingPool
    {
        uint256 pendingBurnableAmount = _pendingBurn[account];
        require(pendingBurnableAmount >= amount, "amount is wrong");
        _pendingBurn[account] -= amount;
        pendingBurnsTotal -= amount;
    }

    function recoverFromSnapshot(
        address[] memory claimers,
        uint256[] memory amounts
    ) external onlyOwner {
        require(
            claimers.length == amounts.length,
            "wrong length of input arrays"
        );

        // let's add into pending state for the future distribution rewards
        for (uint256 i = 0; i < claimers.length; i++) {
            _pendingBurn[claimers[i]] += amounts[i];
            pendingBurnsTotal += amounts[i];
        }
    }

    function setBinancePool(address newValue) external onlyGovernance {
        address prevValue = _binancePool;
        _binancePool = newValue;
        emit BinancePoolChanged(prevValue, newValue);
    }

    function getPools() external view returns (address, address) {
        return (address(_liquidStakingPool), _binancePool);
    }
}
