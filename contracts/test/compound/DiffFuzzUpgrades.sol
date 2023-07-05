// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.10;

import { ComptrollerHarness as ComptrollerHarness_V1 } from "../../implementation/compound/compound-0.8.10/ComptrollerHarnessV1.sol";
import { ComptrollerHarness as ComptrollerHarness_V2 } from "../../implementation/compound/compound-0.8.10/ComptrollerHarnessV2.sol";
import { Unitroller } from "../../implementation/compound/compound-0.8.10/Unitroller.sol";
import { CErc20 } from "../../implementation/compound/compound-0.8.10/CErc20.sol";
import { CompHarness } from "../../implementation/compound/compound-0.8.10/CompHarness.sol";

interface IComptrollerHarnessV1 {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, SET_PAUSE_GUARDIAN_OWNER_CHECK }
    struct Market {
        bool isListed;
        uint256 collateralFactorMantissa;
        mapping(address => bool) accountMembership;
        bool isComped;
    }
    struct CompMarketState {
        uint224 index;
        uint32 block;
    }
    struct Exp {
        uint256 mantissa;
    }
    struct Double {
        uint256 mantissa;
    }
    struct AccountLiquidityLocalVars {
        uint256 sumCollateral;
        uint256 sumBorrowPlusEffects;
        uint256 cTokenBalance;
        uint256 borrowBalance;
        uint256 exchangeRateMantissa;
        uint256 oraclePriceMantissa;
        Exp collateralFactor;
        Exp exchangeRate;
        Exp oraclePrice;
        Exp tokensToDenom;
    }
    function admin() external returns (address);
    function pendingAdmin() external returns (address);
    function comptrollerImplementation() external returns (address);
    function pendingComptrollerImplementation() external returns (address);
    function oracle() external returns (address);
    function closeFactorMantissa() external returns (uint256);
    function liquidationIncentiveMantissa() external returns (uint256);
    function maxAssets() external returns (uint256);
    function accountAssets(address,uint256) external returns (address);
    function pauseGuardian() external returns (address);
    function _mintGuardianPaused() external returns (bool);
    function _borrowGuardianPaused() external returns (bool);
    function transferGuardianPaused() external returns (bool);
    function seizeGuardianPaused() external returns (bool);
    function mintGuardianPaused(address) external returns (bool);
    function borrowGuardianPaused(address) external returns (bool);
    function allMarkets(uint256) external returns (address);
    function compRate() external returns (uint256);
    function compSpeeds(address) external returns (uint256);
    function compSupplyState(address) external returns (CompMarketState memory);
    function compBorrowState(address) external returns (CompMarketState memory);
    function compSupplierIndex(address,address) external returns (uint256);
    function compBorrowerIndex(address,address) external returns (uint256);
    function compAccrued(address) external returns (uint256);
    function borrowCapGuardian() external returns (address);
    function borrowCaps(address) external returns (uint256);
    function compContributorSpeeds(address) external returns (uint256);
    function lastContributorBlock(address) external returns (uint256);
    function isComptroller() external returns (bool);
    function compInitialIndex() external returns (uint224);
    function getAssetsIn(address) external view returns (address[] memory);
    function checkMembership(address,address) external view returns (bool);
    function enterMarkets(address[] memory) external returns (uint256[] memory);
    function exitMarket(address) external returns (uint256);
    function mintAllowed(address,address,uint256) external returns (uint256);
    function mintVerify(address,address,uint256,uint256) external;
    function redeemAllowed(address,address,uint256) external returns (uint256);
    function redeemVerify(address,address,uint256,uint256) external;
    function borrowAllowed(address,address,uint256) external returns (uint256);
    function borrowVerify(address,address,uint256) external;
    function repayBorrowAllowed(address,address,address,uint256) external returns (uint256);
    function repayBorrowVerify(address,address,address,uint256,uint256) external;
    function liquidateBorrowAllowed(address,address,address,address,uint256) external returns (uint256);
    function liquidateBorrowVerify(address,address,address,address,uint256,uint256) external;
    function seizeAllowed(address,address,address,address,uint256) external returns (uint256);
    function seizeVerify(address,address,address,address,uint256) external;
    function transferAllowed(address,address,address,uint256) external returns (uint256);
    function transferVerify(address,address,address,uint256) external;
    function getAccountLiquidity(address) external view returns (uint256,uint256,uint256);
    function getHypotheticalAccountLiquidity(address,address,uint256,uint256) external view returns (uint256,uint256,uint256);
    function liquidateCalculateSeizeTokens(address,address,uint256) external view returns (uint256,uint256);
    function _setPriceOracle(address) external returns (uint256);
    function _setCloseFactor(uint256) external returns (uint256);
    function _setCollateralFactor(address,uint256) external returns (uint256);
    function _setLiquidationIncentive(uint256) external returns (uint256);
    function _supportMarket(address) external returns (uint256);
    function _setMarketBorrowCaps(address[] calldata,uint256[] calldata) external;
    function _setBorrowCapGuardian(address) external;
    function _setPauseGuardian(address) external returns (uint256);
    function _setMintPaused(address,bool) external returns (bool);
    function _setBorrowPaused(address,bool) external returns (bool);
    function _setTransferPaused(bool) external returns (bool);
    function _setSeizePaused(bool) external returns (bool);
    function _become(address) external;
    function updateContributorRewards(address) external;
    function claimComp(address) external;
    function claimComp(address,address[] memory) external;
    function claimComp(address[] memory,address[] memory,bool,bool) external;
    function _grantComp(address,uint256) external;
    function _setCompSpeed(address,uint256) external;
    function _setContributorCompSpeed(address,uint256) external;
    function getAllMarkets() external view returns (address[] memory);
    function isDeprecated(address) external view returns (bool);
    function getBlockNumber() external view returns (uint256);
    function getCompAddress() external view returns (address);
    function setCompAddress(address) external;
    function isListed(address) external view returns (bool);
}

