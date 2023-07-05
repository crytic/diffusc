// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.7;

interface IPoolManagerV1 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct StrategyParams {
        uint256 lastReport;
        uint256 totalStrategyDebt;
        uint256 debtRatio;
    }
    struct MintBurnData {
        uint64[] xFeeMint;
        uint64[] yFeeMint;
        uint64[] xFeeBurn;
        uint64[] yFeeBurn;
        uint64 targetHAHedge;
        uint64 bonusMalusMint;
        uint64 bonusMalusBurn;
        uint256 capOnStableMinted;
    }
    struct SLPData {
        uint256 lastBlockUpdated;
        uint256 lockedInterests;
        uint256 maxInterestsDistributed;
        uint256 feesAside;
        uint64 slippageFee;
        uint64 feesForSLPs;
        uint64 slippage;
        uint64 interestsForSLPs;
    }
    function BASE_TOKENS() external returns (uint256);
    function BASE_PARAMS() external returns (uint256);
    function token() external returns (address);
    function perpetualManager() external returns (address);
    function stableMaster() external returns (address);
    function feeManager() external returns (address);
    function totalDebt() external returns (uint256);
    function debtRatio() external returns (uint256);
    function strategies(address) external returns (StrategyParams memory);
    function strategyList(uint256) external returns (address);
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function STABLEMASTER_ROLE() external returns (bytes32);
    function GOVERNOR_ROLE() external returns (bytes32);
    function GUARDIAN_ROLE() external returns (bytes32);
    function STRATEGY_ROLE() external returns (bytes32);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize(address,address) external;
    function deployCollateral(address[] memory,address,address,address,address) external;
    function addGovernor(address) external;
    function removeGovernor(address) external;
    function setGuardian(address,address) external;
    function revokeGuardian(address) external;
    function setFeeManager(address) external;
    function estimatedAPR() external view returns (uint256);
    function creditAvailable() external view returns (uint256);
    function debtOutstanding() external view returns (uint256);
    function report(uint256,uint256,uint256) external;
    function recoverERC20(address,address,uint256) external;
    function addStrategy(address,uint256) external;
    function updateStrategyDebtRatio(address,uint256) external;
    function setStrategyEmergencyExit(address) external;
    function revokeStrategy(address) external;
    function withdrawFromStrategy(address,uint256) external;
    function getBalance() external view returns (uint256);
    function getTotalAsset() external view returns (uint256);
}

interface IPoolManagerV2 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct StrategyParams {
        uint256 lastReport;
        uint256 totalStrategyDebt;
        uint256 debtRatio;
    }
    struct MintBurnData {
        uint64[] xFeeMint;
        uint64[] yFeeMint;
        uint64[] xFeeBurn;
        uint64[] yFeeBurn;
        uint64 targetHAHedge;
        uint64 bonusMalusMint;
        uint64 bonusMalusBurn;
        uint256 capOnStableMinted;
    }
    struct SLPData {
        uint256 lastBlockUpdated;
        uint256 lockedInterests;
        uint256 maxInterestsDistributed;
        uint256 feesAside;
        uint64 slippageFee;
        uint64 feesForSLPs;
        uint64 slippage;
        uint64 interestsForSLPs;
    }
    function BASE_TOKENS() external returns (uint256);
    function BASE_PARAMS() external returns (uint256);
    function token() external returns (address);
    function perpetualManager() external returns (address);
    function stableMaster() external returns (address);
    function feeManager() external returns (address);
    function totalDebt() external returns (uint256);
    function debtRatio() external returns (uint256);
    function strategies(address) external returns (StrategyParams memory);
    function strategyList(uint256) external returns (address);
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function surplusConverter() external returns (address);
    function interestsForSurplus() external returns (uint64);
    function interestsAccumulated() external returns (uint256);
    function adminDebt() external returns (uint256);
    function STABLEMASTER_ROLE() external returns (bytes32);
    function GOVERNOR_ROLE() external returns (bytes32);
    function GUARDIAN_ROLE() external returns (bytes32);
    function STRATEGY_ROLE() external returns (bytes32);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize(address,address) external;
    function deployCollateral(address[] memory,address,address,address,address) external;
    function addGovernor(address) external;
    function removeGovernor(address) external;
    function setGuardian(address,address) external;
    function revokeGuardian(address) external;
    function setFeeManager(address) external;
    function estimatedAPR() external view returns (uint256);
    function creditAvailable() external view returns (uint256);
    function debtOutstanding() external view returns (uint256);
    function report(uint256,uint256,uint256) external;
    function recoverERC20(address,address,uint256) external;
    function addStrategy(address,uint256) external;
    function setSurplusConverter(address) external;
    function setInterestsForSurplus(uint64) external;
    function updateStrategyDebtRatio(address,uint256) external;
    function setStrategyEmergencyExit(address) external;
    function revokeStrategy(address) external;
    function withdrawFromStrategy(address,uint256) external;
    function pushSurplus() external;
    function getBalance() external view returns (uint256);
    function getTotalAsset() external view returns (uint256);
}

