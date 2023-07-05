// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.17;

import { RewardsController as RewardsController_V1 } from "../../implementation/exactly/0x3a31a7e94b30bd92151b4711522f118902977c3c/RewardsController/contracts/RewardsController.sol";
import { RewardsController as RewardsController_V2 } from "../../implementation/exactly/0xc91dc7a797cd5fbcf6f334c792a2b24eff55292c/RewardsController/contracts/RewardsController.sol";
import { TransparentProxyTestHarness } from "../../implementation/exactly/TransparentProxyTestHarness.sol";
import { Market } from "../../implementation/exactly/0xc91dc7a797cd5fbcf6f334c792a2b24eff55292c/RewardsController/contracts/Market.sol";

interface IRewardsControllerV1 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct TotalMarketBalance {
        uint256 debt;
        uint256 supply;
        uint256 fixedBorrowShares;
    }
    struct TimeVars {
        uint256 start;
        uint256 end;
        uint256 period;
    }
    struct AllocationVars {
        uint256 utilization;
        uint256 sigmoid;
        uint256 borrowRewardRule;
        uint256 depositRewardRule;
        uint256 borrowAllocation;
        uint256 depositAllocation;
        uint256 transitionFactor;
        int256 flipSpeed;
        uint256 borrowAllocationWeightFactor;
    }
    struct AccountOperation {
        bool operation;
        uint256 balance;
    }
    struct MarketOperation {
        address market;
        bool[] operations;
    }
    struct AccountMarketOperation {
        address market;
        AccountOperation[] accountOperations;
    }
    struct Account {
        uint128 index;
        uint128 accrued;
    }
    struct Config {
        address market;
        address reward;
        address priceFeed;
        uint32 start;
        uint256 distributionPeriod;
        uint256 targetDebt;
        uint256 totalDistribution;
        uint256 undistributedFactor;
        int128 flipSpeed;
        uint64 compensationFactor;
        uint64 transitionFactor;
        uint64 borrowAllocationWeightFactor;
        uint64 depositAllocationWeightAddend;
        uint64 depositAllocationWeightFactor;
    }
    struct RewardData {
        uint256 targetDebt;
        uint256 releaseRate;
        uint256 totalDistribution;
        uint256 undistributedFactor;
        uint256 lastUndistributed;
        int128 flipSpeed;
        uint64 compensationFactor;
        uint64 transitionFactor;
        uint64 borrowAllocationWeightFactor;
        uint64 depositAllocationWeightAddend;
        uint64 depositAllocationWeightFactor;
        uint128 borrowIndex;
        uint128 depositIndex;
        uint32 start;
        uint32 end;
        uint32 lastUpdate;
        uint32 lastConfig;
        uint256 lastConfigReleased;
        address priceFeed;
        mapping(address => mapping(bool => Account)) accounts;
    }
    struct Distribution {
        mapping(address => RewardData) rewards;
        mapping(uint128 => address) availableRewards;
        uint8 availableRewardsCount;
        uint256 baseUnit;
    }
    struct MarketVars {
        uint256 price;
        uint256 baseUnit;
        uint128 adjustFactor;
    }
    struct LiquidityVars {
        uint256 totalDebt;
        uint256 totalCollateral;
        uint256 adjustedDebt;
        uint256 adjustedCollateral;
        uint256 seizeAvailable;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function UTILIZATION_CAP() external returns (uint256);
    function rewardEnabled(address) external returns (bool);
    function rewardList(uint256) external returns (address);
    function marketList(uint256) external returns (address);
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize() external;
    function handleDeposit(address) external;
    function handleBorrow(address) external;
    function claimAll(address) external returns (address[] memory,uint256[] memory);
    function claim(MarketOperation[] memory,address,address[] memory) external returns (address[] memory,uint256[] memory);
    function rewardConfig(address,address) external view returns (Config memory);
    function availableRewardsCount(address) external view returns (uint256);
    function accountOperation(address,address,bool,address) external view returns (uint256,uint256);
    function distributionTime(address,address) external view returns (uint32,uint32,uint32);
    function allRewards() external view returns (address[] memory);
    function allMarketsOperations() external view returns (MarketOperation[] memory);
    function allClaimable(address,address) external view returns (uint256);
    function claimable(MarketOperation[] memory,address,address) external view returns (uint256);
    function rewardIndexes(address,address) external view returns (uint256,uint256,uint256);
    function previewAllocation(address,address,uint256) external view returns (uint256,uint256,uint256);
    function withdraw(address,address) external;
    function config(Config[] memory) external;
}