interface IComptrollerHarnessV2 {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, SET_PAUSE_GUARDIAN_OWNER_CHECK }
    struct Market {
        bool isListed;
        uint256 collateralFactorMantissa;
        mapping(address => bool) accountMembership;
        bool isComped;
    }
    struct CompMarketState {
        uint224 index;
        uint32 block;
    }
    struct Exp {
        uint256 mantissa;
    }
    struct Double {
        uint256 mantissa;
    }
    struct AccountLiquidityLocalVars {
        uint256 sumCollateral;
        uint256 sumBorrowPlusEffects;
        uint256 cTokenBalance;
        uint256 borrowBalance;
        uint256 exchangeRateMantissa;
        uint256 oraclePriceMantissa;
        Exp collateralFactor;
        Exp exchangeRate;
        Exp oraclePrice;
        Exp tokensToDenom;
    }
    function admin() external returns (address);
    function pendingAdmin() external returns (address);
    function comptrollerImplementation() external returns (address);
    function pendingComptrollerImplementation() external returns (address);
    function oracle() external returns (address);
    function closeFactorMantissa() external returns (uint256);
    function liquidationIncentiveMantissa() external returns (uint256);
    function maxAssets() external returns (uint256);
    function accountAssets(address,uint256) external returns (address);
    function pauseGuardian() external returns (address);
    function _mintGuardianPaused() external returns (bool);
    function _borrowGuardianPaused() external returns (bool);
    function transferGuardianPaused() external returns (bool);
    function seizeGuardianPaused() external returns (bool);
    function mintGuardianPaused(address) external returns (bool);
    function borrowGuardianPaused(address) external returns (bool);
    function allMarkets(uint256) external returns (address);
    function compRate() external returns (uint256);
    function compSpeeds(address) external returns (uint256);
    function compSupplyState(address) external returns (CompMarketState memory);
    function compBorrowState(address) external returns (CompMarketState memory);
    function compSupplierIndex(address,address) external returns (uint256);
    function compBorrowerIndex(address,address) external returns (uint256);
    function compAccrued(address) external returns (uint256);
    function borrowCapGuardian() external returns (address);
    function borrowCaps(address) external returns (uint256);
    function compContributorSpeeds(address) external returns (uint256);
    function lastContributorBlock(address) external returns (uint256);
    function compBorrowSpeeds(address) external returns (uint256);
    function compSupplySpeeds(address) external returns (uint256);
    function isComptroller() external returns (bool);
    function compInitialIndex() external returns (uint224);
    function getAssetsIn(address) external view returns (address[] memory);
    function checkMembership(address,address) external view returns (bool);
    function enterMarkets(address[] memory) external returns (uint256[] memory);
    function exitMarket(address) external returns (uint256);
    function mintAllowed(address,address,uint256) external returns (uint256);
    function mintVerify(address,address,uint256,uint256) external;
    function redeemAllowed(address,address,uint256) external returns (uint256);
    function redeemVerify(address,address,uint256,uint256) external;
    function borrowAllowed(address,address,uint256) external returns (uint256);
    function borrowVerify(address,address,uint256) external;
    function repayBorrowAllowed(address,address,address,uint256) external returns (uint256);
    function repayBorrowVerify(address,address,address,uint256,uint256) external;
    function liquidateBorrowAllowed(address,address,address,address,uint256) external returns (uint256);
    function liquidateBorrowVerify(address,address,address,address,uint256,uint256) external;
    function seizeAllowed(address,address,address,address,uint256) external returns (uint256);
    function seizeVerify(address,address,address,address,uint256) external;
    function transferAllowed(address,address,address,uint256) external returns (uint256);
    function transferVerify(address,address,address,uint256) external;
    function getAccountLiquidity(address) external view returns (uint256,uint256,uint256);
    function getHypotheticalAccountLiquidity(address,address,uint256,uint256) external view returns (uint256,uint256,uint256);
    function liquidateCalculateSeizeTokens(address,address,uint256) external view returns (uint256,uint256);
    function _setPriceOracle(address) external returns (uint256);
    function _setCloseFactor(uint256) external returns (uint256);
    function _setCollateralFactor(address,uint256) external returns (uint256);
    function _setLiquidationIncentive(uint256) external returns (uint256);
    function _supportMarket(address) external returns (uint256);
    function _setMarketBorrowCaps(address[] calldata,uint256[] calldata) external;
    function _setBorrowCapGuardian(address) external;
    function _setPauseGuardian(address) external returns (uint256);
    function _setMintPaused(address,bool) external returns (bool);
    function _setBorrowPaused(address,bool) external returns (bool);
    function _setTransferPaused(bool) external returns (bool);
    function _setSeizePaused(bool) external returns (bool);
    function _become(address) external;
    function _upgradeSplitCompRewards() external;
    function updateContributorRewards(address) external;
    function claimComp(address) external;
    function claimComp(address,address[] memory) external;
    function claimComp(address[] memory,address[] memory,bool,bool) external;
    function _grantComp(address,uint256) external;
    function _setCompSpeeds(address[] memory,uint256[] memory,uint256[] memory) external;
    function _setContributorCompSpeed(address,uint256) external;
    function getAllMarkets() external view returns (address[] memory);
    function isDeprecated(address) external view returns (bool);
    function getBlockNumber() external view returns (uint256);
    function getCompAddress() external view returns (address);
    function setCompAddress(address) external;
    function isListed(address) external view returns (bool);
}

