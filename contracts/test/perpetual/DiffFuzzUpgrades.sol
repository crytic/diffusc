// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.7.6;

pragma abicoder v2;

interface IVaultV1 {
    function getTrustedForwarder() external view returns (address);
    function versionRecipient() external pure returns (string memory);
    function isTrustedForwarder(address) external view returns (bool);
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
    function renounceOwnership() external;
    function setOwner(address) external;
    function updateOwner() external;
    function owner() external view returns (address);
    function candidate() external view returns (address);
    function initialize(address,address,address,address) external;
    function setTrustedForwarder(address) external;
    function setClearingHouse(address) external;
    function setCollateralManager(address) external;
    function setWETH9(address) external;
    function deposit(address,uint256) external;
    function depositFor(address,address,uint256) external;
    function depositEther() external payable;
    function depositEtherFor(address) external payable;
    function withdraw(address,uint256) external;
    function withdrawEther(uint256) external;
    function withdrawAll(address) external returns (uint256);
    function withdrawAllEther() external returns (uint256);
    function liquidateCollateral(address,address,uint256,bool) external returns (uint256);
    function getSettlementToken() external view returns (address);
    function decimals() external view returns (uint8);
    function getTotalDebt() external view returns (uint256);
    function getClearingHouseConfig() external view returns (address);
    function getAccountBalance() external view returns (address);
    function getInsuranceFund() external view returns (address);
    function getExchange() external view returns (address);
    function getClearingHouse() external view returns (address);
    function getCollateralManager() external view returns (address);
    function getWETH9() external view returns (address);
    function getFreeCollateral(address) external view returns (uint256);
    function getFreeCollateralByRatio(address,uint24) external view returns (int256);
    function getSettlementTokenValue(address) external view returns (int256);
    function getAccountValue(address) external view returns (int256);
    function getCollateralTokens(address) external view returns (address[] memory);
    function getBalance(address) external view returns (int256);
    function getBalanceByToken(address,address) external view returns (int256);
    function getFreeCollateralByToken(address,address) external view returns (uint256);
    function isLiquidatable(address) external view returns (bool);
    function getMarginRequirementForCollateralLiquidation(address) external view returns (int256);
    function getCollateralMmRatio() external view returns (uint24);
    function getRepaidSettlementByCollateral(address,uint256) external view returns (uint256);
    function getLiquidatableCollateralBySettlement(address,uint256) external view returns (uint256);
    function getMaxRepaidSettlementAndLiquidatableCollateral(address,address) external view returns (uint256,uint256);
    function settleBadDebt(address) external;
}

interface IVaultV2 {
    function getTrustedForwarder() external view returns (address);
    function versionRecipient() external pure returns (string memory);
    function isTrustedForwarder(address) external view returns (bool);
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
    function renounceOwnership() external;
    function setOwner(address) external;
    function updateOwner() external;
    function owner() external view returns (address);
    function candidate() external view returns (address);
    function initialize(address,address,address,address) external;
    function setTrustedForwarder(address) external;
    function setClearingHouse(address) external;
    function setCollateralManager(address) external;
    function setWETH9(address) external;
    function deposit(address,uint256) external;
    function depositFor(address,address,uint256) external;
    function depositEther() external payable;
    function depositEtherFor(address) external payable;
    function withdraw(address,uint256) external;
    function withdrawEther(uint256) external;
    function withdrawAll(address) external returns (uint256);
    function withdrawAllEther() external returns (uint256);
    function liquidateCollateral(address,address,uint256,bool) external returns (uint256);
    function getSettlementToken() external view returns (address);
    function decimals() external view returns (uint8);
    function getTotalDebt() external view returns (uint256);
    function getClearingHouseConfig() external view returns (address);
    function getAccountBalance() external view returns (address);
    function getInsuranceFund() external view returns (address);
    function getExchange() external view returns (address);
    function getClearingHouse() external view returns (address);
    function getCollateralManager() external view returns (address);
    function getWETH9() external view returns (address);
    function getFreeCollateral(address) external view returns (uint256);
    function getFreeCollateralByRatio(address,uint24) external view returns (int256);
    function getSettlementTokenValue(address) external view returns (int256);
    function getAccountValue(address) external view returns (int256);
    function getCollateralTokens(address) external view returns (address[] memory);
    function getBalance(address) external view returns (int256);
    function getBalanceByToken(address,address) external view returns (int256);
    function getFreeCollateralByToken(address,address) external view returns (uint256);
    function isLiquidatable(address) external view returns (bool);
    function getMarginRequirementForCollateralLiquidation(address) external view returns (int256);
    function getCollateralMmRatio() external view returns (uint24);
    function getRepaidSettlementByCollateral(address,uint256) external view returns (uint256);
    function getLiquidatableCollateralBySettlement(address,uint256) external view returns (uint256);
    function getMaxRepaidSettlementAndLiquidatableCollateral(address,address) external view returns (uint256,uint256);
    function settleBadDebt(address) external;
}

