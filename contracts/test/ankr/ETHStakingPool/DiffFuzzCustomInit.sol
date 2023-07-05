// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.6.11;
pragma experimental ABIEncoderV2;

import "./DiffFuzzUpgrades.sol";
import "../../../implementation/ankr/AnkrETHStakingPool/0x52f24a5e03aee338da5fd9df68d2b6fae1178827/GlobalPool/SystemParameters.sol";

contract DiffFuzzCustomInit is DiffFuzzUpgrades {
    constructor() DiffFuzzUpgrades() public {
        SystemParameters params = new SystemParameters();
        params.initialize();
        aETHR18V1.initialize("AETH", "AETH");
        aETHR18V2.initialize("AETH", "AETH");
        globalPoolR42V1.initialize(address(aETHR18V1), address(params), 0x00000000219ab540356cBB839Cbe05303d7705Fa);
        globalPoolR43V2.initialize(address(aETHR18V2), address(params), 0x00000000219ab540356cBB839Cbe05303d7705Fa);
    }
}