interface IDai {
    function wards(address) external returns (uint256);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function version() external returns (string memory);
    function decimals() external returns (uint8);
    function totalSupply() external returns (uint256);
    function balanceOf(address) external returns (uint256);
    function allowance(address,address) external returns (uint256);
    function nonces(address) external returns (uint256);
    function DOMAIN_SEPARATOR() external returns (bytes32);
    function PERMIT_TYPEHASH() external returns (bytes32);
    function rely(address) external;
    function deny(address) external;
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function mint(address,uint256) external;
    function burn(address,uint256) external;
    function approve(address,uint256) external returns (bool);
    function push(address,uint256) external;
    function pull(address,uint256) external;
    function move(address,address,uint256) external;
    function permit(address,address,uint256,uint256,bool,uint8,bytes32,bytes32) external;
}

interface IFeeManager {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct StrategyParams {
        uint256 lastReport;
        uint256 totalStrategyDebt;
        uint256 debtRatio;
    }
    struct MintBurnData {
        uint64[] xFeeMint;
        uint64[] yFeeMint;
        uint64[] xFeeBurn;
        uint64[] yFeeBurn;
        uint64 targetHAHedge;
        uint64 bonusMalusMint;
        uint64 bonusMalusBurn;
        uint256 capOnStableMinted;
    }
    struct SLPData {
        uint256 lastBlockUpdated;
        uint256 lockedInterests;
        uint256 maxInterestsDistributed;
        uint256 feesAside;
        uint64 slippageFee;
        uint64 feesForSLPs;
        uint64 slippage;
        uint64 interestsForSLPs;
    }
    function BASE_PARAMS_CASTED() external returns (uint64);
    function stableMaster() external returns (address);
    function perpetualManager() external returns (address);
    function xBonusMalusMint(uint256) external returns (uint256);
    function yBonusMalusMint(uint256) external returns (uint64);
    function xBonusMalusBurn(uint256) external returns (uint256);
    function yBonusMalusBurn(uint256) external returns (uint64);
    function xSlippage(uint256) external returns (uint256);
    function ySlippage(uint256) external returns (uint64);
    function xSlippageFee(uint256) external returns (uint256);
    function ySlippageFee(uint256) external returns (uint64);
    function haFeeDeposit() external returns (uint64);
    function haFeeWithdraw() external returns (uint64);
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function POOLMANAGER_ROLE() external returns (bytes32);
    function GUARDIAN_ROLE() external returns (bytes32);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function deployCollateral(address[] memory,address,address) external;
    function updateUsersSLP() external;
    function updateHA() external;
    function setFees(uint256[] memory,uint64[] memory,uint8) external;
    function setHAFees(uint64,uint64) external;
}

