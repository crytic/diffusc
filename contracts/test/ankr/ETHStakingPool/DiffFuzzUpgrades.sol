// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.6.11;

pragma experimental ABIEncoderV2;

import { GlobalPool_R42 as GlobalPool_R42_V1 } from "../../../implementation/ankr/AnkrETHStakingPool/0x52f24a5e03aee338da5fd9df68d2b6fae1178827/GlobalPool/upgrades/GlobalPool_R42.sol";
import { GlobalPool_R43 as GlobalPool_R43_V2 } from "../../../implementation/ankr/AnkrETHStakingPool/0x7885d048e41fb3c5697ce1cdc5eb3aeea276c964/GlobalPool/upgrades/GlobalPool_R43.sol";
import { AETH_R18 } from "../../../implementation/ankr/AnkrETHStakingPool/0x7885d048e41fb3c5697ce1cdc5eb3aeea276c964/GlobalPool/upgrades/AETH_R18.sol";

interface IGlobalPool_R42V1 {
    enum LockStrategy { Claimable, CrossChain, Provider }
    function treasury() external returns (address);
    function _DISTRIBUTE_GAS_LIMIT() external returns (uint256);
    function togglePause(bytes32) external;
    function isPaused(bytes32) external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address,address) external;
    function pushToVault(address,uint256) external;
    function pushToBeacon(bytes calldata,bytes calldata,bytes calldata,bytes32) external;
    function restake() external payable;
    function stake() external payable;
    function stakeAndClaimAethC() external payable;
    function stakeAndClaimAethB() external payable;
    function crossChainStake(address[] memory,uint256[] memory) external payable;
    function claimableAETHRewardOf(address) external view returns (uint256);
    function claimableFETHRewardOf(address) external view returns (uint256);
    function claimableAETHFRewardOf(address) external view returns (uint256);
    function claimAETH() external;
    function claimFETH() external;
    function unstakeFETH(uint256) external;
    function unstakeFETHFor(uint256,address) external;
    function unstakeAETH(uint256) external;
    function unstakeAETHFor(uint256,address) external;
    function getUnstakeRequestsOf(address) external view returns (uint256[] memory);
    function getPendingUnstakesOf(address) external view returns (uint256);
    function getTotalPendingUnstakes() external view returns (uint256);
    function distributeRewards(uint256) external;
    function claimManually(address) external;
    function isMarkedForManualClaim(address) external view returns (bool);
    function getForManualClaimOf(address) external view returns (uint256);
    function getStashedForManualClaims() external view returns (uint256);
    function availableEtherBalanceOf(address) external view returns (uint256);
    function etherBalanceOf(address) external view returns (uint256);
    function slashingsOf(address) external view returns (uint256);
    function topUpETH() external payable;
    function topUpANKR(uint256) external;
    function forceAdminProviderExit(address[] calldata) external;
    function resetLockedEthForProviders(address[] calldata) external;
    function softLockBlockNumber(address) external view returns (uint256);
    function slashETH(address,uint256) external;
    function totalSlashedETH() external view returns (uint256);
    function updateAETHContract(address) external;
    function updateFETHContract(address) external;
    function updateConfigContract(address) external;
    function updateStakingContract(address) external;
    function changeOperator(address) external;
    function updateDistributeGasLimit(uint256) external;
    function updateWithdrawalPool(address) external;
    function updateTreasury(address) external;
    function allowVault(address) external;
    function disallowVault(address) external;
    function depositContractAddress() external view returns (address);
    function crossChainBridge() external view returns (address);
}

interface IGlobalPool_R43V2 {
    enum LockStrategy { Claimable, CrossChain, Provider }
    function treasury() external returns (address);
    function _DISTRIBUTE_GAS_LIMIT() external returns (uint256);
    function togglePause(bytes32) external;
    function isPaused(bytes32) external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(address,address,address) external;
    function pushToVault(address,uint256) external;
    function pushToBeacon(bytes calldata,bytes calldata,bytes calldata,bytes32) external;
    function restake() external payable;
    function stake() external payable;
    function stakeAndClaimAethC() external payable;
    function stakeAndClaimAethB() external payable;
    function crossChainStake(address[] memory,uint256[] memory) external payable;
    function claimableAETHRewardOf(address) external view returns (uint256);
    function claimableFETHRewardOf(address) external view returns (uint256);
    function claimableAETHFRewardOf(address) external view returns (uint256);
    function claimAETH() external;
    function claimFETH() external;
    function unstakeFETH(uint256) external;
    function unstakeFETHFor(uint256,address) external;
    function unstakeAETH(uint256) external;
    function unstakeAETHFor(uint256,address) external;
    function getUnstakeRequestsOf(address) external view returns (uint256[] memory);
    function getPendingUnstakesOf(address) external view returns (uint256);
    function getTotalPendingUnstakes() external view returns (uint256);
    function distributeRewards(uint256) external;
    function claimManually(address) external;
    function isMarkedForManualClaim(address) external view returns (bool);
    function getForManualClaimOf(address) external view returns (uint256);
    function getStashedForManualClaims() external view returns (uint256);
    function availableEtherBalanceOf(address) external view returns (uint256);
    function etherBalanceOf(address) external view returns (uint256);
    function slashingsOf(address) external view returns (uint256);
    function topUpETH() external payable;
    function topUpANKR(uint256) external;
    function forceAdminProviderExit(address[] calldata) external;
    function resetLockedEthForProviders(address[] calldata) external;
    function softLockBlockNumber(address) external view returns (uint256);
    function slashETH(address,uint256) external;
    function totalSlashedETH() external view returns (uint256);
    function updateAETHContract(address) external;
    function updateFETHContract(address) external;
    function updateConfigContract(address) external;
    function updateStakingContract(address) external;
    function changeOperator(address) external;
    function updateDistributeGasLimit(uint256) external;
    function updateWithdrawalPool(address) external;
    function updateTreasury(address) external;
    function allowVault(address) external;
    function disallowVault(address) external;
    function depositContractAddress() external view returns (address);
    function crossChainBridge() external view returns (address);
}

