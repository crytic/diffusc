// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.17;

import "./DiffFuzzUpgrades.sol";
import "../../implementation/exactly/0xc91dc7a797cd5fbcf6f334c792a2b24eff55292c/RewardsController/contracts/InterestRateModel.sol";
import { Auditor } from "../../implementation/exactly/0xc91dc7a797cd5fbcf6f334c792a2b24eff55292c/RewardsController/contracts/Auditor.sol";
import "../../implementation/exactly/0xc91dc7a797cd5fbcf6f334c792a2b24eff55292c/RewardsController/contracts/solmate/src/tokens/ERC20.sol";

contract Asset is ERC20 {
    constructor(string memory _name, string memory _symbol, uint8 _decimals) ERC20(_name, _symbol, _decimals) {}
}

contract DiffFuzzCustomInit is DiffFuzzUpgrades {
    constructor() DiffFuzzUpgrades() {
        hevm.prank(address(0x1000));
        IRewardsControllerV1(address(transparentProxyTestHarnessV1)).initialize();
        hevm.prank(address(0x1000));
        IRewardsControllerV2(address(transparentProxyTestHarnessV2)).initialize();

        ERC20 assetV1 = new Asset("assetV1", "V1", 6);
        ERC20 assetV2 = new Asset("assetV2", "V2", 6);
        Auditor auditor = new Auditor(8);

        marketV1 = IMarket(address(new Market(assetV1, auditor)));
        marketV2 = IMarket(address(new Market(assetV2, auditor)));

        // Based on 0x8c2f35c8076bcb5d4b696bae11aca0ac0dd873e4
        InterestRateModel model = new InterestRateModel(
            392810000000000000,
            -377810000000000000,
            1000014451000000000,
            14844000000000000,
            199640000000000,
            1002968978000000000
        );

        // Based on 0x81C9A7B55A4df39A9B7B5F781ec0e53539694873
        marketV1.initialize(
            6,
            2000000000000000000,
            address(model),
            52083333333,
            100000000000000000,
            100000000000000000,
            4600000000000000,
            400000000000000000
        );
        marketV2.initialize(
            6,
            2000000000000000000,
            address(model),
            52083333333,
            100000000000000000,
            100000000000000000,
            4600000000000000,
            400000000000000000
        );
    }
}