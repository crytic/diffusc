// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.10;

import "./ComptrollerV2.sol";

contract ComptrollerHarness is Comptroller {
    address internal compAddress;

    function getCompAddress() public view override returns (address) {
        return compAddress;
    }

    function setCompAddress(address _comp) public {
        compAddress = _comp;
    }

    function isListed(address cToken) public view returns (bool) {
        return markets[cToken].isListed;
    }
}
