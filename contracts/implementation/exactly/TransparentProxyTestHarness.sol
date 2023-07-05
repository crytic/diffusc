// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.4;

import "./TransparentUpgradeableProxy.sol";

contract TransparentProxyTestHarness is TransparentUpgradeableProxy {
    constructor() TransparentUpgradeableProxy(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, msg.sender, "") {}
}
