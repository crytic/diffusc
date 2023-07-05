// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.15;

import { LevelReferralControllerV2 as LevelReferralControllerV2_V1 } from "../../implementation/level/v1/LevelReferralControllerV2/src/referral/LevelReferralControllerV2.sol";
import { LevelReferralControllerV2 as LevelReferralControllerV2_V2 } from "../../implementation/level/v2/LevelReferralControllerV2/src/referral/LevelReferralControllerV2.sol";
import { TransparentProxyTestHarness } from "../../../diffusc/tests/unit/core/test_data/safemoon/TransparentProxyTestHarness.sol";

interface ILevelReferralControllerV2V1 {
    struct EpochInfo {
        uint256 TWAP;
        uint256 allocationTime;
        uint256 vestingDuration;
    }
    struct UserInfo {
        uint256 tier;
        uint256 tradingPoint;
        uint256 referralPoint;
        uint256 claimed;
    }
    struct TierInfo {
        uint256 minTrader;
        uint256 minEpochReferralPoint;
        uint256 discountForTrader;
        uint256 rebateForReferrer;
    }
    function MIN_EPOCH_DURATION() external returns (uint256);
    function MAX_EPOCH_VESTING_DURATION() external returns (uint256);
    function LVL() external returns (address);
    function oracle() external returns (address);
    function referralRegistry() external returns (address);
    function tiers(uint256) external returns (TierInfo memory);
    function epochs(uint256) external returns (EpochInfo memory);
    function users(uint256,address) external returns (UserInfo memory);
    function updater() external returns (address);
    function distributor() external returns (address);
    function currentEpoch() external returns (uint256);
    function lastEpochTimestamp() external returns (uint256);
    function epochDuration() external returns (uint256);
    function epochVestingDuration() external returns (uint256);
    function enableNextEpoch() external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address,address,uint256) external;
    function getNextEpoch() external view returns (uint256,uint256);
    function claimable(uint256,address) external view returns (uint256);
    function setReferrer(address) external;
    function updatePoint(address,uint256) external;
    function claim(uint256,address) external;
    function nextEpoch() external;
    function start(uint256) external;
    function setDistributor(address) external;
    function setUpdater(address) external;
    function setOracle(address) external;
    function setEpochDuration(uint256) external;
    function withdrawLVL(address,uint256) external;
    function setEnableNextEpoch(bool) external;
    function setEpochVestingDuration(uint256) external;
}

interface ILevelReferralControllerV2V2 {
    struct EpochInfo {
        uint256 TWAP;
        uint256 allocationTime;
        uint256 vestingDuration;
    }
    struct UserInfo {
        uint256 tier;
        uint256 tradingPoint;
        uint256 referralPoint;
        uint256 claimed;
    }
    struct TierInfo {
        uint256 minTrader;
        uint256 minEpochReferralPoint;
        uint256 discountForTrader;
        uint256 rebateForReferrer;
    }
    function MIN_EPOCH_DURATION() external returns (uint256);
    function MAX_EPOCH_VESTING_DURATION() external returns (uint256);
    function LVL() external returns (address);
    function oracle() external returns (address);
    function referralRegistry() external returns (address);
    function tiers(uint256) external returns (TierInfo memory);
    function epochs(uint256) external returns (EpochInfo memory);
    function users(uint256,address) external returns (UserInfo memory);
    function updater() external returns (address);
    function distributor() external returns (address);
    function currentEpoch() external returns (uint256);
    function lastEpochTimestamp() external returns (uint256);
    function epochDuration() external returns (uint256);
    function epochVestingDuration() external returns (uint256);
    function enableNextEpoch() external returns (bool);
    function orderHook() external returns (address);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address,address,uint256) external;
    function getNextEpoch() external view returns (uint256,uint256);
    function claimable(uint256,address) external view returns (uint256);
    function setReferrer(address) external;
    function updatePoint(address,uint256) external;
    function claim(uint256,address) external;
    function claimMultiple(uint256[] calldata,address) external;
    function nextEpoch() external;
    function start(uint256) external;
    function setDistributor(address) external;
    function setUpdater(address) external;
    function setOracle(address) external;
    function setEpochDuration(uint256) external;
    function withdrawLVL(address,uint256) external;
    function setEnableNextEpoch(bool) external;
    function setEpochVestingDuration(uint256) external;
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

    ILevelReferralControllerV2V1 levelReferralControllerV2V1;
    ILevelReferralControllerV2V2 levelReferralControllerV2V2;
    ITransparentProxyTestHarness transparentProxyTestHarnessV1;
    ITransparentProxyTestHarness transparentProxyTestHarnessV2;
    struct EpochInfo {
        uint256 TWAP;
        uint256 allocationTime;
        uint256 vestingDuration;
    }
    struct UserInfo {
        uint256 tier;
        uint256 tradingPoint;
        uint256 referralPoint;
        uint256 claimed;
    }
    struct TierInfo {
        uint256 minTrader;
        uint256 minEpochReferralPoint;
        uint256 discountForTrader;
        uint256 rebateForReferrer;
    }

    constructor() public {
        levelReferralControllerV2V1 = ILevelReferralControllerV2V1(address(new LevelReferralControllerV2_V1()));
        levelReferralControllerV2V2 = ILevelReferralControllerV2V2(address(new LevelReferralControllerV2_V2()));
        transparentProxyTestHarnessV1 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        transparentProxyTestHarnessV2 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        // Store the implementation addresses in the proxy.
        hevm.store(
            address(transparentProxyTestHarnessV1),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(levelReferralControllerV2V1))))
        );
        hevm.store(
            address(transparentProxyTestHarnessV2),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(levelReferralControllerV2V2))))
        );
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 

    function LevelReferralControllerV2_initialize(address a, address b, address c, uint256 d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,uint256)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LevelReferralControllerV2_claimable(uint256 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'claimable(uint256,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claimable(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LevelReferralControllerV2_setReferrer(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'setReferrer(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setReferrer(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LevelReferralControllerV2_updatePoint(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'updatePoint(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'updatePoint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LevelReferralControllerV2_claim(uint256 a, address b) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'claim(uint256,address)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claim(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function LevelReferralControllerV2_claimMultiple(uint256[] calldata a, address b) public virtual {
        // This function does nothing with the V1, since claimMultiple is new in the V2
        address impl = address(uint160(uint256(
            hevm.load(address(transparentProxyTestHarnessV2),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(levelReferralControllerV2V2));
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claimMultiple(uint256[],address)', a, b
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }


    /*** Tainted Variables ***/ 

    function LevelReferralControllerV2_LVL() public returns (address) {
        assert(ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).LVL() == ILevelReferralControllerV2V2(address(transparentProxyTestHarnessV2)).LVL());
        return ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).LVL();
    }

    function LevelReferralControllerV2_oracle() public returns (address) {
        assert(ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).oracle() == ILevelReferralControllerV2V2(address(transparentProxyTestHarnessV2)).oracle());
        return ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).oracle();
    }

    function LevelReferralControllerV2_referralRegistry() public returns (address) {
        assert(ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).referralRegistry() == ILevelReferralControllerV2V2(address(transparentProxyTestHarnessV2)).referralRegistry());
        return ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).referralRegistry();
    }

    function LevelReferralControllerV2_epochDuration() public returns (uint256) {
        assert(ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).epochDuration() == ILevelReferralControllerV2V2(address(transparentProxyTestHarnessV2)).epochDuration());
        return ILevelReferralControllerV2V1(address(transparentProxyTestHarnessV1)).epochDuration();
    }


    /*** Additional Targets ***/ 

}
