// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

import "./IGovernable.sol";

interface IEarnConfig is IGovernable {

    function getConsensusAddress() external view returns (address);

    function setConsensusAddress(address newValue) external;

    function getGovernanceAddress() external view override returns (address);

    function setGovernanceAddress(address newValue) external;

    function getTreasuryAddress() external view returns (address);

    function setTreasuryAddress(address newValue) external;

    function getSwapFeeRatio() external view returns (uint16);

    function setSwapFeeRatio(uint16 newValue) external;

    function pauseBondStaking() external;

    function unpauseBondStaking() external;

    function isBondStakingPaused() external view returns (bool);
}