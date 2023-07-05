// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.7;

interface IPausable {
    event Paused(address account);
    event Unpaused(address account);

    function pause() external;

    function unpause() external;
}
