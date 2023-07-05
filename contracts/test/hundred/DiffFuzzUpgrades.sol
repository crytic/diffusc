// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.0;

interface IComptrollerV1 {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY, MARKET_DOES_NOT_SUPPORT_REQUESTED_CHAIN, MARKET_ENTERED_ON_ANOTHER_CHAIN }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, SET_PAUSE_GUARDIAN_OWNER_CHECK, CALLABLE_ONLY_FROM_CROSS_CHAIN_GATE }
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
    function implementation() external returns (address);
    function pendingImplementation() external returns (address);
    function oracle() external returns (address);
    function closeFactorMantissa() external returns (uint256);
    function liquidationIncentiveMantissa() external returns (uint256);
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
    function bprotocol(address) external returns (address);
    function isComptroller() external returns (bool);
    function compInitialIndex() external returns (uint224);
    function getAssetsIn(address) external view returns (address[] memory);
    function checkMembership(address,address) external view returns (bool);
    function enterMarkets(address[] memory) external returns (uint256[] memory);
    function exitMarket(address) external returns (uint256);
    function mintAllowed(address,address,uint256) external returns (uint256);
    function redeemAllowed(address,address,uint256) external returns (uint256);
    function redeemVerify(address,address,uint256,uint256) external;
    function borrowAllowed(address,address,uint256) external returns (uint256);
    function repayBorrowAllowed(address,address,address,uint256) external returns (uint256);
    function liquidateBorrowAllowed(address,address,address,address,uint256) external returns (uint256);
    function seizeAllowed(address,address,address,address,uint256) external returns (uint256);
    function transferAllowed(address,address,address,uint256) external returns (uint256);
    function getAccountLiquidity(address) external view returns (uint256,uint256,uint256);
    function getHypotheticalAccountLiquidity(address,address,uint256,uint256) external view returns (uint256,uint256,uint256);
    function liquidateCalculateSeizeTokens(address,address,uint256) external view returns (uint256,uint256);
    function _setPriceOracle(address) external returns (uint256);
    function _setCloseFactor(uint256) external returns (uint256);
    function _setCollateralFactor(address,uint256) external returns (uint256);
    function _setLiquidationIncentive(uint256) external returns (uint256);
    function _supportMarket(address) external returns (uint256);
    function _disableMarket(address) external returns (uint256);
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
    function claimComp(address[] memory,address[] memory) external;
    function _grantComp(address,uint256) external;
    function _setCompSpeed(address,uint256) external;
    function _setContributorCompSpeed(address,uint256) external;
    function _setBProtocol(address,address) external returns (uint256);
    function getAllMarkets() external view returns (address[] memory);
    function getBlockNumber() external view returns (uint256);
    function getCompAddress() external view returns (address);
}

interface IComptrollerV2 {
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
    function proposal65FixExecuted() external returns (bool);
    function compReceivable(address) external returns (uint256);
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
    function fixBadAccruals(address[] calldata,uint256[] calldata) external;
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
}

interface IHundred {
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function underlying() external returns (address);
    function PERMIT_TYPEHASH() external returns (bytes32);
    function TRANSFER_TYPEHASH() external returns (bytes32);
    function DOMAIN_SEPARATOR() external returns (bytes32);
    function balanceOf(address) external returns (uint256);
    function delay() external returns (uint256);
    function isMinter(address) external returns (bool);
    function minters(uint256) external returns (address);
    function vault() external returns (address);
    function pendingMinter() external returns (address);
    function delayMinter() external returns (uint256);
    function pendingVault() external returns (address);
    function delayVault() external returns (uint256);
    function pendingDelay() external returns (uint256);
    function delayDelay() external returns (uint256);
    function nonces(address) external returns (uint256);
    function allowance(address,address) external returns (uint256);
    function owner() external view returns (address);
    function mpc() external view returns (address);
    function setVaultOnly(bool) external;
    function initVault(address) external;
    function setMinter(address) external;
    function setVault(address) external;
    function applyVault() external;
    function applyMinter() external;
    function revokeMinter(address) external;
    function getAllMinters() external view returns (address[] memory);
    function changeVault(address) external returns (bool);
    function changeMPCOwner(address) external returns (bool);
    function mint(address,uint256) external returns (bool);
    function burn(address,uint256) external returns (bool);
    function Swapin(bytes32,address,uint256) external returns (bool);
    function Swapout(uint256,address) external returns (bool);
    function totalSupply() external view returns (uint256);
    function depositWithPermit(address,uint256,uint256,uint8,bytes32,bytes32,address) external returns (uint256);
    function depositWithTransferPermit(address,uint256,uint256,uint8,bytes32,bytes32,address) external returns (uint256);
    function deposit() external returns (uint256);
    function deposit(uint256) external returns (uint256);
    function deposit(uint256,address) external returns (uint256);
    function depositVault(uint256,address) external returns (uint256);
    function withdraw() external returns (uint256);
    function withdraw(uint256) external returns (uint256);
    function withdraw(uint256,address) external returns (uint256);
    function withdrawVault(address,uint256,address) external returns (uint256);
    function approve(address,uint256) external returns (bool);
    function approveAndCall(address,uint256,bytes calldata) external returns (bool);
    function permit(address,address,uint256,uint256,uint8,bytes32,bytes32) external;
    function transferWithPermit(address,address,uint256,uint256,uint8,bytes32,bytes32) external returns (bool);
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function transferAndCall(address,uint256,bytes calldata) external returns (bool);
    function rescueERC20(address,uint256) external;
}