interface ICErc20 {
    struct BorrowSnapshot {
        uint256 principal;
        uint256 interestIndex;
    }
    struct Exp {
        uint256 mantissa;
    }
    struct Double {
        uint256 mantissa;
    }
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function admin() external returns (address);
    function pendingAdmin() external returns (address);
    function comptroller() external returns (address);
    function interestRateModel() external returns (address);
    function reserveFactorMantissa() external returns (uint256);
    function accrualBlockNumber() external returns (uint256);
    function borrowIndex() external returns (uint256);
    function totalBorrows() external returns (uint256);
    function totalReserves() external returns (uint256);
    function totalSupply() external returns (uint256);
    function protocolSeizeShareMantissa() external returns (uint256);
    function isCToken() external returns (bool);
    function NO_ERROR() external returns (uint256);
    function underlying() external returns (address);
    function initialize(address,address,uint256,string memory,string memory,uint8) external;
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function approve(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function balanceOfUnderlying(address) external returns (uint256);
    function getAccountSnapshot(address) external view returns (uint256,uint256,uint256,uint256);
    function borrowRatePerBlock() external view returns (uint256);
    function supplyRatePerBlock() external view returns (uint256);
    function totalBorrowsCurrent() external returns (uint256);
    function borrowBalanceCurrent(address) external returns (uint256);
    function borrowBalanceStored(address) external view returns (uint256);
    function exchangeRateCurrent() external returns (uint256);
    function exchangeRateStored() external view returns (uint256);
    function getCash() external view returns (uint256);
    function accrueInterest() external returns (uint256);
    function seize(address,address,uint256) external returns (uint256);
    function _setPendingAdmin(address) external returns (uint256);
    function _acceptAdmin() external returns (uint256);
    function _setComptroller(address) external returns (uint256);
    function _setReserveFactor(uint256) external returns (uint256);
    function _reduceReserves(uint256) external returns (uint256);
    function _setInterestRateModel(address) external returns (uint256);
    function initialize(address,address,address,uint256,string memory,string memory,uint8) external;
    function mint(uint256) external returns (uint256);
    function redeem(uint256) external returns (uint256);
    function redeemUnderlying(uint256) external returns (uint256);
    function borrow(uint256) external returns (uint256);
    function repayBorrow(uint256) external returns (uint256);
    function repayBorrowBehalf(address,uint256) external returns (uint256);
    function liquidateBorrow(address,uint256,address) external returns (uint256);
    function sweepToken(address) external;
    function _addReserves(uint256) external returns (uint256);
    function _delegateCompLikeTo(address) external;
}

interface ICompHarness {
    struct Checkpoint {
        uint32 fromBlock;
        uint96 votes;
    }
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function totalSupply() external returns (uint256);
    function delegates(address) external returns (address);
    function checkpoints(address,uint32) external returns (Checkpoint memory);
    function numCheckpoints(address) external returns (uint32);
    function DOMAIN_TYPEHASH() external returns (bytes32);
    function DELEGATION_TYPEHASH() external returns (bytes32);
    function nonces(address) external returns (uint256);
    function allowance(address,address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function balanceOf(address) external view returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function delegate(address) external;
    function delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32) external;
    function getCurrentVotes(address) external view returns (uint96);
    function getPriorVotes(address,uint256) external view returns (uint96);
    function initialize(address) external;
}

interface IUnitroller {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, SET_PAUSE_GUARDIAN_OWNER_CHECK }
    function admin() external returns (address);
    function pendingAdmin() external returns (address);
    function comptrollerImplementation() external returns (address);
    function pendingComptrollerImplementation() external returns (address);
    function _setPendingImplementation(address) external returns (uint256);
    function _acceptImplementation() external returns (uint256);
    function _setPendingAdmin(address) external returns (uint256);
    function _acceptAdmin() external returns (uint256);
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

