// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.11;

import { Safemoon as Safemoon_V1 } from "../../../Safemoon.sol";
import { Safemoon_23 as Safemoon_23_V2 } from "../../../mutants/Safemoon_23.sol";
import { TransparentProxyTestHarness } from "../../../TransparentProxyTestHarness.sol";

interface ISafemoonV1 {
    struct FeeTier {
        uint256 ecoSystemFee;
        uint256 liquidityFee;
        uint256 taxFee;
        uint256 ownerFee;
        uint256 burnFee;
        address ecoSystem;
        address owner;
    }
    struct FeeValues {
        uint256 rAmount;
        uint256 rTransferAmount;
        uint256 rFee;
        uint256 tTransferAmount;
        uint256 tEchoSystem;
        uint256 tLiquidity;
        uint256 tFee;
        uint256 tOwner;
        uint256 tBurn;
    }
    struct tFeeValues {
        uint256 tTransferAmount;
        uint256 tEchoSystem;
        uint256 tLiquidity;
        uint256 tFee;
        uint256 tOwner;
        uint256 tBurn;
    }
    function _defaultFees() external returns (FeeTier memory);
    function uniswapV2Router() external returns (address);
    function uniswapV2Pair() external returns (address);
    function WBNB() external returns (address);
    function _burnAddress() external returns (address);
    function swapAndLiquifyEnabled() external returns (bool);
    function _maxTxAmount() external returns (uint256);
    function numTokensToCollectBNB() external returns (uint256);
    function numOfBnbToSwapAndEvolve() external returns (uint256);
    function swapAndEvolveEnabled() external returns (bool);
    function listIgnoreCollectBNBAddresses(address) external returns (bool);
    function bridgeBurnAddress() external returns (address);
    function whitelistMint(address) external returns (bool);
    function isPaused() external returns (bool);
    function whitelistPause(address) external returns (bool);
    function isSFMPair(address) external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize() external;
    function initRouterAndPair(address) external;
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function isExcludedFromReward(address) external view returns (bool);
    function totalFees() external view returns (uint256);
    function reflectionFromTokenInTiers(uint256,uint256,bool) external view returns (uint256);
    function reflectionFromToken(uint256,bool) external view returns (uint256);
    function tokenFromReflection(uint256) external view returns (uint256);
    function excludeFromReward(address) external;
    function includeInReward(address) external;
    function excludeFromFee(address) external;
    function includeInFee(address) external;
    function whitelistAddress(address,uint256) external;
    function excludeWhitelistedAddress(address) external;
    function accountTier(address) external view returns (FeeTier memory);
    function isWhitelisted(address) external view returns (bool);
    function setEcoSystemFeePercent(uint256,uint256) external;
    function setLiquidityFeePercent(uint256,uint256) external;
    function setTaxFeePercent(uint256,uint256) external;
    function setOwnerFeePercent(uint256,uint256) external;
    function setBurnFeePercent(uint256,uint256) external;
    function setEcoSystemFeeAddress(uint256,address) external;
    function setOwnerFeeAddress(uint256,address) external;
    function addTier(uint256,uint256,uint256,uint256,uint256,address,address) external;
    function feeTier(uint256) external view returns (FeeTier memory);
    function blacklistAddress(address) external;
    function unBlacklistAddress(address) external;
    function updateRouterAndPair(address,address) external;
    function setDefaultSettings() external;
    function setMaxTxPercent(uint256) external;
    function setSwapAndEvolveEnabled(bool) external;
    function isExcludedFromFee(address) external view returns (bool);
    function isBlacklisted(address) external view returns (bool);
    function swapAndEvolve() external;
    function setMigrationAddress(address) external;
    function isMigrationStarted() external view returns (bool);
    function migrate(address,uint256) external;
    function feeTiersLength() external view returns (uint256);
    function updateBurnAddress(address) external;
    function withdrawToken(address,uint256) external;
    function setNumberOfTokenToCollectBNB(uint256) external;
    function setNumOfBnbToSwapAndEvolve(uint256) external;
    function getContractBalance() external view returns (uint256);
    function getBNBBalance() external view returns (uint256);
    function withdrawBnb(uint256) external;
    function addListIgnoreCollectBNBOnTransferAddresses(address[] calldata) external;
    function removeListIgnoreCollectBNBOnTransferAddresses(address[] calldata) external;
    function setBridgeBurnAddress(address) external;
    function setWhitelistMintBurn(address,bool) external;
    function mint(address,uint256) external;
    function burn(uint256) external;
    function setWhitelistPause(address,bool) external;
    function setPause(bool) external;
    function setSFMPair(address,bool) external;
}