interface ICErc20Delegator {
    struct BorrowSnapshot {
        uint256 principal;
        uint256 interestIndex;
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
    function accrualBlockTimestamp() external returns (uint256);
    function borrowIndex() external returns (uint256);
    function totalBorrows() external returns (uint256);
    function totalReserves() external returns (uint256);
    function totalSupply() external returns (uint256);
    function isCToken() external returns (bool);
    function underlying() external returns (address);
    function implementation() external returns (address);
    function _setImplementation(address,bool,bytes memory) external;
    function mint(uint256) external returns (uint256);
    function redeem(uint256) external returns (uint256);
    function redeemUnderlying(uint256) external returns (uint256);
    function borrow(uint256) external returns (uint256);
    function repayBorrow(uint256) external returns (uint256);
    function repayBorrowBehalf(address,uint256) external returns (uint256);
    function liquidateBorrow(address,uint256,address) external returns (uint256);
    function transfer(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function approve(address,uint256) external returns (bool);
    function allowance(address,address) external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function balanceOfUnderlying(address) external returns (uint256);
    function getAccountSnapshot(address) external view returns (uint256,uint256,uint256,uint256);
    function borrowRatePerSecond() external view returns (uint256);
    function supplyRatePerSecond() external view returns (uint256);
    function totalBorrowsCurrent() external returns (uint256);
    function borrowBalanceCurrent(address) external returns (uint256);
    function borrowBalanceStored(address) external view returns (uint256);
    function exchangeRateCurrent() external returns (uint256);
    function exchangeRateStored() external view returns (uint256);
    function getCash() external view returns (uint256);
    function accrueInterest() external returns (uint256);
    function seize(address,address,uint256) external returns (uint256);
    function sweepToken(address) external;
    function _setPendingAdmin(address) external returns (uint256);
    function _setComptroller(address) external returns (uint256);
    function _setReserveFactor(uint256) external returns (uint256);
    function _acceptAdmin() external returns (uint256);
    function _addReserves(uint256) external returns (uint256);
    function _reduceReserves(uint256) external returns (uint256);
    function _setInterestRateModel(address) external returns (uint256);
    function delegateToImplementation(bytes memory) external returns (bytes memory);
    function delegateToViewImplementation(bytes memory) external view returns (bytes memory);
}

interface IUnitroller {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY, MARKET_DOES_NOT_SUPPORT_REQUESTED_CHAIN, MARKET_ENTERED_ON_ANOTHER_CHAIN }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, SET_PAUSE_GUARDIAN_OWNER_CHECK, CALLABLE_ONLY_FROM_CROSS_CHAIN_GATE }
    function admin() external returns (address);
    function pendingAdmin() external returns (address);
    function implementation() external returns (address);
    function pendingImplementation() external returns (address);
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

    IComptrollerV1 comptrollerV1;
    IComptrollerV2 comptrollerV2;
    IUnitroller unitroller;
    IHundred hND;
    ICErc20Delegator hWBTC;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

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

