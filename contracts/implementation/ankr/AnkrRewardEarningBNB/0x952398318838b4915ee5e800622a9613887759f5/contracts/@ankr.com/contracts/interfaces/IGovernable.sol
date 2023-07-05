// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

interface IGovernable {

    function getGovernanceAddress() external view returns (address);
}