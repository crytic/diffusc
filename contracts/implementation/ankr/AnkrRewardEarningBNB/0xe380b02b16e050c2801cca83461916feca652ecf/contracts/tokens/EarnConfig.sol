// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

import "../@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "../@ankr.com/contracts/interfaces/IEarnConfig.sol";

contract EarnConfig is Initializable, IEarnConfig {

    event ConsensusAddressChanged(address prevValue, address newValue);
    event GovernanceAddressChanged(address prevValue, address newValue);
    event TreasuryAddressChanged(address prevValue, address newValue);
    event SwapFeeRatioChanged(uint16 prevValue, uint16 newValue);
    event BondStakingPaused(uint256 block);
    event BondStakingUnpaused(uint256 block);

    struct Slot0 {
        address consensusAddress;
        address governanceAddress;
        address treasuryAddress;
        uint16 swapFeeRatio;
        bool bondStakingPaused;
    }

    Slot0 internal _slot0;

    function initialize(
        address consensusAddress,
        address governanceAddress,
        address treasuryAddress,
        uint16 swapFeeRatio,
        bool bondStakingPaused
    ) external initializer {
        _slot0.consensusAddress = consensusAddress;
        emit ConsensusAddressChanged(address(0x00), consensusAddress);
        _slot0.governanceAddress = governanceAddress;
        emit GovernanceAddressChanged(address(0x00), governanceAddress);
        _slot0.treasuryAddress = treasuryAddress;
        emit TreasuryAddressChanged(address(0x00), treasuryAddress);
        _slot0.swapFeeRatio = swapFeeRatio;
        emit SwapFeeRatioChanged(0, swapFeeRatio);
        _slot0.bondStakingPaused = bondStakingPaused;
        if (bondStakingPaused) {
            emit BondStakingPaused(block.number);
        } else {
            emit BondStakingUnpaused(block.number);
        }
    }

    modifier onlyGovernance() virtual {
        require(msg.sender == address(_slot0.governanceAddress), "EarnConfig: only governance");
        _;
    }

    function getConsensusAddress() external view override returns (address) {
        return _slot0.consensusAddress;
    }

    function setConsensusAddress(address newValue) external override onlyGovernance {
        address prevValue = _slot0.consensusAddress;
        _slot0.consensusAddress = newValue;
        emit ConsensusAddressChanged(prevValue, newValue);
    }

    function getGovernanceAddress() external view override returns (address) {
        return _slot0.governanceAddress;
    }

    function setGovernanceAddress(address newValue) external override onlyGovernance {
        address prevValue = _slot0.governanceAddress;
        _slot0.governanceAddress = newValue;
        emit GovernanceAddressChanged(prevValue, newValue);
    }

    function getTreasuryAddress() external view override returns (address) {
        return _slot0.treasuryAddress;
    }

    function setTreasuryAddress(address newValue) external override onlyGovernance {
        address prevValue = _slot0.treasuryAddress;
        _slot0.treasuryAddress = newValue;
        emit TreasuryAddressChanged(prevValue, newValue);
    }

    function getSwapFeeRatio() external view override returns (uint16) {
        return _slot0.swapFeeRatio;
    }

    function setSwapFeeRatio(uint16 newValue) external override onlyGovernance {
        uint16 prevValue = _slot0.swapFeeRatio;
        _slot0.swapFeeRatio = newValue;
        emit SwapFeeRatioChanged(prevValue, newValue);
    }

    function pauseBondStaking() external override onlyGovernance {
        _slot0.bondStakingPaused = true;
        emit BondStakingPaused(block.number);
    }

    function unpauseBondStaking() external override onlyGovernance {
        _slot0.bondStakingPaused = false;
        emit BondStakingUnpaused(block.number);
    }

    function isBondStakingPaused() external view override returns (bool) {
        return _slot0.bondStakingPaused;
    }
}