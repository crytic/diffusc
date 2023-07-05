// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.11;

import "../output/DiffFuzzUpgrades.sol";
import { Safemoon as Safemoon_V1 } from "./SafemoonV2.sol";
import { Safemoon as Safemoon_V2 } from "./SafemoonV3.sol";

contract DiffFuzzInit is DiffFuzzUpgrades {
     constructor() {
         // Initialize contracts
         hevm.prank(msg.sender);
         ISafemoonV1(address(transparentProxyTestHarnessV1)).initialize();
         hevm.prank(msg.sender);
         ISafemoonV2(address(transparentProxyTestHarnessV2)).initialize();

         // Distribute some tokens to other accounts
         hevm.prank(msg.sender);
         uint myBalance = ISafemoonV1(address(transparentProxyTestHarnessV1)).balanceOf(address(msg.sender));
         hevm.prank(msg.sender);
         ISafemoonV1(address(transparentProxyTestHarnessV1)).transfer(address(0x2000), myBalance / 10);
         hevm.prank(msg.sender);
         ISafemoonV2(address(transparentProxyTestHarnessV2)).transfer(address(0x2000), myBalance / 10);
         hevm.prank(msg.sender);
         ISafemoonV1(address(transparentProxyTestHarnessV1)).transfer(address(0x3000), myBalance / 10);
         hevm.prank(msg.sender);
         ISafemoonV2(address(transparentProxyTestHarnessV2)).transfer(address(0x3000), myBalance / 10);
     }

    function Safemoon_transfer(address a, uint256 b) public override {
        require(a != address(transparentProxyTestHarnessV1) && a != address(transparentProxyTestHarnessV2));
        super.Safemoon_transfer(a, b);
    }

    function Safemoon_transferFrom(address a, address b, uint256 c) public override {
        require(a != address(transparentProxyTestHarnessV1) && a != address(transparentProxyTestHarnessV2));
        require(b != address(transparentProxyTestHarnessV1) && b != address(transparentProxyTestHarnessV2));
        super.Safemoon_transferFrom(a, b, c);
    }
}