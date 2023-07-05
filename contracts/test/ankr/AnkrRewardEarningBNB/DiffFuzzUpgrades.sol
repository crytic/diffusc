// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.16;

import { aBNBb as aBNBb_V1 } from "../../../implementation/ankr/AnkrRewardEarningBNB/0xe380b02b16e050c2801cca83461916feca652ecf/contracts/tokens/aBNBb.sol";
import { aBNBb_R1 as aBNBb_R1_V2 } from "../../../implementation/ankr/AnkrRewardEarningBNB/0x952398318838b4915ee5e800622a9613887759f5/contracts/tokens/aBNBb_R1.sol";
import { BinancePool_R13 } from "../../../implementation/ankr/AnkrRewardEarningBNB/0xe380b02b16e050c2801cca83461916feca652ecf/contracts/pool/BinancePool_R13.sol";
import { aBNBc_R1 } from "../../../implementation/ankr/AnkrRewardEarningBNB/0xe380b02b16e050c2801cca83461916feca652ecf/contracts/tokens/upgrades/aBNBc_R1.sol";

interface IaBNBbV1 {
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

interface IaBNBb_R1V2 {
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
    function setBinancePool(address) external;
    function getPools() external view returns (address,address);
}

interface IBinancePool_R13 {
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
    function recoverFromSnapshot(address[] memory,uint256[] memory) external;
    function setMinimumStake(uint256) external;
    function setDistributeGasLeft(uint256) external;
    function getRelayerFee() external view returns (uint256);
    function changeIntermediary(address) external;
    function changeBondContract(address) external;
    function changeCertContract(address) external;
    function changeTokenHub(address) external;
    function withdrawFailedStakes() external;
    function pause() external;
    function unpause() external;
}

interface IaBNBc_R1 {
    function initialize(address,string memory,string memory) external;
    function setLiquidStakingPool(address) external;
    function setInternetBondRatioFeed(address) external;
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function approve(address,uint256) external returns (bool);
    function mint(address,uint256) external;
    function burn(address,uint256) external;
    function sharesToBonds(uint256) external view returns (uint256);
    function bondsToShares(uint256) external view returns (uint256);
    function ratio() external view returns (uint256);
    function isRebasing() external pure returns (bool);
    function paused() external view returns (bool);
    function pause() external;
    function unpause() external;
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address,address) external view returns (uint256);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,uint256) external;
    function balanceWithRewardsOf(address) external view returns (uint256);
    function distributeSnapshot(address[] calldata,uint256[] calldata) external;
    function finalizeAirdrop() external;
    function setBinancePool(address) external;
    function getPools() external view returns (address,address);
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

    IaBNBbV1 aBNBbV1;
    IaBNBb_R1V2 aBNBbR1V2;
    IBinancePool_R13 binancePoolR13V1;
    IBinancePool_R13 binancePoolR13V2;
    IaBNBc_R1 aBNBcR1V1;
    IaBNBc_R1 aBNBcR1V2;

    constructor() public {
        aBNBbV1 = IaBNBbV1(address(new aBNBb_V1()));
        aBNBbR1V2 = IaBNBb_R1V2(address(new aBNBb_R1_V2()));
        binancePoolR13V1 = IBinancePool_R13(address(new BinancePool_R13()));
        binancePoolR13V2 = IBinancePool_R13(address(new BinancePool_R13()));
        aBNBcR1V1 = IaBNBc_R1(address(new aBNBc_R1()));
        aBNBcR1V2 = IaBNBc_R1(address(new aBNBc_R1()));
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 

    function aBNBb_R1_mint(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_burn(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_lockShares(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'lockShares(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'lockShares(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_lockSharesFor(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'lockSharesFor(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'lockSharesFor(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_unlockShares(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'unlockShares(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'unlockShares(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_unlockSharesFor(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'unlockSharesFor(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'unlockSharesFor(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_totalSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_totalSharesSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'totalSharesSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'totalSharesSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_burnAndSetPending(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'burnAndSetPending(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'burnAndSetPending(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_burnAndSetPendingFor(address a, address b, uint256 c) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'burnAndSetPendingFor(address,address,uint256)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'burnAndSetPendingFor(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBb_R1_updatePendingBurning(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBbV1).call(
            abi.encodeWithSignature(
                'updatePendingBurning(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'updatePendingBurning(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function aBNBb_R1_setBinancePool(address a) public virtual {
        // This function does nothing with the V1, since setBinancePool is new in the V2
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'setBinancePool(address)', a
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }

    function aBNBb_R1_getPools() public virtual {
        // This function does nothing with the V1, since getPools is new in the V2
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBbR1V2).call(
            abi.encodeWithSignature(
                'getPools()'
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }


    /*** Tainted Variables ***/ 

    function aBNBb_pendingBurnsTotal() public virtual returns (uint256) {
        assert(aBNBbV1.pendingBurnsTotal() == aBNBbR1V2.pendingBurnsTotal());
        return aBNBbV1.pendingBurnsTotal();
    }


    /*** Additional Targets ***/ 

    function BinancePool_R13_distributeManual(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'distributeManual(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'distributeManual(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_distributeRewards() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'distributeRewards()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'distributeRewards()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_getMinimumStake() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'getMinimumStake()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'getMinimumStake()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_getRelayerFee() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'getRelayerFee()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'getRelayerFee()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_initialize(address a, address b, address c, uint64 d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,uint64)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,uint64)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_owner() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_paused() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_pendingGap() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'pendingGap()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'pendingGap()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_pendingUnstakesOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'pendingUnstakesOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'pendingUnstakesOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_setMinimumStake(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'setMinimumStake(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'setMinimumStake(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_stake() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'stake()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'stake()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_stakeAndClaimBonds() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'stakeAndClaimBonds()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'stakeAndClaimBonds()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_stakeAndClaimBondsWithCode(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'stakeAndClaimBondsWithCode(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'stakeAndClaimBondsWithCode(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_stakeAndClaimCerts() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'stakeAndClaimCerts()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'stakeAndClaimCerts()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_stakeAndClaimCertsWithCode(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'stakeAndClaimCertsWithCode(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'stakeAndClaimCertsWithCode(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_unstake(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'unstake(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'unstake(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_unstakeBonds(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'unstakeBonds(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'unstakeBonds(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_unstakeBondsFor(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'unstakeBondsFor(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'unstakeBondsFor(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_unstakeCerts(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'unstakeCerts(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'unstakeCerts(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_unstakeCertsFor(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'unstakeCertsFor(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'unstakeCertsFor(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BinancePool_R13_withdrawFailedStakes() public virtual {
        (bool successV1, bytes memory outputV1) = address(binancePoolR13V1).call(
            abi.encodeWithSignature(
                'withdrawFailedStakes()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(binancePoolR13V2).call(
            abi.encodeWithSignature(
                'withdrawFailedStakes()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_allowance(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_approve(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_balanceWithRewardsOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'balanceWithRewardsOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'balanceWithRewardsOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_bondsToShares(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'bondsToShares(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'bondsToShares(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_burn(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_decimals() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_distributeSnapshot(address[] calldata a, uint256[] calldata b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'distributeSnapshot(address[],uint256[])', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'distributeSnapshot(address[],uint256[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_finalizeAirdrop() public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'finalizeAirdrop()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'finalizeAirdrop()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_getPools() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'getPools()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'getPools()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_increaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_initialize(address a, string memory b, string memory c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'initialize(IEarnConfig,string,string)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'initialize(IEarnConfig,string,string)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_initialize(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'initialize(IEarnConfig,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'initialize(IEarnConfig,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_isRebasing() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'isRebasing()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'isRebasing()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_mint(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_name() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_owner() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_pause() public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_paused() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_ratio() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'ratio()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'ratio()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_setBinancePool(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'setBinancePool(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'setBinancePool(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_setInternetBondRatioFeed(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'setInternetBondRatioFeed(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'setInternetBondRatioFeed(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_setLiquidStakingPool(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'setLiquidStakingPool(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'setLiquidStakingPool(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_sharesToBonds(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'sharesToBonds(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'sharesToBonds(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_symbol() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_totalSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function aBNBc_R1_unpause() public virtual {
        (bool successV1, bytes memory outputV1) = address(aBNBcR1V1).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(aBNBcR1V2).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
