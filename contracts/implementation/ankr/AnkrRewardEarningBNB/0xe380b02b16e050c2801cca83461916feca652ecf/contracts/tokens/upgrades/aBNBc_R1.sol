// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.16;

import "../../@ankr.com/contracts/earn/CertificateToken.sol";
import "../../@ankr.com/contracts/interfaces/IEarnConfig.sol";

import "../../interfaces/ICertToken.sol";

contract aBNBc_R1 is CertificateToken, ICertToken {
    bool airdroped;
    // prev pool
    address internal _binancePool;

    modifier airDrop() {
        require(!airdroped, "CertificateToken: snapshot already airdroped");
        _;
    }

    modifier onlyLiquidStakingPool() override {
        require(
            msg.sender == address(_liquidStakingPool) ||
                msg.sender == address(_binancePool),
            "CertificateToken: only liquid staking pool"
        );
        _;
    }

    function initialize(IEarnConfig earnConfig, uint256 initSupply)
        external
        initializer
    {
        __Ownable_init();
        __ERC20_init("Ankr Staked BNB", "ankrBNB");
        __CertificateToken_init(earnConfig);
        _mint(address(this), initSupply);
        airdroped = false;
    }

    function balanceWithRewardsOf(address account)
        public
        view
        override
        returns (uint256)
    {
        uint256 shares = this.balanceOf(account);
        return sharesToBonds(shares);
    }

    function distributeSnapshot(
        address[] calldata receivers,
        uint256[] calldata amounts
    ) external airDrop onlyGovernance {
        require(
            receivers.length == amounts.length,
            "wrong length of input arrays"
        );

        for (uint256 i = 0; i < receivers.length; i++) {
            _transfer(address(this), receivers[i], amounts[i]);
        }
    }

    function finalizeAirdrop() external airDrop onlyGovernance {
        airdroped = true;
        emit AirDropFinished();
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
