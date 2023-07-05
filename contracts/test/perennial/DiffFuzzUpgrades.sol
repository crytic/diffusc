// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.17;

interface IBalancedVaultV1 {
    struct Version {
        uint256 longPosition;
        uint256 shortPosition;
        uint256 totalShares;
        uint256 longAssets;
        uint256 shortAssets;
        uint256 totalAssets;
    }
    struct VersionContext {
        uint256 version;
        uint256 latestCollateral;
        uint256 latestShares;
    }
    struct Accumulator {
        int256 maker;
        int256 taker;
    }
    struct PackedAccumulator {
        int128 maker;
        int128 taker;
    }
    struct PackedPosition {
        uint128 maker;
        uint128 taker;
    }
    struct PayoffDefinition {
        uint8 payoffType;
        uint8 payoffDirection;
        bytes30 data;
    }
    struct PendingFeeUpdates {
        bool makerFeeUpdated;
        uint64 pendingMakerFee;
        bool takerFeeUpdated;
        uint64 pendingTakerFee;
        bool positionFeeUpdated;
        uint64 pendingPositionFee;
    }
    struct Position {
        uint256 maker;
        uint256 taker;
    }
    struct PrePosition {
        uint256 oracleVersion;
        Position openPosition;
        Position closePosition;
    }
    struct ProgramInfo {
        uint256 coordinatorId;
        Position amount;
        uint256 start;
        uint256 duration;
        address token;
    }
    struct JumpRateUtilizationCurve {
        int128 minRate;
        int128 maxRate;
        int128 targetRate;
        uint128 targetUtilization;
    }
    function controller() external returns (address);
    function collateral() external returns (address);
    function long() external returns (address);
    function short() external returns (address);
    function targetLeverage() external returns (uint256);
    function maxCollateral() external returns (uint256);
    function asset() external returns (address);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function allowance(address,address) external returns (uint256);
    function initialize(string memory,string memory) external;
    function sync() external;
    function deposit(uint256,address) external;
    function redeem(uint256,address) external;
    function claim(address) external;
    function approve(address,uint256) external returns (bool);
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function decimals() external pure returns (uint8);
    function maxDeposit(address) external view returns (uint256);
    function maxRedeem(address) external view returns (uint256);
    function totalAssets() external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function totalUnclaimed() external view returns (uint256);
    function unclaimed(address) external view returns (uint256);
    function convertToShares(uint256) external view returns (uint256);
    function convertToAssets(uint256) external view returns (uint256);
}

interface IBalancedVaultV2 {
    struct Version {
        uint256 longPosition;
        uint256 shortPosition;
        uint256 totalShares;
        uint256 longAssets;
        uint256 shortAssets;
        uint256 totalAssets;
    }
    struct VersionContext {
        uint256 version;
        uint256 latestCollateral;
        uint256 latestShares;
    }
    struct Accumulator {
        int256 maker;
        int256 taker;
    }
    struct PackedAccumulator {
        int128 maker;
        int128 taker;
    }
    struct PackedPosition {
        uint128 maker;
        uint128 taker;
    }
    struct PayoffDefinition {
        uint8 payoffType;
        uint8 payoffDirection;
        bytes30 data;
    }
    struct PendingFeeUpdates {
        bool makerFeeUpdated;
        uint64 pendingMakerFee;
        bool takerFeeUpdated;
        uint64 pendingTakerFee;
        bool positionFeeUpdated;
        uint64 pendingPositionFee;
    }
    struct Position {
        uint256 maker;
        uint256 taker;
    }
    struct PrePosition {
        uint256 oracleVersion;
        Position openPosition;
        Position closePosition;
    }
    struct ProgramInfo {
        uint256 coordinatorId;
        Position amount;
        uint256 start;
        uint256 duration;
        address token;
    }
    struct JumpRateUtilizationCurve {
        int128 minRate;
        int128 maxRate;
        int128 targetRate;
        uint128 targetUtilization;
    }
    function controller() external returns (address);
    function collateral() external returns (address);
    function long() external returns (address);
    function short() external returns (address);
    function targetLeverage() external returns (uint256);
    function maxCollateral() external returns (uint256);
    function asset() external returns (address);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function allowance(address,address) external returns (uint256);
    function initialize(string memory,string memory) external;
    function sync() external;
    function deposit(uint256,address) external;
    function redeem(uint256,address) external;
    function claim(address) external;
    function approve(address,uint256) external returns (bool);
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function decimals() external pure returns (uint8);
    function maxDeposit(address) external view returns (uint256);
    function maxRedeem(address) external view returns (uint256);
    function totalAssets() external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function totalUnclaimed() external view returns (uint256);
    function unclaimed(address) external view returns (uint256);
    function convertToShares(uint256) external view returns (uint256);
    function convertToAssets(uint256) external view returns (uint256);
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

    IBalancedVaultV1 balancedVaultV1;
    IBalancedVaultV2 balancedVaultV2;
    ITransparentUpgradeableProxy transparentUpgradeableProxy;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

    struct Version {
        uint256 longPosition;
        uint256 shortPosition;
        uint256 totalShares;
        uint256 longAssets;
        uint256 shortAssets;
        uint256 totalAssets;
    }
    struct VersionContext {
        uint256 version;
        uint256 latestCollateral;
        uint256 latestShares;
    }
    struct Accumulator {
        int256 maker;
        int256 taker;
    }
    struct PackedAccumulator {
        int128 maker;
        int128 taker;
    }
    struct PackedPosition {
        uint128 maker;
        uint128 taker;
    }
    struct PayoffDefinition {
        uint8 payoffType;
        uint8 payoffDirection;
        bytes30 data;
    }
    struct PendingFeeUpdates {
        bool makerFeeUpdated;
        uint64 pendingMakerFee;
        bool takerFeeUpdated;
        uint64 pendingTakerFee;
        bool positionFeeUpdated;
        uint64 pendingPositionFee;
    }
    struct Position {
        uint256 maker;
        uint256 taker;
    }
    struct PrePosition {
        uint256 oracleVersion;
        Position openPosition;
        Position closePosition;
    }
    struct ProgramInfo {
        uint256 coordinatorId;
        Position amount;
        uint256 start;
        uint256 duration;
        address token;
    }
    struct JumpRateUtilizationCurve {
        int128 minRate;
        int128 maxRate;
        int128 targetRate;
        uint128 targetUtilization;
    }

    constructor() public {
        hevm.roll(104506900);
        hevm.warp(1687628716);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        balancedVaultV1 = IBalancedVaultV1(0x566ADeD4e644F40A6a943c40Bd40A2419d5D517F);
        balancedVaultV2 = IBalancedVaultV2(0xBcA6D5dE39C50A863D603702101AB776CE525C3a);
        transparentUpgradeableProxy = ITransparentUpgradeableProxy(0x5A572B5fBBC43387B5eF8de2C4728A4108ef24a6);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(balancedVaultV1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(balancedVaultV2))))
        );
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 

    function BalancedVault_sync() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'sync()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'sync()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BalancedVault_deposit(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'deposit(UFixed18,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'deposit(UFixed18,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BalancedVault_redeem(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'redeem(UFixed18,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'redeem(UFixed18,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function BalancedVault_claim(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'claim(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'claim(address)', a
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

}