interface IRewardsControllerV2 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct TotalMarketBalance {
        uint256 debt;
        uint256 supply;
        uint256 fixedBorrowShares;
    }
    struct TimeVars {
        uint256 start;
        uint256 end;
        uint256 period;
    }
    struct AllocationVars {
        uint256 utilization;
        uint256 sigmoid;
        uint256 borrowRewardRule;
        uint256 depositRewardRule;
        uint256 borrowAllocation;
        uint256 depositAllocation;
        uint256 transitionFactor;
        int256 flipSpeed;
        uint256 borrowAllocationWeightFactor;
    }
    struct AccountOperation {
        bool operation;
        uint256 balance;
    }
    struct MarketOperation {
        address market;
        bool[] operations;
    }
    struct AccountMarketOperation {
        address market;
        AccountOperation[] accountOperations;
    }
    struct Account {
        uint128 index;
        uint128 accrued;
    }
    struct Config {
        address market;
        address reward;
        address priceFeed;
        uint32 start;
        uint256 distributionPeriod;
        uint256 targetDebt;
        uint256 totalDistribution;
        uint256 undistributedFactor;
        int128 flipSpeed;
        uint64 compensationFactor;
        uint64 transitionFactor;
        uint64 borrowAllocationWeightFactor;
        uint64 depositAllocationWeightAddend;
        uint64 depositAllocationWeightFactor;
    }
    struct RewardData {
        uint256 targetDebt;
        uint256 releaseRate;
        uint256 totalDistribution;
        uint256 undistributedFactor;
        uint256 lastUndistributed;
        int128 flipSpeed;
        uint64 compensationFactor;
        uint64 transitionFactor;
        uint64 borrowAllocationWeightFactor;
        uint64 depositAllocationWeightAddend;
        uint64 depositAllocationWeightFactor;
        uint128 borrowIndex;
        uint128 depositIndex;
        uint32 start;
        uint32 end;
        uint32 lastUpdate;
        uint32 lastConfig;
        uint256 lastConfigReleased;
        address priceFeed;
        mapping(address => mapping(bool => Account)) accounts;
    }
    struct Distribution {
        mapping(address => RewardData) rewards;
        mapping(uint128 => address) availableRewards;
        uint8 availableRewardsCount;
        uint256 baseUnit;
    }
    struct MarketVars {
        uint256 price;
        uint256 baseUnit;
        uint128 adjustFactor;
    }
    struct LiquidityVars {
        uint256 totalDebt;
        uint256 totalCollateral;
        uint256 adjustedDebt;
        uint256 adjustedCollateral;
        uint256 seizeAvailable;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function UTILIZATION_CAP() external returns (uint256);
    function rewardEnabled(address) external returns (bool);
    function rewardList(uint256) external returns (address);
    function marketList(uint256) external returns (address);
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize() external;
    function handleDeposit(address) external;
    function handleBorrow(address) external;
    function claimAll(address) external returns (address[] memory,uint256[] memory);
    function claim(MarketOperation[] memory,address,address[] memory) external returns (address[] memory,uint256[] memory);
    function rewardConfig(address,address) external view returns (Config memory);
    function availableRewardsCount(address) external view returns (uint256);
    function accountOperation(address,address,bool,address) external view returns (uint256,uint256);
    function distributionTime(address,address) external view returns (uint32,uint32,uint32);
    function allRewards() external view returns (address[] memory);
    function allMarketsOperations() external view returns (MarketOperation[] memory);
    function allClaimable(address,address) external view returns (uint256);
    function claimable(MarketOperation[] memory,address,address) external view returns (uint256);
    function rewardIndexes(address,address) external view returns (uint256,uint256,uint256);
    function previewAllocation(address,address,uint256) external view returns (uint256,uint256,uint256);
    function withdraw(address,address) external;
    function config(Config[] memory) external;
}