interface IPerpetualManagerFront {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct StrategyParams {
        uint256 lastReport;
        uint256 totalStrategyDebt;
        uint256 debtRatio;
    }
    struct MintBurnData {
        uint64[] xFeeMint;
        uint64[] yFeeMint;
        uint64[] xFeeBurn;
        uint64[] yFeeBurn;
        uint64 targetHAHedge;
        uint64 bonusMalusMint;
        uint64 bonusMalusBurn;
        uint256 capOnStableMinted;
    }
    struct SLPData {
        uint256 lastBlockUpdated;
        uint256 lockedInterests;
        uint256 maxInterestsDistributed;
        uint256 feesAside;
        uint64 slippageFee;
        uint64 feesForSLPs;
        uint64 slippage;
        uint64 interestsForSLPs;
    }
    struct Pairs {
        address owner;
        uint256 netCashOutAmount;
    }
    struct Perpetual {
        uint256 entryRate;
        uint256 entryTimestamp;
        uint256 margin;
        uint256 committedAmount;
    }
    struct Counter {
        uint256 _value;
    }
    function BASE_TOKENS() external returns (uint256);
    function BASE_PARAMS() external returns (uint256);
    function totalHedgeAmount() external returns (uint256);
    function oracle() external returns (address);
    function rewardToken() external returns (address);
    function poolManager() external returns (address);
    function xHAFeesDeposit(uint256) external returns (uint64);
    function yHAFeesDeposit(uint256) external returns (uint64);
    function xHAFeesWithdraw(uint256) external returns (uint64);
    function yHAFeesWithdraw(uint256) external returns (uint64);
    function maintenanceMargin() external returns (uint64);
    function maxLeverage() external returns (uint64);
    function targetHAHedge() external returns (uint64);
    function limitHAHedge() external returns (uint64);
    function haBonusMalusDeposit() external returns (uint64);
    function haBonusMalusWithdraw() external returns (uint64);
    function lockTime() external returns (uint64);
    function keeperFeesLiquidationRatio() external returns (uint64);
    function keeperFeesLiquidationCap() external returns (uint256);
    function keeperFeesClosingCap() external returns (uint256);
    function xKeeperFeesClosing(uint256) external returns (uint64);
    function yKeeperFeesClosing(uint256) external returns (uint64);
    function periodFinish() external returns (uint256);
    function rewardRate() external returns (uint256);
    function rewardsDuration() external returns (uint256);
    function lastUpdateTime() external returns (uint256);
    function rewardPerTokenStored() external returns (uint256);
    function rewardsDistribution() external returns (address);
    function baseURI() external returns (string memory);
    function perpetualData(uint256) external returns (Perpetual memory);
    function perpetualRewardPerTokenPaid(uint256) external returns (uint256);
    function rewards(uint256) external returns (uint256);
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function GUARDIAN_ROLE() external returns (bytes32);
    function POOLMANAGER_ROLE() external returns (bytes32);
    function deployCollateral(address[] memory,address,address,address) external;
    function notifyRewardAmount(uint256) external;
    function recoverERC20(address,address,uint256) external;
    function setNewRewardsDistribution(address) external;
    function setFeeKeeper(uint64,uint64) external;
    function pause() external;
    function unpause() external;
    function setRewardDistribution(uint256,address) external;
    function setBaseURI(string memory) external;
    function setLockTime(uint64) external;
    function setBoundsPerpetual(uint64,uint64) external;
    function setHAFees(uint64[] memory,uint64[] memory,uint8) external;
    function setTargetAndLimitHAHedge(uint64,uint64) external;
    function setKeeperFeesLiquidationRatio(uint64) external;
    function setKeeperFeesCap(uint256,uint256) external;
    function setKeeperFeesClosing(uint64[] memory,uint64[] memory) external;
    function setFeeManager(address) external;
    function setOracle(address) external;
    function paused() external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize(address,address) external;
    function openPerpetual(address,uint256,uint256,uint256,uint256) external returns (uint256);
    function closePerpetual(uint256,address,uint256) external;
    function addToPerpetual(uint256,uint256) external;
    function removeFromPerpetual(uint256,uint256,address) external;
    function liquidatePerpetuals(uint256[] memory) external;
    function forceClosePerpetuals(uint256[] memory) external;
    function getCashOutAmount(uint256,uint256) external view returns (uint256,uint256);
    function earned(uint256) external view returns (uint256);
    function getReward(uint256) external;
    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function tokenURI(uint256) external view returns (string memory);
    function balanceOf(address) external view returns (uint256);
    function ownerOf(uint256) external view returns (address);
    function approve(address,uint256) external;
    function getApproved(uint256) external view returns (address);
    function setApprovalForAll(address,bool) external;
    function isApprovedForAll(address,address) external view returns (bool);
    function isApprovedOrOwner(address,uint256) external view returns (bool);
    function transferFrom(address,address,uint256) external;
    function safeTransferFrom(address,address,uint256) external;
    function safeTransferFrom(address,address,uint256,bytes memory) external;
    function supportsInterface(bytes4) external pure returns (bool);
}