    constructor() public {
        hevm.roll(90761917);
        hevm.warp(1681567920);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        comptrollerV1 = IComptrollerV1(0x8279b109D3a8A61fCDB2532F08E14E763a064Be1);
        comptrollerV2 = IComptrollerV2(0x4e0e206a3E10Ca372aB7AFae840993ec02d6C815);
        unitroller = IUnitroller(0x5a5755E1916F547D04eF43176d4cbe0de4503d5d);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(unitroller),
            bytes32(uint(2)),
            bytes32(uint256(uint160(address(comptrollerV1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(unitroller),
            bytes32(uint(2)),
            bytes32(uint256(uint160(address(comptrollerV1))))
        );
        hND = IHundred(0x10010078a54396F62c96dF8532dc2B4847d47ED3);
        hWBTC = ICErc20Delegator(0x35594E4992DFefcB0C20EC487d7af22a30bDec60);
    }

    /*** Upgrade Function ***/ 

    // TODO: Consider replacing this with the actual upgrade method
    function upgradeV2() external virtual {
        hevm.selectFork(fork2);
        hevm.store(
            address(unitroller),
            bytes32(uint(2)),
            bytes32(uint256(uint160(address(comptrollerV2))))
        );
        hevm.selectFork(fork1);
        bytes32 impl1 = hevm.load(
            address(unitroller),
            bytes32(uint(2))
        );
        bytes32 implV1 = bytes32(uint256(uint160(address(comptrollerV1))));
        assert(impl1 == implV1);
    }


    /*** Modified Functions ***/ 

    function Comptroller_exitMarket(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'exitMarket(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'exitMarket(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_borrowAllowed(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'borrowAllowed(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'borrowAllowed(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_repayBorrowAllowed(address a, address b, address c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'repayBorrowAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'repayBorrowAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_liquidateBorrowAllowed(address a, address b, address c, address d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'liquidateBorrowAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'liquidateBorrowAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_getAccountLiquidity(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'getAccountLiquidity(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'getAccountLiquidity(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller__supportMarket(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                '_supportMarket(CToken)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                '_supportMarket(CToken)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function Comptroller_getAssetsIn(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'getAssetsIn(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'getAssetsIn(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_checkMembership(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'checkMembership(address,CToken)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'checkMembership(address,CToken)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_enterMarkets(address[] memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'enterMarkets(address[])', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'enterMarkets(address[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_mintAllowed(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'mintAllowed(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'mintAllowed(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_redeemAllowed(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'redeemAllowed(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'redeemAllowed(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_seizeAllowed(address a, address b, address c, address d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'seizeAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'seizeAllowed(address,address,address,address,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_transferAllowed(address a, address b, address c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'transferAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'transferAllowed(address,address,address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_getHypotheticalAccountLiquidity(address a, address b, uint256 c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'getHypotheticalAccountLiquidity(address,address,uint256,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'getHypotheticalAccountLiquidity(address,address,uint256,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller__setCollateralFactor(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setCollateralFactor(CToken,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setCollateralFactor(CToken,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller__setMintPaused(address a, bool b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setMintPaused(CToken,bool)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setMintPaused(CToken,bool)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller__setBorrowPaused(address a, bool b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setBorrowPaused(CToken,bool)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setBorrowPaused(CToken,bool)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_updateContributorRewards(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'updateContributorRewards(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'updateContributorRewards(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_claimComp(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'claimComp(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'claimComp(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_claimComp(address a, address[] memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'claimComp(address,CToken[])', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'claimComp(address,CToken[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller__grantComp(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                '_grantComp(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                '_grantComp(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller__setContributorCompSpeed(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setContributorCompSpeed(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setContributorCompSpeed(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Comptroller_getAllMarkets() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'getAllMarkets()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'getAllMarkets()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function Comptroller_mintVerify(address a, address b, uint256 c, uint256 d) public virtual {
        // This function does nothing with the V1, since mintVerify is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'mintVerify(address,address,uint256,uint256)', a, b, c, d
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

    function Comptroller_borrowVerify(address a, address b, uint256 c) public virtual {
        // This function does nothing with the V1, since borrowVerify is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'borrowVerify(address,address,uint256)', a, b, c
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

    function Comptroller_repayBorrowVerify(address a, address b, address c, uint256 d, uint256 e) public virtual {
        // This function does nothing with the V1, since repayBorrowVerify is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'repayBorrowVerify(address,address,address,uint256,uint256)', a, b, c, d, e
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

    function Comptroller_liquidateBorrowVerify(address a, address b, address c, address d, uint256 e, uint256 f) public virtual {
        // This function does nothing with the V1, since liquidateBorrowVerify is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'liquidateBorrowVerify(address,address,address,address,uint256,uint256)', a, b, c, d, e, f
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

    function Comptroller_seizeVerify(address a, address b, address c, address d, uint256 e) public virtual {
        // This function does nothing with the V1, since seizeVerify is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'seizeVerify(address,address,address,address,uint256)', a, b, c, d, e
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

    function Comptroller_transferVerify(address a, address b, address c, uint256 d) public virtual {
        // This function does nothing with the V1, since transferVerify is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'transferVerify(address,address,address,uint256)', a, b, c, d
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

    function Comptroller_fixBadAccruals(address[] calldata a, uint256[] calldata b) public virtual {
        // This function does nothing with the V1, since fixBadAccruals is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'fixBadAccruals(address[],uint256[])', a, b
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

    // TODO: Double-check this function for correctness
    // Comptroller.claimComp(address[],CToken[],bool,bool)
    // is a new function which appears to replace a function with a similar name,
    // Comptroller.claimComp(address).
    // If the functions have different arguments this function may be incorrect.
    function Comptroller_claimComp(address[] memory a, address[] memory b, bool c, bool d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                'claimComp(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        hevm.prank(msg.sender);
        bool successV2;
        bytes memory outputV2;
        if(impl == address(comptrollerV2)) {
            (successV2, outputV2) = address(unitroller).call(
                abi.encodeWithSignature(
                        'claimComp(address[],CToken[],bool,bool)', a, b, c, d
                )
            );
        } else {
            (successV2, outputV2) = address(unitroller).call(
                abi.encodeWithSignature(
                        'claimComp(address)', a
                )
            );
        }
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    // TODO: Double-check this function for correctness
    // Comptroller._setCompSpeeds(CToken[],uint256[],uint256[])
    // is a new function which appears to replace a function with a similar name,
    // Comptroller._setCompSpeed(CToken,uint256).
    // If the functions have different arguments this function may be incorrect.
    function Comptroller__setCompSpeeds(address[] memory a, uint256[] memory b, uint256[] memory c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSignature(
                '_setCompSpeed(CToken,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        bool successV2;
        bytes memory outputV2;
        if(impl == address(comptrollerV2)) {
            (successV2, outputV2) = address(unitroller).call(
                abi.encodeWithSignature(
                        '_setCompSpeeds(CToken[],uint256[],uint256[])', a, b, c
                )
            );
        } else {
            (successV2, outputV2) = address(unitroller).call(
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

    function Comptroller_isDeprecated(address a) public virtual {
        // This function does nothing with the V1, since isDeprecated is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(unitroller),0x0000000000000000000000000000000000000000000000000000000000000002)
        )));
        require(impl == address(comptrollerV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSignature(
                'isDeprecated(CToken)', a
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

    function Comptroller_mintGuardianPaused(address a) public virtual returns (bool) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        bool a1 = IComptrollerV1(address(unitroller)).mintGuardianPaused(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        bool a2 = IComptrollerV2(address(unitroller)).mintGuardianPaused(a);
        assert(a1 == a2);
        return a1;
    }

    function Comptroller_borrowGuardianPaused(address a) public virtual returns (bool) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        bool a1 = IComptrollerV1(address(unitroller)).borrowGuardianPaused(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        bool a2 = IComptrollerV2(address(unitroller)).borrowGuardianPaused(a);
        assert(a1 == a2);
        return a1;
    }

    function Comptroller_allMarkets(uint i) public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = IComptrollerV1(address(unitroller)).allMarkets(i);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = IComptrollerV2(address(unitroller)).allMarkets(i);
        assert(a1 == a2);
        return a1;
    }

    function Comptroller_compAccrued(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IComptrollerV1(address(unitroller)).compAccrued(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IComptrollerV2(address(unitroller)).compAccrued(a);
        assert(a1 == a2);
        return a1;
    }

    function Comptroller_compContributorSpeeds(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IComptrollerV1(address(unitroller)).compContributorSpeeds(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IComptrollerV2(address(unitroller)).compContributorSpeeds(a);
        assert(a1 == a2);
        return a1;
    }

    function Comptroller_lastContributorBlock(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IComptrollerV1(address(unitroller)).lastContributorBlock(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IComptrollerV2(address(unitroller)).lastContributorBlock(a);
        assert(a1 == a2);
        return a1;
    }


    /*** Additional Targets ***/ 

    function HND_Swapin(bytes32 a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'Swapin(bytes32,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'Swapin(bytes32,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_Swapout(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'Swapout(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'Swapout(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_allowance(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_applyMinter() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'applyMinter()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'applyMinter()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_applyVault() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'applyVault()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'applyVault()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_approveAndCall(address a, uint256 b, bytes calldata c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'approveAndCall(address,uint256,bytes)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'approveAndCall(address,uint256,bytes)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_burn(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_changeMPCOwner(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'changeMPCOwner(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'changeMPCOwner(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_changeVault(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'changeVault(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'changeVault(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_decimals() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_deposit() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'deposit()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'deposit()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_deposit(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'deposit(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'deposit(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_deposit(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'deposit(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'deposit(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_depositVault(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'depositVault(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'depositVault(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_depositWithPermit(address a, uint256 b, uint256 c, uint8 d, bytes32 e, bytes32 f, address g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'depositWithPermit(address,uint256,uint256,uint8,bytes32,bytes32,address)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'depositWithPermit(address,uint256,uint256,uint8,bytes32,bytes32,address)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_depositWithTransferPermit(address a, uint256 b, uint256 c, uint8 d, bytes32 e, bytes32 f, address g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'depositWithTransferPermit(address,uint256,uint256,uint8,bytes32,bytes32,address)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'depositWithTransferPermit(address,uint256,uint256,uint8,bytes32,bytes32,address)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_getAllMinters() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'getAllMinters()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'getAllMinters()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_initVault(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'initVault(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'initVault(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_mint(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_mpc() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'mpc()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'mpc()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_nonces(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'nonces(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'nonces(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_owner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_permit(address a, address b, uint256 c, uint256 d, uint8 e, bytes32 f, bytes32 g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_rescueERC20(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'rescueERC20(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'rescueERC20(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_revokeMinter(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'revokeMinter(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'revokeMinter(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_setMinter(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'setMinter(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'setMinter(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_setVault(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'setVault(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'setVault(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_setVaultOnly(bool a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'setVaultOnly(bool)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'setVaultOnly(bool)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_totalSupply() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_transferAndCall(address a, uint256 b, bytes calldata c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'transferAndCall(address,uint256,bytes)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'transferAndCall(address,uint256,bytes)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_transferWithPermit(address a, address b, uint256 c, uint256 d, uint8 e, bytes32 f, bytes32 g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'transferWithPermit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'transferWithPermit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_withdraw() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'withdraw()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'withdraw()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_withdraw(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'withdraw(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'withdraw(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_withdraw(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'withdraw(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'withdraw(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function HND_withdrawVault(address a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hND).call(
            abi.encodeWithSignature(
                'withdrawVault(address,uint256,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hND).call(
            abi.encodeWithSignature(
                'withdrawVault(address,uint256,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__acceptAdmin() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_acceptAdmin()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_acceptAdmin()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__addReserves(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_addReserves(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_addReserves(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__reduceReserves(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_reduceReserves(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_reduceReserves(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__setComptroller(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setComptroller(ComptrollerInterface)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setComptroller(ComptrollerInterface)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__setImplementation(address a, bool b, bytes memory c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setImplementation(address,bool,bytes)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setImplementation(address,bool,bytes)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__setInterestRateModel(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setInterestRateModel(InterestRateModel)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setInterestRateModel(InterestRateModel)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__setPendingAdmin(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setPendingAdmin(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setPendingAdmin(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC__setReserveFactor(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setReserveFactor(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                '_setReserveFactor(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_accrueInterest() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'accrueInterest()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'accrueInterest()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_allowance(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_balanceOfUnderlying(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'balanceOfUnderlying(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'balanceOfUnderlying(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_borrow(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrow(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrow(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_borrowBalanceCurrent(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrowBalanceCurrent(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrowBalanceCurrent(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_borrowBalanceStored(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrowBalanceStored(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrowBalanceStored(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_borrowRatePerSecond() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrowRatePerSecond()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'borrowRatePerSecond()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_delegateToImplementation(bytes memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'delegateToImplementation(bytes)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'delegateToImplementation(bytes)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_delegateToViewImplementation(bytes memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'delegateToViewImplementation(bytes)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'delegateToViewImplementation(bytes)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_exchangeRateCurrent() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'exchangeRateCurrent()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'exchangeRateCurrent()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_exchangeRateStored() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'exchangeRateStored()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'exchangeRateStored()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_getAccountSnapshot(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'getAccountSnapshot(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'getAccountSnapshot(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_getCash() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'getCash()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'getCash()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_liquidateBorrow(address a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'liquidateBorrow(address,uint256,CTokenInterface)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'liquidateBorrow(address,uint256,CTokenInterface)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_mint(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'mint(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'mint(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_redeem(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'redeem(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'redeem(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_redeemUnderlying(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'redeemUnderlying(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'redeemUnderlying(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_repayBorrow(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'repayBorrow(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'repayBorrow(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_repayBorrowBehalf(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'repayBorrowBehalf(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'repayBorrowBehalf(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_seize(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'seize(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'seize(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_supplyRatePerSecond() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'supplyRatePerSecond()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'supplyRatePerSecond()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_sweepToken(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'sweepToken(EIP20NonStandardInterface)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'sweepToken(EIP20NonStandardInterface)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_totalBorrowsCurrent() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'totalBorrowsCurrent()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'totalBorrowsCurrent()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function hWBTC_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(hWBTC).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(hWBTC).call(
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