interface IBaseToken {
    enum Status { Open, Paused, Closed }
    function mintMaximumTo(address) external;
    function addWhitelist(address) external;
    function removeWhitelist(address) external;
    function isInWhitelist(address) external view returns (bool);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function renounceOwnership() external;
    function setOwner(address) external;
    function updateOwner() external;
    function owner() external view returns (address);
    function candidate() external view returns (address);
    function initialize(string memory,string memory,address) external;
    function pause() external;
    function close(uint256) external;
    function close() external;
    function setPriceFeed(address) external;
    function cacheTwap(uint256) external;
    function getPriceFeed() external view returns (address);
    function isOpen() external view returns (bool);
    function isPaused() external view returns (bool);
    function isClosed() external view returns (bool);
    function getPausedTimestamp() external view returns (uint256);
    function getPausedIndexPrice() external view returns (uint256);
    function getClosedPrice() external view returns (uint256);
    function getIndexPrice(uint256) external view returns (uint256);
}

interface IQuoteToken {
    function mintMaximumTo(address) external;
    function addWhitelist(address) external;
    function removeWhitelist(address) external;
    function isInWhitelist(address) external view returns (bool);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function renounceOwnership() external;
    function setOwner(address) external;
    function updateOwner() external;
    function owner() external view returns (address);
    function candidate() external view returns (address);
    function initialize(string memory,string memory) external;
}

interface ITransparentUpgradeableProxy {
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

    IVaultV1 vaultV1;
    IVaultV2 vaultV2;
    ITransparentUpgradeableProxy transparentUpgradeableProxy;
    IBaseToken baseToken;
    IQuoteToken quoteToken;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);


    constructor() public {
        hevm.roll(97168905);
        hevm.warp(1683691809);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        vaultV1 = IVaultV1(0xD24b8feEeA13A0EcCe247e37E8AD1a0b2620Fc5B);
        vaultV2 = IVaultV2(0x2F8508fc4BFe338b944A9b93B05A9B9725590023);
        transparentUpgradeableProxy = ITransparentUpgradeableProxy(0xAD7b4C162707E0B2b5f6fdDbD3f8538A5fbA0d60);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(vaultV1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(vaultV2))))
        );
        baseToken = IBaseToken(0x34235C8489b06482A99bb7fcaB6d7c467b92d248);
        quoteToken = IQuoteToken(0xC84Da6c8ec7A57cD10B939E79eaF9d2D17834E04);
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 


    /*** New Functions ***/ 


    /*** Tainted Variables ***/ 


    /*** Additional Targets ***/ 

    function BaseToken_allowance(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_cacheTwap(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'cacheTwap(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'cacheTwap(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_candidate() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'candidate()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'candidate()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_close() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'close()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'close()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_decimals() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_getClosedPrice() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'getClosedPrice()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'getClosedPrice()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_getIndexPrice(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'getIndexPrice(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'getIndexPrice(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_getPausedIndexPrice() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'getPausedIndexPrice()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'getPausedIndexPrice()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_getPausedTimestamp() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'getPausedTimestamp()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'getPausedTimestamp()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_getPriceFeed() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'getPriceFeed()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'getPriceFeed()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_increaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_initialize(string memory a, string memory b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'initialize(string,string,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'initialize(string,string,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_isClosed() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'isClosed()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'isClosed()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_isInWhitelist(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'isInWhitelist(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'isInWhitelist(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_isOpen() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'isOpen()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'isOpen()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_isPaused() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'isPaused()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'isPaused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_name() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_owner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_symbol() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_totalSupply() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BaseToken_updateOwner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(baseToken).call(
            abi.encodeWithSignature(
                'updateOwner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(baseToken).call(
            abi.encodeWithSignature(
                'updateOwner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_allowance(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_candidate() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'candidate()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'candidate()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_decimals() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_increaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_initialize(string memory a, string memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'initialize(string,string)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'initialize(string,string)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_isInWhitelist(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'isInWhitelist(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'isInWhitelist(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_name() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_owner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_symbol() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_totalSupply() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function QuoteToken_updateOwner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(quoteToken).call(
            abi.encodeWithSignature(
                'updateOwner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(quoteToken).call(
            abi.encodeWithSignature(
                'updateOwner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
