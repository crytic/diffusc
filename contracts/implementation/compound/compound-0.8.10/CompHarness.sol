// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.10;

import "./Comp.sol";

contract CompHarness is Comp {
    bool initialized = false;

    constructor() Comp(address(0)) {}

    function initialize(address account) public {
        require(!initialized, "Already initialized");
        initialized = true;
        balances[address(0)] = 0;
        balances[account] = uint96(totalSupply);
        emit Transfer(address(0), account, totalSupply);
    }
}