interface ISafemoon_23V2 {
    struct FeeTier {
        uint256 ecoSystemFee;
        uint256 liquidityFee;
        uint256 taxFee;
        uint256 ownerFee;
        uint256 burnFee;
        address ecoSystem;
        address owner;
    }
    struct FeeValues {
        uint256 rAmount;
        uint256 rTransferAmount;
        uint256 rFee;
        uint256 tTransferAmount;
        uint256 tEchoSystem;
        uint256 tLiquidity;
        uint256 tFee;
        uint256 tOwner;
        uint256 tBurn;
    }
    struct tFeeValues {
        uint256 tTransferAmount;
        uint256 tEchoSystem;
        uint256 tLiquidity;
        uint256 tFee;
        uint256 tOwner;
        uint256 tBurn;
    }
    function _defaultFees() external returns (FeeTier memory);
    function uniswapV2Router() external returns (address);
    function uniswapV2Pair() external returns (address);
    function WBNB() external returns (address);
    function _burnAddress() external returns (address);
    function swapAndLiquifyEnabled() external returns (bool);
    function _maxTxAmount() external returns (uint256);
    function numTokensToCollectBNB() external returns (uint256);
    function numOfBnbToSwapAndEvolve() external returns (uint256);
    function swapAndEvolveEnabled() external returns (bool);
    function listIgnoreCollectBNBAddresses(address) external returns (bool);
    function bridgeBurnAddress() external returns (address);
    function whitelistMint(address) external returns (bool);
    function isPaused() external returns (bool);
    function whitelistPause(address) external returns (bool);
    function isSFMPair(address) external returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initialize() external;
    function initRouterAndPair(address) external;
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function isExcludedFromReward(address) external view returns (bool);
    function totalFees() external view returns (uint256);
    function reflectionFromTokenInTiers(uint256,uint256,bool) external view returns (uint256);
    function reflectionFromToken(uint256,bool) external view returns (uint256);
    function tokenFromReflection(uint256) external view returns (uint256);
    function excludeFromReward(address) external;
    function includeInReward(address) external;
    function excludeFromFee(address) external;
    function includeInFee(address) external;
    function whitelistAddress(address,uint256) external;
    function excludeWhitelistedAddress(address) external;
    function accountTier(address) external view returns (FeeTier memory);
    function isWhitelisted(address) external view returns (bool);
    function setEcoSystemFeePercent(uint256,uint256) external;
    function setLiquidityFeePercent(uint256,uint256) external;
    function setTaxFeePercent(uint256,uint256) external;
    function setOwnerFeePercent(uint256,uint256) external;
    function setBurnFeePercent(uint256,uint256) external;
    function setEcoSystemFeeAddress(uint256,address) external;
    function setOwnerFeeAddress(uint256,address) external;
    function addTier(uint256,uint256,uint256,uint256,uint256,address,address) external;
    function feeTier(uint256) external view returns (FeeTier memory);
    function blacklistAddress(address) external;
    function unBlacklistAddress(address) external;
    function updateRouterAndPair(address,address) external;
    function setDefaultSettings() external;
    function setMaxTxPercent(uint256) external;
    function setSwapAndEvolveEnabled(bool) external;
    function isExcludedFromFee(address) external view returns (bool);
    function isBlacklisted(address) external view returns (bool);
    function swapAndEvolve() external;
    function setMigrationAddress(address) external;
    function isMigrationStarted() external view returns (bool);
    function migrate(address,uint256) external;
    function feeTiersLength() external view returns (uint256);
    function updateBurnAddress(address) external;
    function withdrawToken(address,uint256) external;
    function setNumberOfTokenToCollectBNB(uint256) external;
    function setNumOfBnbToSwapAndEvolve(uint256) external;
    function getContractBalance() external view returns (uint256);
    function getBNBBalance() external view returns (uint256);
    function withdrawBnb(uint256) external;
    function addListIgnoreCollectBNBOnTransferAddresses(address[] calldata) external;
    function removeListIgnoreCollectBNBOnTransferAddresses(address[] calldata) external;
    function setBridgeBurnAddress(address) external;
    function setWhitelistMintBurn(address,bool) external;
    function mint(address,uint256) external;
    function burn(uint256) external;
    function setWhitelistPause(address,bool) external;
    function setPause(bool) external;
    function setSFMPair(address,bool) external;
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