interface IMarket {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct Account {
        uint256 fixedDeposits;
        uint256 fixedBorrows;
        uint256 floatingBorrowShares;
    }
    struct MarketVars {
        uint256 price;
        uint256 baseUnit;
        uint128 adjustFactor;
    }
    struct LiquidityVars {
        uint256 totalDebt;
        uint256 totalCollateral;
        uint256 adjustedDebt;
        uint256 adjustedCollateral;
        uint256 seizeAvailable;
    }
    struct Pool {
        uint256 borrowed;
        uint256 supplied;
        uint256 unassignedEarnings;
        uint256 lastAccrual;
    }
    struct Position {
        uint256 principal;
        uint256 fee;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function totalSupply() external returns (uint256);
    function balanceOf(address) external returns (uint256);
    function allowance(address,address) external returns (uint256);
    function nonces(address) external returns (uint256);
    function asset() external returns (address);
    function PAUSER_ROLE() external returns (bytes32);
    function auditor() external returns (address);
    function fixedDepositPositions(uint256,address) external returns (Position memory);
    function fixedBorrowPositions(uint256,address) external returns (Position memory);
    function fixedPools(uint256) external returns (Pool memory);
    function accounts(address) external returns (Account memory);
    function floatingBackupBorrowed() external returns (uint256);
    function floatingDebt() external returns (uint256);
    function earningsAccumulator() external returns (uint256);
    function penaltyRate() external returns (uint256);
    function backupFeeRate() external returns (uint256);
    function dampSpeedUp() external returns (uint256);
    function dampSpeedDown() external returns (uint256);
    function maxFuturePools() external returns (uint8);
    function lastAccumulatorAccrual() external returns (uint32);
    function lastFloatingDebtUpdate() external returns (uint32);
    function lastAverageUpdate() external returns (uint32);
    function interestRateModel() external returns (address);
    function earningsAccumulatorSmoothFactor() external returns (uint128);
    function reserveFactor() external returns (uint128);
    function floatingAssets() external returns (uint256);
    function floatingAssetsAverage() external returns (uint256);
    function totalFloatingBorrowShares() external returns (uint256);
    function treasury() external returns (address);
    function treasuryFeeRate() external returns (uint256);
    function rewardsController() external returns (address);
    function deposit(uint256,address) external returns (uint256);
    function mint(uint256,address) external returns (uint256);
    function convertToShares(uint256) external view returns (uint256);
    function convertToAssets(uint256) external view returns (uint256);
    function previewDeposit(uint256) external view returns (uint256);
    function previewMint(uint256) external view returns (uint256);
    function previewWithdraw(uint256) external view returns (uint256);
    function previewRedeem(uint256) external view returns (uint256);
    function maxDeposit(address) external view returns (uint256);
    function maxMint(address) external view returns (uint256);
    function maxWithdraw(address) external view returns (uint256);
    function maxRedeem(address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function permit(address,address,uint256,uint256,uint8,bytes32,bytes32) external;
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function paused() external view returns (bool);
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize(uint8,uint128,address,uint256,uint256,uint128,uint256,uint256) external;
    function borrow(uint256,address,address) external returns (uint256);
    function repay(uint256,address) external returns (uint256,uint256);
    function refund(uint256,address) external returns (uint256,uint256);
    function depositAtMaturity(uint256,uint256,uint256,address) external returns (uint256);
    function borrowAtMaturity(uint256,uint256,uint256,address,address) external returns (uint256);
    function withdrawAtMaturity(uint256,uint256,uint256,address,address) external returns (uint256);
    function repayAtMaturity(uint256,uint256,uint256,address) external returns (uint256);
    function liquidate(address,uint256,address) external returns (uint256);
    function clearBadDebt(address) external;
    function seize(address,address,uint256) external;
    function withdraw(uint256,address,address) external returns (uint256);
    function redeem(uint256,address,address) external returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function accountSnapshot(address) external view returns (uint256,uint256);
    function previewDebt(address) external view returns (uint256);
    function previewFloatingAssetsAverage() external view returns (uint256);
    function totalFloatingBorrowAssets() external view returns (uint256);
    function totalAssets() external view returns (uint256);
    function previewBorrow(uint256) external view returns (uint256);
    function previewRepay(uint256) external view returns (uint256);
    function previewRefund(uint256) external view returns (uint256);
    function fixedPoolBorrowed(uint256) external view returns (uint256);
    function fixedPoolBalance(uint256) external view returns (uint256,uint256);
    function setBackupFeeRate(uint256) external;
    function setDampSpeed(uint256,uint256) external;
    function setEarningsAccumulatorSmoothFactor(uint128) external;
    function setInterestRateModel(address) external;
    function setRewardsController(address) external;
    function setMaxFuturePools(uint8) external;
    function setPenaltyRate(uint256) external;
    function setReserveFactor(uint128) external;
    function setTreasury(address,uint256) external;
    function pause() external;
    function unpause() external;
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

    IRewardsControllerV1 rewardsControllerV1;
    IRewardsControllerV2 rewardsControllerV2;
    ITransparentProxyTestHarness transparentProxyTestHarnessV1;
    ITransparentProxyTestHarness transparentProxyTestHarnessV2;
    IMarket marketV1;
    IMarket marketV2;
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct TotalMarketBalance {
        uint256 debt;
        uint256 supply;
        uint256 fixedBorrowShares;
    }
    struct TimeVars {
        uint256 start;
        uint256 end;
        uint256 period;
    }
    struct AllocationVars {
        uint256 utilization;
        uint256 sigmoid;
        uint256 borrowRewardRule;
        uint256 depositRewardRule;
        uint256 borrowAllocation;
        uint256 depositAllocation;
        uint256 transitionFactor;
        int256 flipSpeed;
        uint256 borrowAllocationWeightFactor;
    }
    struct AccountOperation {
        bool operation;
        uint256 balance;
    }
    struct MarketOperation {
        address market;
        bool[] operations;
    }
    struct AccountMarketOperation {
        address market;
        AccountOperation[] accountOperations;
    }
    struct Account {
        uint128 index;
        uint128 accrued;
    }
    struct Config {
        address market;
        address reward;
        address priceFeed;
        uint32 start;
        uint256 distributionPeriod;
        uint256 targetDebt;
        uint256 totalDistribution;
        uint256 undistributedFactor;
        int128 flipSpeed;
        uint64 compensationFactor;
        uint64 transitionFactor;
        uint64 borrowAllocationWeightFactor;
        uint64 depositAllocationWeightAddend;
        uint64 depositAllocationWeightFactor;
    }
    struct RewardData {
        uint256 targetDebt;
        uint256 releaseRate;
        uint256 totalDistribution;
        uint256 undistributedFactor;
        uint256 lastUndistributed;
        int128 flipSpeed;
        uint64 compensationFactor;
        uint64 transitionFactor;
        uint64 borrowAllocationWeightFactor;
        uint64 depositAllocationWeightAddend;
        uint64 depositAllocationWeightFactor;
        uint128 borrowIndex;
        uint128 depositIndex;
        uint32 start;
        uint32 end;
        uint32 lastUpdate;
        uint32 lastConfig;
        uint256 lastConfigReleased;
        address priceFeed;
        mapping(address => mapping(bool => Account)) accounts;
    }
    struct Distribution {
        mapping(address => RewardData) rewards;
        mapping(uint128 => address) availableRewards;
        uint8 availableRewardsCount;
        uint256 baseUnit;
    }
    struct MarketVars {
        uint256 price;
        uint256 baseUnit;
        uint128 adjustFactor;
    }
    struct LiquidityVars {
        uint256 totalDebt;
        uint256 totalCollateral;
        uint256 adjustedDebt;
        uint256 adjustedCollateral;
        uint256 seizeAvailable;
    }

    constructor() public {
        rewardsControllerV1 = IRewardsControllerV1(address(new RewardsController_V1()));
        rewardsControllerV2 = IRewardsControllerV2(address(new RewardsController_V2()));
        transparentProxyTestHarnessV1 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        transparentProxyTestHarnessV2 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        // Store the implementation addresses in the proxy.
        hevm.store(
            address(transparentProxyTestHarnessV1),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(rewardsControllerV1))))
        );
        hevm.store(
            address(transparentProxyTestHarnessV2),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(rewardsControllerV2))))
        );
