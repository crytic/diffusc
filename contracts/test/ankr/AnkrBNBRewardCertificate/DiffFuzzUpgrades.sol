// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.16;

import { aBNBc_R3 as aBNBc_R3_V1 } from "../../../implementation/ankr/AnkrBNBRewardCertificate/contracts/upgrades/aBNBc_R3.sol";
import { aBNBc_Malicious as aBNBc_Malicious_V2 } from "../../../implementation/ankr/AnkrBNBRewardCertificate/contracts/upgrades/aBNBc_Malicious.sol";
import { BinancePool_R9 } from "../../../implementation/ankr/AnkrBNBPool/contracts/upgrades/BinancePool_R9.sol";
import { aBNBb } from "../../../implementation/ankr/AnkrRewardEarningBNB/0xe380b02b16e050c2801cca83461916feca652ecf/contracts/tokens/aBNBb.sol";
import { IBondToken } from "../../../implementation/ankr/AnkrBNBRewardCertificate/contracts/interface/IBondToken.sol";

interface IaBNBc_R3V1 {
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address) external;
    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function ratio() external view returns (uint256);
    function burn(address,uint256) external;
    function mint(address,uint256) external;
    function mintApprovedTo(address,address,uint256) external;
    function changeBinancePool(address) external;
    function changeBondToken(address) external;
    function balanceWithRewardsOf(address) external view returns (uint256);
    function isRebasing() external pure returns (bool);
}

interface IaBNBc_MaliciousV2 {
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address) external;
    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function ratio() external view returns (uint256);
    function burn(address,uint256) external;
    function mint(address,uint256) external;
    function attack(address,uint256) external;
    function mintApprovedTo(address,address,uint256) external;
    function changeBinancePool(address) external;
    function changeBondToken(address) external;
    function balanceWithRewardsOf(address) external view returns (uint256);
    function isRebasing() external pure returns (bool);
}

interface IBinancePool_R9 {
    function pendingClaimerUnstakes(address) external returns (uint256);
    function stashedForManualDistributes() external returns (uint256);
    function markedForManualDistribute(uint256) external returns (bool);
    function failedStakesAmount() external returns (uint256);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function paused() external view returns (bool);
    function initialize(address,address,address,uint64) external;
    function stake() external payable;
    function stakeAndClaimBonds() external payable;
    function stakeAndClaimBondsWithCode(uint256) external payable;
    function stakeAndClaimCerts() external payable;
    function stakeAndClaimCertsWithCode(uint256) external payable;
    function unstake(uint256) external;
    function unstakeBonds(uint256) external;
    function unstakeBondsFor(address,uint256) external;
    function unstakeCerts(uint256) external;
    function unstakeCertsFor(address,uint256) external;
    function distributeRewards() external payable;
    function distributeManual(uint256) external;
    function pendingUnstakesOf(address) external view returns (uint256);
    function pendingGap() external view returns (uint256);
    function calcPendingGap() external;
    function getMinimumStake() external view returns (uint256);
    function resetPendingGap() external;
    function setMinimumStake(uint256) external;
    function setDistributeGasLeft(uint256) external;
    function getRelayerFee() external view returns (uint256);
    function changeIntermediary(address) external;
    function changeBondContract(address) external;
    function changeCertContract(address) external;
    function changeTokenHub(address) external;
    function withdrawFailedStakes() external;
}

interface IaBNBb {
    function pendingBurnsTotal() external returns (uint256);
    function initialize(address,string memory,string memory) external;
    function setLiquidStakingPool(address) external;
    function setInternetBondRatioFeed(address) external;
    function setCertificateToken(address) external;
    function mint(address,uint256) external;
    function burn(address,uint256) external;
    function sharesToBonds(uint256) external view returns (uint256);
    function bondsToShares(uint256) external view returns (uint256);
    function ratio() external view returns (uint256);
    function isRebasing() external pure returns (bool);
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function lockShares(uint256) external;
    function lockSharesFor(address,uint256) external;
    function unlockShares(uint256) external;
    function unlockSharesFor(address,uint256) external;
    function totalSupply() external view returns (uint256);
    function totalSharesSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function paused() external view returns (bool);
    function pause() external;
    function unpause() external;
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function allowance(address,address) external view returns (uint256);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address) external;
    function pendingBurn(address) external view returns (uint256);
    function burnAndSetPending(address,uint256) external;
    function burnAndSetPendingFor(address,address,uint256) external;
    function updatePendingBurning(address,uint256) external;
    function recoverFromSnapshot(address[] memory,uint256[] memory) external;
}

interface IIBondToken {
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

    IaBNBc_R3V1 aBNBcR3V1;
    IaBNBc_MaliciousV2 aBNBcMaliciousV2;
    IBinancePool_R9 binancePoolR9V1;
    IBinancePool_R9 binancePoolR9V2;
    IaBNBb aBNBbV1;
    IaBNBb aBNBbV2;
    IIBondToken iBondTokenV1;
    IIBondToken iBondTokenV2;

    constructor() public {
        aBNBcR3V1 = IaBNBc_R3V1(address(new aBNBc_R3_V1()));
        aBNBcMaliciousV2 = IaBNBc_MaliciousV2(address(new aBNBc_Malicious_V2()));
        binancePoolR9V1 = IBinancePool_R9(address(new BinancePool_R9()));
        binancePoolR9V2 = IBinancePool_R9(address(new BinancePool_R9()));
        aBNBbV1 = IaBNBb(address(new aBNBb()));
        aBNBbV2 = IaBNBb(address(new aBNBb()));
        iBondTokenV1 = IIBondToken(address(new IBondToken()));
        iBondTokenV2 = IIBondToken(address(new IBondToken()));
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 

    function aBNBc_Malicious_totalSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_Malicious_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_Malicious_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_Malicious_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_Malicious_initialize(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'initialize(address,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'initialize(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_Malicious_burn(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_Malicious_mint(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_Malicious_mintApprovedTo(address a, address b, uint256 c) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR3V1).call(
            abi.encodeWithSignature(
                'mintApprovedTo(address,address,uint256)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'mintApprovedTo(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function aBNBc_Malicious_attack(address a, uint256 b) public virtual {
        // This function does nothing with the V1, since attack is new in the V2
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcMaliciousV2).call(
            abi.encodeWithSignature(
                'attack(address,uint256)', a, b
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }


    /*** Tainted Variables ***/ 


    /*** Tainted External Contracts ***/ 

    function IBondToken_totalSharesSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iBondTokenV1).call(
            abi.encodeWithSignature(
                'totalSharesSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iBondTokenV2).call(
            abi.encodeWithSignature(
                'totalSharesSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Additional Targets ***/ 

    function aBNBb_totalSharesSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'totalSharesSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBbV2).call(
            abi.encodeWithSignature(
                'totalSharesSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
