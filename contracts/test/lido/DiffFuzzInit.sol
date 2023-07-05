// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.7;

import "./DiffFuzzUpgrades.sol";
import "../../implementation/lido/StakedMATIC/0x6c25aebd494a9984a3d7c8cf395c8713e0c74d98/StMATIC/contracts/NodeOperatorRegistry.sol";
import "../../implementation/lido/StakedMATIC/0x6c25aebd494a9984a3d7c8cf395c8713e0c74d98/StMATIC/contracts/MaticToken.sol";


contract DiffFuzzInit is DiffFuzzUpgrades {
    MaticToken maticV1;
    MaticToken maticV2;
    NodeOperatorRegistry registryV1;
    NodeOperatorRegistry registryV2;

    constructor() DiffFuzzUpgrades() {
        maticV1 = new MaticToken("Matic Token", "MATIC", 18, 10000000000000000000000000000);
        maticV2 = new MaticToken("Matic Token", "MATIC", 18, 10000000000000000000000000000);
        registryV1 = new NodeOperatorRegistry();
        registryV2 = new NodeOperatorRegistry();
        hevm.prank(msg.sender);
        registryV1.initialize(IStakeManager(address(0)), IStMATIC(address(stMATICV1)), address(0));
        hevm.prank(msg.sender);
        registryV2.initialize(IStakeManager(address(0)), IStMATIC(address(stMATICV2)), address(0));
        hevm.prank(msg.sender);
        IStMATICV1(address(transparentProxyTestHarnessV1)).initialize(
            address(registryV1),
            address(maticV1),
            address(0x1000),
            address(0),
            address(0x2000),
            address(0),
            address(0)
        );
        hevm.prank(msg.sender);
        IStMATICV2(address(transparentProxyTestHarnessV2)).initialize(
            address(registryV2),
            address(maticV2),
            address(0x1000),
            address(0),
            address(0x2000),
            address(0),
            address(0)
        );
    }
}