interface IStableMasterFront {
    struct Collateral {
        address token;
        address sanToken;
        address perpetualManager;
        address oracle;
        uint256 stocksUsers;
        uint256 sanRate;
        uint256 collatBase;
        SLPData slpData;
        MintBurnData feeData;
    }
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct StrategyParams {
        uint256 lastReport;
        uint256 totalStrategyDebt;
        uint256 debtRatio;
    }
    struct MintBurnData {
        uint64[] xFeeMint;
        uint64[] yFeeMint;
        uint64[] xFeeBurn;
        uint64[] yFeeBurn;
        uint64 targetHAHedge;
        uint64 bonusMalusMint;
        uint64 bonusMalusBurn;
        uint256 capOnStableMinted;
    }
    struct SLPData {
        uint256 lastBlockUpdated;
        uint256 lockedInterests;
        uint256 maxInterestsDistributed;
        uint256 feesAside;
        uint64 slippageFee;
        uint64 feesForSLPs;
        uint64 slippage;
        uint64 interestsForSLPs;
    }
    function BASE_TOKENS() external returns (uint256);
    function BASE_PARAMS() external returns (uint256);
    function collateralMap(address) external returns (Collateral memory);
    function agToken() external returns (address);
    function paused(bytes32) external returns (bool);
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function GOVERNOR_ROLE() external returns (bytes32);
    function GUARDIAN_ROLE() external returns (bytes32);
    function CORE_ROLE() external returns (bytes32);
    function STABLE() external returns (bytes32);
    function SLP() external returns (bytes32);
    function deploy(address[] memory,address,address) external;
    function accumulateInterest(uint256) external;
    function signalLoss(uint256) external;
    function convertToSLP(uint256,address) external;
    function setTargetHAHedge(uint64) external;
    function getStocksUsers() external view returns (uint256);
    function getCollateralRatio() external view returns (uint256);
    function setFeeKeeper(uint64,uint64,uint64,uint64) external;
    function updateStocksUsers(uint256,address) external;
    function setCore(address) external;
    function addGovernor(address) external;
    function removeGovernor(address) external;
    function setGuardian(address,address) external;
    function revokeGuardian(address) external;
    function deployCollateral(address,address,address,address,address) external;
    function revokeCollateral(address,address) external;
    function pause(bytes32,address) external;
    function unpause(bytes32,address) external;
    function rebalanceStocksUsers(uint256,address,address) external;
    function setOracle(address,address) external;
    function setCapOnStableAndMaxInterests(uint256,uint256,address) external;
    function setFeeManager(address,address,address) external;
    function setIncentivesForSLPs(uint64,uint64,address) external;
    function setUserFees(address,uint64[] memory,uint64[] memory,uint8) external;
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize(address) external;
    function mint(uint256,address,address,uint256) external;
    function burn(uint256,address,address,address,uint256) external;
    function deposit(uint256,address,address) external;
    function withdraw(uint256,address,address,address) external;
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

    IPoolManagerV1 poolManagerV1;
    IPoolManagerV2 poolManagerV2;
    ITransparentUpgradeableProxy transparentUpgradeableProxy;
    IDai dai;
    IFeeManager feeManager;
    IPerpetualManagerFront perpetualManagerFront;
    IStableMasterFront stableMasterFront;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct StrategyParams {
        uint256 lastReport;
        uint256 totalStrategyDebt;
        uint256 debtRatio;
    }
    struct MintBurnData {
        uint64[] xFeeMint;
        uint64[] yFeeMint;
        uint64[] xFeeBurn;
        uint64[] yFeeBurn;
        uint64 targetHAHedge;
        uint64 bonusMalusMint;
        uint64 bonusMalusBurn;
        uint256 capOnStableMinted;
    }
    struct SLPData {
        uint256 lastBlockUpdated;
        uint256 lockedInterests;
        uint256 maxInterestsDistributed;
        uint256 feesAside;
        uint64 slippageFee;
        uint64 feesForSLPs;
        uint64 slippage;
        uint64 interestsForSLPs;
    }
    struct Collateral {
        address token;
        address sanToken;
        address perpetualManager;
        address oracle;
        uint256 stocksUsers;
        uint256 sanRate;
        uint256 collatBase;
        SLPData slpData;
        MintBurnData feeData;
    }