    IComptrollerHarnessV1 comptrollerHarnessV1;
    IComptrollerHarnessV2 comptrollerHarnessV2;
    IUnitroller unitrollerV1;
    IUnitroller unitrollerV2;
    ICErc20 cErc20V1;
    ICErc20 cErc20V2;
    ICompHarness compHarnessV1;
    ICompHarness compHarnessV2;
    struct Market {
        bool isListed;
        uint256 collateralFactorMantissa;
        mapping(address => bool) accountMembership;
        bool isComped;
    }
    struct CompMarketState {
        uint224 index;
        uint32 block;
    }
    struct Exp {
        uint256 mantissa;
    }
    struct Double {
        uint256 mantissa;
    }
    struct AccountLiquidityLocalVars {
        uint256 sumCollateral;
        uint256 sumBorrowPlusEffects;
        uint256 cTokenBalance;
        uint256 borrowBalance;
        uint256 exchangeRateMantissa;
        uint256 oraclePriceMantissa;
        Exp collateralFactor;
        Exp exchangeRate;
        Exp oraclePrice;
        Exp tokensToDenom;
    }
    struct BorrowSnapshot {
        uint256 principal;
        uint256 interestIndex;
    }
    struct Checkpoint {
        uint32 fromBlock;
        uint96 votes;
    }

