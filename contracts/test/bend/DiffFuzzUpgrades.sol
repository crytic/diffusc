// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.4;

import { FeeCollector as FeeCollector_V1 } from "../../implementation/benddao/0x304eab894a048f35c399df835e2b508da886d180/FeeCollector/contracts/incentives/FeeCollector.sol";
import { FeeCollector as FeeCollector_V2 } from "../../implementation/benddao/0x37e570fd9b253ab076713cae31f48aa77a0a3b4b/FeeCollector/contracts/incentives/FeeCollector.sol";
import { TransparentProxyTestHarness } from "../../implementation/deus/TransparentProxyTestHarness.sol";

interface IFeeCollectorV1 {
    function WETH() external returns (address);
    function BWETH() external returns (address);
    function treasuryPercentage() external returns (uint256);
    function treasury() external returns (address);
    function bendCollector() external returns (address);
    function bendAddressesProvider() external returns (address);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address,address,address,address) external;
    function setTreasury(address) external;
    function setBendCollector(address) external;
    function setTreasuryPercentage(uint256) external;
    function collect() external;
}

interface IFeeCollectorV2 {
    function WETH() external returns (address);
    function BWETH() external returns (address);
    function treasuryPercentage() external returns (uint256);
    function treasury() external returns (address);
    function bendCollector() external returns (address);
    function bendAddressesProvider() external returns (address);
    function feeDistributor() external returns (address);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address,address,address,address) external;
    function setTreasury(address) external;
    function setBendCollector(address) external;
    function setFeeDistributor(address) external;
    function setTreasuryPercentage(uint256) external;
    function collect() external;
}

interface ITransparentProxyTestHarness {
    function admin() external returns (address);
    function implementation() external returns (address);
    function changeAdmin(address) external;
    function upgradeTo(address) external;
    function upgradeToAndCall(address,bytes calldata) external payable;
}

interface IHevm {
    function warp(uint256 newTimestamp) external;
    function roll(uint256 newNumber) external;
    function load(address where, bytes32 slot) external returns (bytes32);
    function store(address where, bytes32 slot, bytes32 value) external;
    function sign(uint256 privateKey, bytes32 digest) external returns (uint8 r, bytes32 v, bytes32 s);
    function addr(uint256 privateKey) external returns (address add);
    function ffi(string[] calldata inputs) external returns (bytes memory result);
    function prank(address newSender) external;
    function createFork() external returns (uint256 forkId);
    function selectFork(uint256 forkId) external;
}

contract DiffFuzzUpgrades {
    IHevm hevm = IHevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    IFeeCollectorV1 feeCollectorV1;
    IFeeCollectorV2 feeCollectorV2;
    ITransparentProxyTestHarness transparentProxyTestHarnessV1;
    ITransparentProxyTestHarness transparentProxyTestHarnessV2;

    constructor() public {
        feeCollectorV1 = IFeeCollectorV1(address(new FeeCollector_V1()));
        feeCollectorV2 = IFeeCollectorV2(address(new FeeCollector_V2()));
        transparentProxyTestHarnessV1 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        transparentProxyTestHarnessV2 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        // Store the implementation addresses in the proxy.
        hevm.store(
            address(transparentProxyTestHarnessV1),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(feeCollectorV1))))
        );
        hevm.store(
            address(transparentProxyTestHarnessV2),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(feeCollectorV2))))
        );
    }


    /*** Modified Functions ***/ 

    function FeeCollector_collect() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'collect()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'collect()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function FeeCollector_initialize(address a, address b, address c, address d, address e) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'initialize(IWETH,IERC20Upgradeable,address,address,ILendPoolAddressesProvider)', a, b, c, d, e
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'initialize(IWETH,IERC20Upgradeable,address,address,ILendPoolAddressesProvider)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 


    /*** Tainted Variables ***/ 

    function FeeCollector_WETH() public virtual returns (address) {
        assert(IFeeCollectorV1(address(transparentProxyTestHarnessV1)).WETH() == IFeeCollectorV2(address(transparentProxyTestHarnessV2)).WETH());
        return IFeeCollectorV1(address(transparentProxyTestHarnessV1)).WETH();
    }

    function FeeCollector_BWETH() public virtual returns (address) {
        assert(IFeeCollectorV1(address(transparentProxyTestHarnessV1)).BWETH() == IFeeCollectorV2(address(transparentProxyTestHarnessV2)).BWETH());
        return IFeeCollectorV1(address(transparentProxyTestHarnessV1)).BWETH();
    }

    function FeeCollector_treasury() public virtual returns (address) {
        assert(IFeeCollectorV1(address(transparentProxyTestHarnessV1)).treasury() == IFeeCollectorV2(address(transparentProxyTestHarnessV2)).treasury());
        return IFeeCollectorV1(address(transparentProxyTestHarnessV1)).treasury();
    }

    function FeeCollector_bendCollector() public virtual returns (address) {
        assert(IFeeCollectorV1(address(transparentProxyTestHarnessV1)).bendCollector() == IFeeCollectorV2(address(transparentProxyTestHarnessV2)).bendCollector());
        return IFeeCollectorV1(address(transparentProxyTestHarnessV1)).bendCollector();
    }

    function FeeCollector_bendAddressesProvider() public virtual returns (address) {
        assert(IFeeCollectorV1(address(transparentProxyTestHarnessV1)).bendAddressesProvider() == IFeeCollectorV2(address(transparentProxyTestHarnessV2)).bendAddressesProvider());
        return IFeeCollectorV1(address(transparentProxyTestHarnessV1)).bendAddressesProvider();
    }


    /*** Additional Targets ***/ 

}