    constructor() public {
        hevm.roll(14003915);
        hevm.warp(1642167554);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        poolManagerV1 = IPoolManagerV1(0xa014A485D64efb236423004AB1a99C0aaa97a549);
        poolManagerV2 = IPoolManagerV2(0xB701A741A0F1e75841e9c76a6DD3aA3C386cb97f);
        transparentUpgradeableProxy = ITransparentUpgradeableProxy(0xc9daabC677F3d1301006e723bD21C60be57a5915);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(poolManagerV1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(poolManagerV2))))
        );
        dai = IDai(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        feeManager = IFeeManager(0xE6d9bD6796bDAF9B391Fac2A2D34bAE9c1c3c1C4);
        perpetualManagerFront = IPerpetualManagerFront(0xfc8f9eefC5FCe1D9dAcE2B0a11A1e184381787C4);
        stableMasterFront = IStableMasterFront(0x5adDc89785D75C86aB939E9e15bfBBb7Fc086A87);
    }


    /*** Modified Functions ***/ 

    function PoolManager_report(uint256 a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'report(uint256,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'report(uint256,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_recoverERC20(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'recoverERC20(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'recoverERC20(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function PoolManager_estimatedAPR() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'estimatedAPR()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'estimatedAPR()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_creditAvailable() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'creditAvailable()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'creditAvailable()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_debtOutstanding() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'debtOutstanding()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'debtOutstanding()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_addStrategy(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'addStrategy(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'addStrategy(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_updateStrategyDebtRatio(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'updateStrategyDebtRatio(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'updateStrategyDebtRatio(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_setStrategyEmergencyExit(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setStrategyEmergencyExit(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setStrategyEmergencyExit(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_revokeStrategy(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'revokeStrategy(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'revokeStrategy(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_withdrawFromStrategy(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'withdrawFromStrategy(IStrategy,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'withdrawFromStrategy(IStrategy,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PoolManager_getTotalAsset() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getTotalAsset()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getTotalAsset()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function PoolManager_setSurplusConverter(address a) public virtual {
        // This function does nothing with the V1, since setSurplusConverter is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(transparentUpgradeableProxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(poolManagerV2));
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setSurplusConverter(address)', a
            )
        );
        // Keep the forks in sync
        uint blockNo = block.number;
        uint blockTime = block.timestamp;
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.roll(blockNo);
        hevm.warp(blockTime);
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }

    function PoolManager_setInterestsForSurplus(uint64 a) public virtual {
        // This function does nothing with the V1, since setInterestsForSurplus is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(transparentUpgradeableProxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(poolManagerV2));
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setInterestsForSurplus(uint64)', a
            )
        );
        // Keep the forks in sync
        uint blockNo = block.number;
        uint blockTime = block.timestamp;
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.roll(blockNo);
        hevm.warp(blockTime);
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }

    function PoolManager_pushSurplus() public virtual {
        // This function does nothing with the V1, since pushSurplus is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(transparentUpgradeableProxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(poolManagerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'pushSurplus()'
            )
        );
        // Keep the forks in sync
        uint blockNo = block.number;
        uint blockTime = block.timestamp;
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.roll(blockNo);
        hevm.warp(blockTime);
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }


    /*** Tainted Variables ***/ 

    function PoolManager_totalDebt() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IPoolManagerV1(address(transparentUpgradeableProxy)).totalDebt();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IPoolManagerV2(address(transparentUpgradeableProxy)).totalDebt();
        assert(a1 == a2);
        return a1;
    }

    function PoolManager_debtRatio() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IPoolManagerV1(address(transparentUpgradeableProxy)).debtRatio();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IPoolManagerV2(address(transparentUpgradeableProxy)).debtRatio();
        assert(a1 == a2);
        return a1;
    }

    function PoolManager_strategyList(uint i) public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = IPoolManagerV1(address(transparentUpgradeableProxy)).strategyList(i);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = IPoolManagerV2(address(transparentUpgradeableProxy)).strategyList(i);
        assert(a1 == a2);
        return a1;
    }


    /*** Additional Targets ***/ 

    function Dai_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_burn(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_deny(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'deny(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'deny(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_mint(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_move(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'move(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'move(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_permit(address a, address b, uint256 c, uint256 d, bool e, uint8 f, bytes32 g, bytes32 h) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_pull(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'pull(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'pull(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_push(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'push(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'push(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_rely(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'rely(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'rely(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Dai_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(dai).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(dai).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_deployCollateral(address[] memory a, address b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'deployCollateral(address[],address,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'deployCollateral(address[],address,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_getRoleAdmin(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_grantRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_hasRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_renounceRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_revokeRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_setFees(uint256[] memory a, uint64[] memory b, uint8 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'setFees(uint256[],uint64[],uint8)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'setFees(uint256[],uint64[],uint8)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_setHAFees(uint64 a, uint64 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'setHAFees(uint64,uint64)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'setHAFees(uint64,uint64)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_updateHA() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'updateHA()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'updateHA()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FeeManager_updateUsersSLP() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(feeManager).call(
            abi.encodeWithSignature(
                'updateUsersSLP()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(feeManager).call(
            abi.encodeWithSignature(
                'updateUsersSLP()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_addToPerpetual(uint256 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'addToPerpetual(uint256,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'addToPerpetual(uint256,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_closePerpetual(uint256 a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'closePerpetual(uint256,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'closePerpetual(uint256,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_deployCollateral(address[] memory a, address b, address c, address d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'deployCollateral(address[],address,IFeeManager,IOracle)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'deployCollateral(address[],address,IFeeManager,IOracle)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_earned(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'earned(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'earned(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_forceClosePerpetuals(uint256[] memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'forceClosePerpetuals(uint256[])', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'forceClosePerpetuals(uint256[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_getApproved(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getApproved(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getApproved(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_getCashOutAmount(uint256 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getCashOutAmount(uint256,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getCashOutAmount(uint256,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_getReward(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getReward(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getReward(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_getRoleAdmin(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_grantRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_hasRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_initialize(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'initialize(IPoolManager,IERC20)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'initialize(IPoolManager,IERC20)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_isApprovedForAll(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'isApprovedForAll(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'isApprovedForAll(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_isApprovedOrOwner(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'isApprovedOrOwner(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'isApprovedOrOwner(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_liquidatePerpetuals(uint256[] memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'liquidatePerpetuals(uint256[])', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'liquidatePerpetuals(uint256[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_name() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_notifyRewardAmount(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'notifyRewardAmount(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'notifyRewardAmount(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_openPerpetual(address a, uint256 b, uint256 c, uint256 d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'openPerpetual(address,uint256,uint256,uint256,uint256)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'openPerpetual(address,uint256,uint256,uint256,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_ownerOf(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'ownerOf(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'ownerOf(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_pause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_paused() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_recoverERC20(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'recoverERC20(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'recoverERC20(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_removeFromPerpetual(uint256 a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'removeFromPerpetual(uint256,uint256,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'removeFromPerpetual(uint256,uint256,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_renounceRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_revokeRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_safeTransferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'safeTransferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'safeTransferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_safeTransferFrom(address a, address b, uint256 c, bytes memory d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'safeTransferFrom(address,address,uint256,bytes)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'safeTransferFrom(address,address,uint256,bytes)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setApprovalForAll(address a, bool b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setApprovalForAll(address,bool)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setApprovalForAll(address,bool)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setBaseURI(string memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setBaseURI(string)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setBaseURI(string)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setBoundsPerpetual(uint64 a, uint64 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setBoundsPerpetual(uint64,uint64)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setBoundsPerpetual(uint64,uint64)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setFeeKeeper(uint64 a, uint64 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setFeeKeeper(uint64,uint64)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setFeeKeeper(uint64,uint64)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setFeeManager(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setFeeManager(IFeeManager)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setFeeManager(IFeeManager)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setHAFees(uint64[] memory a, uint64[] memory b, uint8 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setHAFees(uint64[],uint64[],uint8)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setHAFees(uint64[],uint64[],uint8)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setKeeperFeesCap(uint256 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setKeeperFeesCap(uint256,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setKeeperFeesCap(uint256,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setKeeperFeesClosing(uint64[] memory a, uint64[] memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setKeeperFeesClosing(uint64[],uint64[])', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setKeeperFeesClosing(uint64[],uint64[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setKeeperFeesLiquidationRatio(uint64 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setKeeperFeesLiquidationRatio(uint64)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setKeeperFeesLiquidationRatio(uint64)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setLockTime(uint64 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setLockTime(uint64)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setLockTime(uint64)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setNewRewardsDistribution(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setNewRewardsDistribution(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setNewRewardsDistribution(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setOracle(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setOracle(IOracle)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setOracle(IOracle)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setRewardDistribution(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setRewardDistribution(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setRewardDistribution(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_setTargetAndLimitHAHedge(uint64 a, uint64 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setTargetAndLimitHAHedge(uint64,uint64)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'setTargetAndLimitHAHedge(uint64,uint64)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_supportsInterface(bytes4 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_symbol() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_tokenURI(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'tokenURI(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'tokenURI(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function PerpetualManagerFront_unpause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(perpetualManagerFront).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_accumulateInterest(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'accumulateInterest(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'accumulateInterest(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_addGovernor(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'addGovernor(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'addGovernor(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_burn(uint256 a, address b, address c, address d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'burn(uint256,address,address,IPoolManager,uint256)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'burn(uint256,address,address,IPoolManager,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_convertToSLP(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'convertToSLP(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'convertToSLP(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_deploy(address[] memory a, address b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'deploy(address[],address,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'deploy(address[],address,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_deployCollateral(address a, address b, address c, address d, address e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'deployCollateral(IPoolManager,IPerpetualManager,IFeeManager,IOracle,ISanToken)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'deployCollateral(IPoolManager,IPerpetualManager,IFeeManager,IOracle,ISanToken)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_deposit(uint256 a, address b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'deposit(uint256,address,IPoolManager)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'deposit(uint256,address,IPoolManager)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_getCollateralRatio() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'getCollateralRatio()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'getCollateralRatio()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_getRoleAdmin(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_getStocksUsers() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'getStocksUsers()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'getStocksUsers()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_grantRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_hasRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_initialize(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'initialize(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'initialize(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_mint(uint256 a, address b, address c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'mint(uint256,address,IPoolManager,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'mint(uint256,address,IPoolManager,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_pause(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'pause(bytes32,IPoolManager)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'pause(bytes32,IPoolManager)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_rebalanceStocksUsers(uint256 a, address b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'rebalanceStocksUsers(uint256,IPoolManager,IPoolManager)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'rebalanceStocksUsers(uint256,IPoolManager,IPoolManager)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_removeGovernor(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'removeGovernor(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'removeGovernor(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_renounceRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_revokeCollateral(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'revokeCollateral(IPoolManager,ICollateralSettler)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'revokeCollateral(IPoolManager,ICollateralSettler)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_revokeGuardian(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'revokeGuardian(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'revokeGuardian(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_revokeRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setCapOnStableAndMaxInterests(uint256 a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setCapOnStableAndMaxInterests(uint256,uint256,IPoolManager)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setCapOnStableAndMaxInterests(uint256,uint256,IPoolManager)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setCore(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setCore(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setCore(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setFeeKeeper(uint64 a, uint64 b, uint64 c, uint64 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setFeeKeeper(uint64,uint64,uint64,uint64)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setFeeKeeper(uint64,uint64,uint64,uint64)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setFeeManager(address a, address b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setFeeManager(address,address,IPoolManager)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setFeeManager(address,address,IPoolManager)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setGuardian(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setGuardian(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setGuardian(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setIncentivesForSLPs(uint64 a, uint64 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setIncentivesForSLPs(uint64,uint64,IPoolManager)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setIncentivesForSLPs(uint64,uint64,IPoolManager)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setOracle(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setOracle(IOracle,IPoolManager)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setOracle(IOracle,IPoolManager)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setTargetHAHedge(uint64 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setTargetHAHedge(uint64)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setTargetHAHedge(uint64)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_setUserFees(address a, uint64[] memory b, uint64[] memory c, uint8 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setUserFees(IPoolManager,uint64[],uint64[],uint8)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'setUserFees(IPoolManager,uint64[],uint64[],uint8)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_signalLoss(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'signalLoss(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'signalLoss(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_unpause(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'unpause(bytes32,IPoolManager)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'unpause(bytes32,IPoolManager)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_updateStocksUsers(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'updateStocksUsers(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'updateStocksUsers(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StableMasterFront_withdraw(uint256 a, address b, address c, address d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'withdraw(uint256,address,address,IPoolManager)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(stableMasterFront).call(
            abi.encodeWithSignature(
                'withdraw(uint256,address,address,IPoolManager)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