    constructor() public {
        comptrollerHarnessV1 = IComptrollerHarnessV1(address(new ComptrollerHarness_V1()));
        comptrollerHarnessV2 = IComptrollerHarnessV2(address(new ComptrollerHarness_V2()));
        unitrollerV1 = IUnitroller(address(new Unitroller()));
        unitrollerV2 = IUnitroller(address(new Unitroller()));
        // Store the implementation addresses in the proxy.
        hevm.store(
            address(unitrollerV1),
            bytes32(uint(2)),
            bytes32(uint256(uint160(address(comptrollerHarnessV1))))
        );
        hevm.store(
            address(unitrollerV2),
            bytes32(uint(2)),
            bytes32(uint256(uint160(address(comptrollerHarnessV1))))
        );
        cErc20V1 = ICErc20(address(new CErc20()));
        cErc20V2 = ICErc20(address(new CErc20()));
        compHarnessV1 = ICompHarness(address(new CompHarness()));
        compHarnessV2 = ICompHarness(address(new CompHarness()));
    }

    /*** Upgrade Function ***/ 

    // TODO: Consider replacing this with the actual upgrade method
    function upgradeV2() external virtual {
        hevm.store(
            address(unitrollerV2),
            bytes32(uint(2)),
            bytes32(uint256(uint160(address(comptrollerHarnessV2))))
        );
    }


    /*** Modified Functions ***/ 