interface IAETH_R18 {
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize(string memory,string memory) external;
    function isRebasing() external pure returns (bool);
    function updateRatio(uint256) external;
    function updateRatioAndClaim(uint256) external;
    function repairRatio(uint256) external;
    function ratio() external view returns (uint256);
    function updateGlobalPoolContract(address) external;
    function burn(address,uint256) external;
    function mint(address,uint256) external returns (uint256);
    function mintApprovedTo(address,address,uint256) external;
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function setNewNameAndSymbol() external;
    function setNameAndSymbol(string memory,string memory) external;
    function changeOperator(address) external;
    function transfer(address,uint256) external returns (bool);
    function sharesToBonds(uint256) external view returns (uint256);
    function bondsToShares(uint256) external view returns (uint256);
    function togglePause(bytes32) external;
    function isPaused(bytes32) external view returns (bool);
    function setBscBridgeContract(address) external;
    function setFeeRecipient(address) external;
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

    IGlobalPool_R42V1 globalPoolR42V1;
    IGlobalPool_R43V2 globalPoolR43V2;
    IAETH_R18 aETHR18V1;
    IAETH_R18 aETHR18V2;

    constructor() public {
        globalPoolR42V1 = IGlobalPool_R42V1(address(new GlobalPool_R42_V1()));
        globalPoolR43V2 = IGlobalPool_R43V2(address(new GlobalPool_R43_V2()));
        aETHR18V1 = IAETH_R18(address(new AETH_R18()));
        aETHR18V2 = IAETH_R18(address(new AETH_R18()));
    }


    /*** Modified Functions ***/ 

    function GlobalPool_R43_claimableAETHRewardOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'claimableAETHRewardOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'claimableAETHRewardOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_claimAETH() public virtual {
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'claimAETH()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'claimAETH()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_claimFETH() public virtual {
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'claimFETH()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'claimFETH()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function GlobalPool_R43_stake() public virtual {
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'stake()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'stake()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_stakeAndClaimAethC() public virtual {
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'stakeAndClaimAethC()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'stakeAndClaimAethC()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_stakeAndClaimAethB() public virtual {
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'stakeAndClaimAethB()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'stakeAndClaimAethB()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_crossChainStake(address[] memory a, uint256[] memory b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'crossChainStake(address[],uint256[])', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'crossChainStake(address[],uint256[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_claimableFETHRewardOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'claimableFETHRewardOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'claimableFETHRewardOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_claimableAETHFRewardOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'claimableAETHFRewardOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'claimableAETHFRewardOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_topUpETH() public virtual {
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'topUpETH()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'topUpETH()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_forceAdminProviderExit(address[] calldata a) public virtual {
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'forceAdminProviderExit(address[])', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'forceAdminProviderExit(address[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function GlobalPool_R43_softLockBlockNumber(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(globalPoolR42V1).call(
            abi.encodeWithSignature(
                'softLockBlockNumber(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(globalPoolR43V2).call(
            abi.encodeWithSignature(
                'softLockBlockNumber(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 


    /*** Tainted Variables ***/ 


    /*** Additional Targets ***/ 

    function AETH_R18_allowance(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_approve(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_bondsToShares(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'bondsToShares(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'bondsToShares(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_burn(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_decimals() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_increaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_initialize(string memory a, string memory b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'initialize(string,string)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'initialize(string,string)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_isPaused(bytes32 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'isPaused(bytes32)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'isPaused(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_isRebasing() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'isRebasing()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'isRebasing()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_mint(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_mintApprovedTo(address a, address b, uint256 c) public virtual {
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'mintApprovedTo(address,address,uint256)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'mintApprovedTo(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_name() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_owner() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_ratio() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'ratio()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'ratio()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_setNameAndSymbol(string memory a, string memory b) public virtual {
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'setNameAndSymbol(string,string)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'setNameAndSymbol(string,string)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_setNewNameAndSymbol() public virtual {
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'setNewNameAndSymbol()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'setNewNameAndSymbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_sharesToBonds(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'sharesToBonds(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'sharesToBonds(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_symbol() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_totalSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_updateRatio(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'updateRatio(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'updateRatio(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AETH_R18_updateRatioAndClaim(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(aETHR18V1).call(
            abi.encodeWithSignature(
                'updateRatioAndClaim(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(aETHR18V2).call(
            abi.encodeWithSignature(
                'updateRatioAndClaim(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