//        marketV1 = IMarket(address(new Market()));
//        marketV2 = IMarket(address(new Market()));
    }


    /*** Modified Functions ***/ 

    function RewardsController_handleDeposit(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'handleDeposit(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'handleDeposit(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_handleBorrow(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'handleBorrow(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'handleBorrow(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_claim(MarketOperation[] memory a, address b, address[] memory c) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'claim(RewardsController.MarketOperation[],address,ERC20[])', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claim(RewardsController.MarketOperation[],address,ERC20[])', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_accountOperation(address a, address b, bool c, address d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'accountOperation(address,Market,bool,ERC20)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'accountOperation(address,Market,bool,ERC20)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_distributionTime(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'distributionTime(Market,ERC20)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'distributionTime(Market,ERC20)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_claimable(MarketOperation[] memory a, address b, address c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'claimable(RewardsController.MarketOperation[],address,ERC20)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claimable(RewardsController.MarketOperation[],address,ERC20)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_rewardIndexes(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'rewardIndexes(Market,ERC20)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'rewardIndexes(Market,ERC20)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_config(Config[] memory a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'config(RewardsController.Config[])', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'config(RewardsController.Config[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function RewardsController_claimAll(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'claimAll(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claimAll(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_rewardConfig(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'rewardConfig(Market,ERC20)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'rewardConfig(Market,ERC20)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_availableRewardsCount(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'availableRewardsCount(Market)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'availableRewardsCount(Market)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_allRewards() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'allRewards()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'allRewards()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_allMarketsOperations() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'allMarketsOperations()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'allMarketsOperations()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_allClaimable(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'allClaimable(address,ERC20)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'allClaimable(address,ERC20)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function RewardsController_previewAllocation(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'previewAllocation(Market,ERC20,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'previewAllocation(Market,ERC20,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 


    /*** Tainted Variables ***/ 

    function RewardsController_rewardEnabled(address a) public virtual returns (bool) {
        assert(IRewardsControllerV1(address(transparentProxyTestHarnessV1)).rewardEnabled(a) == IRewardsControllerV2(address(transparentProxyTestHarnessV2)).rewardEnabled(a));
        return IRewardsControllerV1(address(transparentProxyTestHarnessV1)).rewardEnabled(a);
    }

    function RewardsController_rewardList(uint i) public virtual returns (address) {
        assert(IRewardsControllerV1(address(transparentProxyTestHarnessV1)).rewardList(i) == IRewardsControllerV2(address(transparentProxyTestHarnessV2)).rewardList(i));
        return IRewardsControllerV1(address(transparentProxyTestHarnessV1)).rewardList(i);
    }

    function RewardsController_marketList(uint i) public virtual returns (address) {
        assert(IRewardsControllerV1(address(transparentProxyTestHarnessV1)).marketList(i) == IRewardsControllerV2(address(transparentProxyTestHarnessV2)).marketList(i));
        return IRewardsControllerV1(address(transparentProxyTestHarnessV1)).marketList(i);
    }


    /*** Additional Targets ***/ 

    function Market_DOMAIN_SEPARATOR() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'DOMAIN_SEPARATOR()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'DOMAIN_SEPARATOR()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_accountSnapshot(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'accountSnapshot(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'accountSnapshot(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_approve(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_borrow(uint256 a, address b, address c) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'borrow(uint256,address,address)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'borrow(uint256,address,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_borrowAtMaturity(uint256 a, uint256 b, uint256 c, address d, address e) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'borrowAtMaturity(uint256,uint256,uint256,address,address)', a, b, c, d, e
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'borrowAtMaturity(uint256,uint256,uint256,address,address)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_clearBadDebt(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'clearBadDebt(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'clearBadDebt(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_convertToAssets(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'convertToAssets(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'convertToAssets(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_convertToShares(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'convertToShares(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'convertToShares(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_deposit(uint256 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'deposit(uint256,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'deposit(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_depositAtMaturity(uint256 a, uint256 b, uint256 c, address d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'depositAtMaturity(uint256,uint256,uint256,address)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'depositAtMaturity(uint256,uint256,uint256,address)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_fixedPoolBalance(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'fixedPoolBalance(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'fixedPoolBalance(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_fixedPoolBorrowed(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'fixedPoolBorrowed(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'fixedPoolBorrowed(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_getRoleAdmin(bytes32 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_grantRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_hasRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_initialize(uint8 a, uint128 b, address c, uint256 d, uint256 e, uint128 f, uint256 g, uint256 h) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'initialize(uint8,uint128,InterestRateModel,uint256,uint256,uint128,uint256,uint256)', a, b, c, d, e, f, g, h
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'initialize(uint8,uint128,InterestRateModel,uint256,uint256,uint128,uint256,uint256)', a, b, c, d, e, f, g, h
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_liquidate(address a, uint256 b, address c) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'liquidate(address,uint256,Market)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'liquidate(address,uint256,Market)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_maxDeposit(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'maxDeposit(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'maxDeposit(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_maxMint(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'maxMint(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'maxMint(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_maxRedeem(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'maxRedeem(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'maxRedeem(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_maxWithdraw(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'maxWithdraw(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'maxWithdraw(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_mint(uint256 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'mint(uint256,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'mint(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_pause() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_paused() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_permit(address a, address b, uint256 c, uint256 d, uint8 e, bytes32 f, bytes32 g) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewBorrow(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewBorrow(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewBorrow(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewDebt(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewDebt(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewDebt(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewDeposit(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewDeposit(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewDeposit(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewFloatingAssetsAverage() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewFloatingAssetsAverage()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewFloatingAssetsAverage()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewMint(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewMint(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewMint(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewRedeem(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewRedeem(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewRedeem(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewRefund(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewRefund(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewRefund(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewRepay(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewRepay(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewRepay(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_previewWithdraw(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'previewWithdraw(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'previewWithdraw(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_redeem(uint256 a, address b, address c) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'redeem(uint256,address,address)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'redeem(uint256,address,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_refund(uint256 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'refund(uint256,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'refund(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_renounceRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_repay(uint256 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'repay(uint256,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'repay(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_repayAtMaturity(uint256 a, uint256 b, uint256 c, address d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'repayAtMaturity(uint256,uint256,uint256,address)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'repayAtMaturity(uint256,uint256,uint256,address)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_revokeRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_seize(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'seize(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'seize(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setBackupFeeRate(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setBackupFeeRate(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setBackupFeeRate(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setDampSpeed(uint256 a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setDampSpeed(uint256,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setDampSpeed(uint256,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setEarningsAccumulatorSmoothFactor(uint128 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setEarningsAccumulatorSmoothFactor(uint128)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setEarningsAccumulatorSmoothFactor(uint128)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setInterestRateModel(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setInterestRateModel(InterestRateModel)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setInterestRateModel(InterestRateModel)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setMaxFuturePools(uint8 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setMaxFuturePools(uint8)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setMaxFuturePools(uint8)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setPenaltyRate(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setPenaltyRate(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setPenaltyRate(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setReserveFactor(uint128 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setReserveFactor(uint128)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setReserveFactor(uint128)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setRewardsController(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setRewardsController(RewardsController)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setRewardsController(RewardsController)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_setTreasury(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'setTreasury(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'setTreasury(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_supportsInterface(bytes4 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_totalAssets() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'totalAssets()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'totalAssets()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_totalFloatingBorrowAssets() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'totalFloatingBorrowAssets()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'totalFloatingBorrowAssets()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_unpause() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_withdraw(uint256 a, address b, address c) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'withdraw(uint256,address,address)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'withdraw(uint256,address,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Market_withdrawAtMaturity(uint256 a, uint256 b, uint256 c, address d, address e) public virtual {
        (bool successV1, bytes memory outputV1) = address(marketV1).call(
            abi.encodeWithSignature(
                'withdrawAtMaturity(uint256,uint256,uint256,address,address)', a, b, c, d, e
            )
        );
        (bool successV2, bytes memory outputV2) = address(marketV2).call(
            abi.encodeWithSignature(
                'withdrawAtMaturity(uint256,uint256,uint256,address,address)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
