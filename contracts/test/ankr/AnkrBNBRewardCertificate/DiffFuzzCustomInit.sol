// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.16;

import "./DiffFuzzUpgrades.sol";
import "../../../implementation/ankr/AnkrRewardEarningBNB/0xe380b02b16e050c2801cca83461916feca652ecf/contracts/tokens/EarnConfig.sol";
import "../../../implementation/ankr/AnkrRewardEarningBNB/0xe380b02b16e050c2801cca83461916feca652ecf/contracts/@ankr.com/contracts/earn/InternetBondRatioFeed_R2.sol";

contract DiffFuzzCustomInit is DiffFuzzUpgrades {

    constructor() DiffFuzzUpgrades() {
        EarnConfig config = new EarnConfig();
        config.initialize(
            0x4069D8A3dE3A72EcA86CA5e0a4B94619085E7362,     // consensusAddress
            0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3,     // governanceAddress
            0x834346f5A6dBE100F8F9E01D824F7dB6b80e3710,     // treasuryAddress
            0,                                              // swapFeeRatio
            true                                            // bondStakingPaused
        );
        IInternetBondRatioFeed ratio = new InternetBondRatioFeed_R2();
        ratio.initialize(msg.sender);

        aBNBbV1.initialize(address(config));
        aBNBbV2.initialize(address(config));

        binancePoolR9V1.initialize(msg.sender, msg.sender, address(0x1004), 3600);
        binancePoolR9V2.initialize(msg.sender, msg.sender, address(0x1004), 3600);

        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbV1.setLiquidStakingPool(address(binancePoolR9V1));
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbV1.setInternetBondRatioFeed(address(ratio));
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbV2.setLiquidStakingPool(address(binancePoolR9V2));
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbV2.setInternetBondRatioFeed(address(ratio));

        aBNBcR3V1.initialize(address(binancePoolR9V1), address(aBNBbV1));
        aBNBcMaliciousV2.initialize(address(binancePoolR9V2), address(aBNBbV2));
    }

    function aBNBb_balanceOf(address a) public override {
        require(a != address(aBNBbV1));
        require(a != address(aBNBbV2));
        require(a != address(aBNBcR3V1));
        require(a != address(aBNBcMaliciousV2));
        require(a != address(binancePoolR9V1));
        require(a != address(binancePoolR9V2));
        super.aBNBb_balanceOf(a);
    }

    function aBNBc_Malicious_balanceOf(address a) public override {
        require(a != address(aBNBbV1));
        require(a != address(aBNBbV2));
        require(a != address(aBNBcR3V1));
        require(a != address(aBNBcMaliciousV2));
        require(a != address(binancePoolR9V1));
        require(a != address(binancePoolR9V2));
        super.aBNBc_Malicious_balanceOf(a);
    }
}