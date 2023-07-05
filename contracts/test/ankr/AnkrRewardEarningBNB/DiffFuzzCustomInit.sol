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
            true                                            //bondStakingPaused
        );
        IInternetBondRatioFeed ratio = new InternetBondRatioFeed_R2();
        ratio.initialize(msg.sender);

        aBNBbV1.initialize(address(config));
        aBNBbR1V2.initialize(address(config));
        aBNBcR1V1.initialize(address(config), 204215798494543411832740);
        aBNBcR1V2.initialize(address(config), 204215798494543411832740);

        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbV1.setLiquidStakingPool(0xa0c92efdceA55ca19396e4850B8D29Df6F907bcD);
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbV1.setInternetBondRatioFeed(address(ratio));
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbR1V2.setLiquidStakingPool(0xa0c92efdceA55ca19396e4850B8D29Df6F907bcD);
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBbR1V2.setInternetBondRatioFeed(address(ratio));
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBcR1V1.setLiquidStakingPool(0xa0c92efdceA55ca19396e4850B8D29Df6F907bcD);
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBcR1V1.setInternetBondRatioFeed(address(ratio));
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBcR1V2.setLiquidStakingPool(0xa0c92efdceA55ca19396e4850B8D29Df6F907bcD);
        hevm.prank(0x92A71de9C1caBf2902c758bfA7fBa6530b0B88B3);
        aBNBcR1V2.setInternetBondRatioFeed(address(ratio));
    }

    function aBNBb_R1_balanceOf(address a) public override {
        require(a != address(aBNBbV1));
        require(a != address(aBNBbR1V2));
        require(a != address(aBNBcR1V1));
        require(a != address(aBNBcR1V2));
        super.aBNBb_R1_balanceOf(a);
    }

    function aBNBc_R1_balanceOf(address a) public override {
        require(a != address(aBNBbV1));
        require(a != address(aBNBbR1V2));
        require(a != address(aBNBcR1V1));
        require(a != address(aBNBcR1V2));
        super.aBNBc_R1_balanceOf(a);
    }
}