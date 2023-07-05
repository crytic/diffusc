// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.11;

import "./TransparentUpgradeableProxy.sol";

contract TransparentProxyTestHarness is TransparentUpgradeableProxy {
    constructor() TransparentUpgradeableProxy(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D, msg.sender, "") {}
}