    ISafemoonV1 safemoonV1;
    ISafemoon_23V2 safemoon23V2;
    ITransparentProxyTestHarness transparentProxyTestHarnessV1;
    ITransparentProxyTestHarness transparentProxyTestHarnessV2;
    struct FeeTier {
        uint256 ecoSystemFee;
        uint256 liquidityFee;
        uint256 taxFee;
        uint256 ownerFee;
        uint256 burnFee;
        address ecoSystem;
        address owner;
    }
    struct FeeValues {
        uint256 rAmount;
        uint256 rTransferAmount;
        uint256 rFee;
        uint256 tTransferAmount;
        uint256 tEchoSystem;
        uint256 tLiquidity;
        uint256 tFee;
        uint256 tOwner;
        uint256 tBurn;
    }
    struct tFeeValues {
        uint256 tTransferAmount;
        uint256 tEchoSystem;
        uint256 tLiquidity;
        uint256 tFee;
        uint256 tOwner;
        uint256 tBurn;
    }

    constructor() public {
        safemoonV1 = ISafemoonV1(address(new Safemoon_V1()));
        safemoon23V2 = ISafemoon_23V2(address(new Safemoon_23_V2()));
        transparentProxyTestHarnessV1 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        transparentProxyTestHarnessV2 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        // Store the implementation addresses in the proxy.
        hevm.store(
            address(transparentProxyTestHarnessV1),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(safemoonV1))))
        );
        hevm.store(
            address(transparentProxyTestHarnessV2),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(safemoon23V2))))
        );
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 

    function Safemoon_23_initialize() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'initialize()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'initialize()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_reflectionFromTokenInTiers(uint256 a, uint256 b, bool c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'reflectionFromTokenInTiers(uint256,uint256,bool)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'reflectionFromTokenInTiers(uint256,uint256,bool)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_reflectionFromToken(uint256 a, bool b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'reflectionFromToken(uint256,bool)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'reflectionFromToken(uint256,bool)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_tokenFromReflection(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'tokenFromReflection(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'tokenFromReflection(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_excludeFromReward(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'excludeFromReward(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'excludeFromReward(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_includeInReward(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'includeInReward(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'includeInReward(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_setEcoSystemFeeAddress(uint256 a, address b) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'setEcoSystemFeeAddress(uint256,address)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setEcoSystemFeeAddress(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_setOwnerFeeAddress(uint256 a, address b) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'setOwnerFeeAddress(uint256,address)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setOwnerFeeAddress(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_addTier(uint256 a, uint256 b, uint256 c, uint256 d, uint256 e, address f, address g) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'addTier(uint256,uint256,uint256,uint256,uint256,address,address)', a, b, c, d, e, f, g
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'addTier(uint256,uint256,uint256,uint256,uint256,address,address)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_migrate(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'migrate(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'migrate(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_updateBurnAddress(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'updateBurnAddress(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'updateBurnAddress(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_getContractBalance() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getContractBalance()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getContractBalance()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_mint(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_23_burn(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 


    /*** Tainted Variables ***/ 

    function Safemoon__burnAddress() public virtual returns (address) {
        assert(ISafemoonV1(address(transparentProxyTestHarnessV1))._burnAddress() == ISafemoon_23V2(address(transparentProxyTestHarnessV2))._burnAddress());
        return ISafemoonV1(address(transparentProxyTestHarnessV1))._burnAddress();
    }

    function Safemoon__maxTxAmount() public virtual returns (uint256) {
        assert(ISafemoonV1(address(transparentProxyTestHarnessV1))._maxTxAmount() == ISafemoon_23V2(address(transparentProxyTestHarnessV2))._maxTxAmount());
        return ISafemoonV1(address(transparentProxyTestHarnessV1))._maxTxAmount();
    }


    /*** Additional Targets ***/ 

}