    function ComptrollerHarness__supportMarket(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                '_supportMarket(CToken)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                '_supportMarket(CToken)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_setCompAddress(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'setCompAddress(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'setCompAddress(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function ComptrollerHarness_checkMembership(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'checkMembership(address,CToken)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'checkMembership(address,CToken)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_enterMarkets(address[] memory a) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'enterMarkets(address[])', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'enterMarkets(address[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_exitMarket(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'exitMarket(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'exitMarket(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_mintAllowed(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'mintAllowed(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'mintAllowed(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_redeemAllowed(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'redeemAllowed(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'redeemAllowed(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_borrowAllowed(address a, address b, uint256 c) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'borrowAllowed(address,address,uint256)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'borrowAllowed(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_repayBorrowAllowed(address a, address b, address c, uint256 d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'repayBorrowAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'repayBorrowAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_liquidateBorrowAllowed(address a, address b, address c, address d, uint256 e) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'liquidateBorrowAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'liquidateBorrowAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_seizeAllowed(address a, address b, address c, address d, uint256 e) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'seizeAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'seizeAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_transferAllowed(address a, address b, address c, uint256 d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'transferAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'transferAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_getAccountLiquidity(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'getAccountLiquidity(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'getAccountLiquidity(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_getHypotheticalAccountLiquidity(address a, address b, uint256 c, uint256 d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'getHypotheticalAccountLiquidity(address,address,uint256,uint256)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'getHypotheticalAccountLiquidity(address,address,uint256,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness__setCollateralFactor(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                '_setCollateralFactor(CToken,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                '_setCollateralFactor(CToken,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness__setMintPaused(address a, bool b) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                '_setMintPaused(CToken,bool)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                '_setMintPaused(CToken,bool)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness__setBorrowPaused(address a, bool b) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                '_setBorrowPaused(CToken,bool)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                '_setBorrowPaused(CToken,bool)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_updateContributorRewards(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'updateContributorRewards(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'updateContributorRewards(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_claimComp(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'claimComp(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'claimComp(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_claimComp(address a, address[] memory b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'claimComp(address,CToken[])', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'claimComp(address,CToken[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_claimComp(address[] memory a, address[] memory b, bool c, bool d) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'claimComp(address[],CToken[],bool,bool)', a, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'claimComp(address[],CToken[],bool,bool)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness__grantComp(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                '_grantComp(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                '_grantComp(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness__setContributorCompSpeed(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                '_setContributorCompSpeed(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                '_setContributorCompSpeed(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_getAllMarkets() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'getAllMarkets()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'getAllMarkets()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_isDeprecated(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'isDeprecated(CToken)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'isDeprecated(CToken)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_getCompAddress() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'getCompAddress()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'getCompAddress()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_isListed(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'isListed(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'isListed(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function ComptrollerHarness__upgradeSplitCompRewards() public virtual {
        // This function does nothing with the V1, since _upgradeSplitCompRewards is new in the V2
        address impl = address(uint160(uint256(
            hevm.load(address(unitrollerV2),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerHarnessV2));
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                '_upgradeSplitCompRewards()'
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }

    // TODO: Double-check this function for correctness
    // Comptroller._setCompSpeeds(CToken[],uint256[],uint256[])
    // is a new function which appears to replace a function with a similar name,
    // Comptroller._setCompSpeed(CToken,uint256).
    // If the functions have different arguments this function may be incorrect.
    function ComptrollerHarness__setCompSpeeds(address[] memory a, uint256[] memory b, uint256[] memory c) public virtual {
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                '_setCompSpeed(CToken,uint256)', a, b
            )
        );
        address impl = address(uint160(uint256(
            hevm.load(address(unitrollerV2),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        bool successV2;
        bytes memory outputV2;
        if(impl == address(comptrollerHarnessV2)) {
            (successV2, outputV2) = address(unitrollerV2).call(
                abi.encodeWithSignature(
                        '_setCompSpeeds(CToken[],uint256[],uint256[])', a, b, c
                )
            );
        } else {
            (successV2, outputV2) = address(unitrollerV1).call(
                abi.encodeWithSignature(
                        '_setCompSpeed(CToken,uint256)', a, b
                )
            );
        }
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Variables ***/ 

    function ComptrollerHarness_mintGuardianPaused(address a) public virtual returns (bool) {
        assert(IComptrollerHarnessV1(address(unitrollerV1)).mintGuardianPaused(a) == IComptrollerHarnessV2(address(unitrollerV2)).mintGuardianPaused(a));
        return IComptrollerHarnessV1(address(unitrollerV1)).mintGuardianPaused(a);
    }

    function ComptrollerHarness_borrowGuardianPaused(address a) public virtual returns (bool) {
        assert(IComptrollerHarnessV1(address(unitrollerV1)).borrowGuardianPaused(a) == IComptrollerHarnessV2(address(unitrollerV2)).borrowGuardianPaused(a));
        return IComptrollerHarnessV1(address(unitrollerV1)).borrowGuardianPaused(a);
    }

    function ComptrollerHarness_allMarkets(uint i) public virtual returns (address) {
        assert(IComptrollerHarnessV1(address(unitrollerV1)).allMarkets(i) == IComptrollerHarnessV2(address(unitrollerV2)).allMarkets(i));
        return IComptrollerHarnessV1(address(unitrollerV1)).allMarkets(i);
    }

    function ComptrollerHarness_compSpeeds(address a) public virtual returns (uint256) {
        assert(IComptrollerHarnessV1(address(unitrollerV1)).compSpeeds(a) == IComptrollerHarnessV2(address(unitrollerV2)).compSpeeds(a));
        return IComptrollerHarnessV1(address(unitrollerV1)).compSpeeds(a);
    }

    function ComptrollerHarness_compAccrued(address a) public virtual returns (uint256) {
        assert(IComptrollerHarnessV1(address(unitrollerV1)).compAccrued(a) == IComptrollerHarnessV2(address(unitrollerV2)).compAccrued(a));
        return IComptrollerHarnessV1(address(unitrollerV1)).compAccrued(a);
    }

    function ComptrollerHarness_compContributorSpeeds(address a) public virtual returns (uint256) {
        assert(IComptrollerHarnessV1(address(unitrollerV1)).compContributorSpeeds(a) == IComptrollerHarnessV2(address(unitrollerV2)).compContributorSpeeds(a));
        return IComptrollerHarnessV1(address(unitrollerV1)).compContributorSpeeds(a);
    }

    function ComptrollerHarness_lastContributorBlock(address a) public virtual returns (uint256) {
        assert(IComptrollerHarnessV1(address(unitrollerV1)).lastContributorBlock(a) == IComptrollerHarnessV2(address(unitrollerV2)).lastContributorBlock(a));
        return IComptrollerHarnessV1(address(unitrollerV1)).lastContributorBlock(a);
    }


    /*** Additional Targets ***/ 

    function CErc20__acceptAdmin() public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_acceptAdmin()'
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_acceptAdmin()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20__addReserves(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_addReserves(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_addReserves(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20__delegateCompLikeTo(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_delegateCompLikeTo(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_delegateCompLikeTo(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20__reduceReserves(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_reduceReserves(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_reduceReserves(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20__setComptroller(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_setComptroller(ComptrollerInterface)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_setComptroller(ComptrollerInterface)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20__setInterestRateModel(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_setInterestRateModel(InterestRateModel)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_setInterestRateModel(InterestRateModel)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20__setPendingAdmin(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_setPendingAdmin(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_setPendingAdmin(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20__setReserveFactor(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                '_setReserveFactor(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                '_setReserveFactor(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_accrueInterest() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'accrueInterest()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'accrueInterest()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_allowance(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_approve(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_balanceOfUnderlying(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'balanceOfUnderlying(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'balanceOfUnderlying(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_borrow(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'borrow(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'borrow(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_borrowBalanceCurrent(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'borrowBalanceCurrent(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'borrowBalanceCurrent(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_borrowBalanceStored(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'borrowBalanceStored(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'borrowBalanceStored(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_borrowRatePerBlock() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'borrowRatePerBlock()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'borrowRatePerBlock()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_exchangeRateCurrent() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'exchangeRateCurrent()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'exchangeRateCurrent()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_exchangeRateStored() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'exchangeRateStored()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'exchangeRateStored()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_getAccountSnapshot(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'getAccountSnapshot(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'getAccountSnapshot(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_getCash() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'getCash()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'getCash()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_initialize(address a, address b, address c, uint256 d, string memory e, string memory f, uint8 g) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'initialize(address,ComptrollerInterface,InterestRateModel,uint256,string,string,uint8)', a, b, c, d, e, f, g
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'initialize(address,ComptrollerInterface,InterestRateModel,uint256,string,string,uint8)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_initialize(address a, address b, uint256 c, string memory d, string memory e, uint8 f) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'initialize(ComptrollerInterface,InterestRateModel,uint256,string,string,uint8)', a, b, c, d, e, f
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'initialize(ComptrollerInterface,InterestRateModel,uint256,string,string,uint8)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_liquidateBorrow(address a, uint256 b, address c) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'liquidateBorrow(address,uint256,CTokenInterface)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'liquidateBorrow(address,uint256,CTokenInterface)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_mint(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'mint(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'mint(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_redeem(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'redeem(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'redeem(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_redeemUnderlying(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'redeemUnderlying(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'redeemUnderlying(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_repayBorrow(uint256 a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'repayBorrow(uint256)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'repayBorrow(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_repayBorrowBehalf(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'repayBorrowBehalf(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'repayBorrowBehalf(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_seize(address a, address b, uint256 c) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'seize(address,address,uint256)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'seize(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_supplyRatePerBlock() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'supplyRatePerBlock()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'supplyRatePerBlock()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_sweepToken(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'sweepToken(EIP20NonStandardInterface)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'sweepToken(EIP20NonStandardInterface)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_totalBorrowsCurrent() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'totalBorrowsCurrent()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'totalBorrowsCurrent()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_transfer(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CErc20_transferFrom(address a, address b, uint256 c) public virtual {
        (bool successV1, bytes memory outputV1) = address(cErc20V1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(cErc20V2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_allowance(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_approve(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_delegate(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'delegate(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'delegate(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_delegateBySig(address a, uint256 b, uint256 c, uint8 d, bytes32 e, bytes32 f) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_getCurrentVotes(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'getCurrentVotes(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'getCurrentVotes(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_getPriorVotes(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'getPriorVotes(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'getPriorVotes(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_initialize(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'initialize(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'initialize(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_transfer(address a, uint256 b) public virtual {
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function CompHarness_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(compHarnessV1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(compHarnessV2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
