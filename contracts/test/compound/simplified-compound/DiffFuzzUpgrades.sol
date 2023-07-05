// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.10;

interface IComptrollerV1 {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, SET_PAUSE_GUARDIAN_OWNER_CHECK }
    struct Market {
        bool isListed;
        uint256 collateralFactorMantissa;
        // mapping(address => bool) accountMembership;
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
    function markets(address) external returns (Market memory);
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
    // function claimComp(address,address[] memory) external;
    // function claimComp(address[] memory,address[] memory,bool,bool) external;
    function _grantComp(address,uint256) external;
    function _setCompSpeed(address,uint256) external;
    function _setContributorCompSpeed(address,uint256) external;
    function getAllMarkets() external view returns (address[] memory);
    function isDeprecated(address) external view returns (bool);
    function getBlockNumber() external view returns (uint256);
    function getCompAddress() external view returns (address);
}

interface IComptrollerV2 {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, SET_PAUSE_GUARDIAN_OWNER_CHECK }
    struct Market {
        bool isListed;
        uint256 collateralFactorMantissa;
        // mapping(address => bool) accountMembership;
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
    function markets(address) external returns (Market memory);
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
    // function claimComp(address,address[] memory) external;
    // function claimComp(address[] memory,address[] memory,bool,bool) external;
    function _grantComp(address,uint256) external;
    function _setCompSpeeds(address[] memory,uint256[] memory,uint256[] memory) external;
    function _setContributorCompSpeed(address,uint256) external;
    function getAllMarkets() external view returns (address[] memory);
    function isDeprecated(address) external view returns (bool);
    function getBlockNumber() external view returns (uint256);
    function getCompAddress() external view returns (address);
}

interface ICEther {
    enum Error { NO_ERROR, UNAUTHORIZED, BAD_INPUT, COMPTROLLER_REJECTION, COMPTROLLER_CALCULATION_ERROR, INTEREST_RATE_MODEL_ERROR, INVALID_ACCOUNT_PAIR, INVALID_CLOSE_AMOUNT_REQUESTED, INVALID_COLLATERAL_FACTOR, MATH_ERROR, MARKET_NOT_FRESH, MARKET_NOT_LISTED, TOKEN_INSUFFICIENT_ALLOWANCE, TOKEN_INSUFFICIENT_BALANCE, TOKEN_INSUFFICIENT_CASH, TOKEN_TRANSFER_IN_FAILED, TOKEN_TRANSFER_OUT_FAILED }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCRUE_INTEREST_ACCUMULATED_INTEREST_CALCULATION_FAILED, ACCRUE_INTEREST_BORROW_RATE_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_BORROW_INDEX_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_TOTAL_BORROWS_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_TOTAL_RESERVES_CALCULATION_FAILED, ACCRUE_INTEREST_SIMPLE_INTEREST_FACTOR_CALCULATION_FAILED, BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, BORROW_ACCRUE_INTEREST_FAILED, BORROW_CASH_NOT_AVAILABLE, BORROW_FRESHNESS_CHECK, BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED, BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED, BORROW_MARKET_NOT_LISTED, BORROW_COMPTROLLER_REJECTION, LIQUIDATE_ACCRUE_BORROW_INTEREST_FAILED, LIQUIDATE_ACCRUE_COLLATERAL_INTEREST_FAILED, LIQUIDATE_COLLATERAL_FRESHNESS_CHECK, LIQUIDATE_COMPTROLLER_REJECTION, LIQUIDATE_COMPTROLLER_CALCULATE_AMOUNT_SEIZE_FAILED, LIQUIDATE_CLOSE_AMOUNT_IS_UINT_MAX, LIQUIDATE_CLOSE_AMOUNT_IS_ZERO, LIQUIDATE_FRESHNESS_CHECK, LIQUIDATE_LIQUIDATOR_IS_BORROWER, LIQUIDATE_REPAY_BORROW_FRESH_FAILED, LIQUIDATE_SEIZE_BALANCE_INCREMENT_FAILED, LIQUIDATE_SEIZE_BALANCE_DECREMENT_FAILED, LIQUIDATE_SEIZE_COMPTROLLER_REJECTION, LIQUIDATE_SEIZE_LIQUIDATOR_IS_BORROWER, LIQUIDATE_SEIZE_TOO_MUCH, MINT_ACCRUE_INTEREST_FAILED, MINT_COMPTROLLER_REJECTION, MINT_EXCHANGE_CALCULATION_FAILED, MINT_EXCHANGE_RATE_READ_FAILED, MINT_FRESHNESS_CHECK, MINT_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED, MINT_NEW_TOTAL_SUPPLY_CALCULATION_FAILED, MINT_TRANSFER_IN_FAILED, MINT_TRANSFER_IN_NOT_POSSIBLE, REDEEM_ACCRUE_INTEREST_FAILED, REDEEM_COMPTROLLER_REJECTION, REDEEM_EXCHANGE_TOKENS_CALCULATION_FAILED, REDEEM_EXCHANGE_AMOUNT_CALCULATION_FAILED, REDEEM_EXCHANGE_RATE_READ_FAILED, REDEEM_FRESHNESS_CHECK, REDEEM_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED, REDEEM_NEW_TOTAL_SUPPLY_CALCULATION_FAILED, REDEEM_TRANSFER_OUT_NOT_POSSIBLE, REDUCE_RESERVES_ACCRUE_INTEREST_FAILED, REDUCE_RESERVES_ADMIN_CHECK, REDUCE_RESERVES_CASH_NOT_AVAILABLE, REDUCE_RESERVES_FRESH_CHECK, REDUCE_RESERVES_VALIDATION, REPAY_BEHALF_ACCRUE_INTEREST_FAILED, REPAY_BORROW_ACCRUE_INTEREST_FAILED, REPAY_BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, REPAY_BORROW_COMPTROLLER_REJECTION, REPAY_BORROW_FRESHNESS_CHECK, REPAY_BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED, REPAY_BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED, REPAY_BORROW_TRANSFER_IN_NOT_POSSIBLE, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_VALIDATION, SET_COMPTROLLER_OWNER_CHECK, SET_INTEREST_RATE_MODEL_ACCRUE_INTEREST_FAILED, SET_INTEREST_RATE_MODEL_FRESH_CHECK, SET_INTEREST_RATE_MODEL_OWNER_CHECK, SET_MAX_ASSETS_OWNER_CHECK, SET_ORACLE_MARKET_NOT_LISTED, SET_PENDING_ADMIN_OWNER_CHECK, SET_RESERVE_FACTOR_ACCRUE_INTEREST_FAILED, SET_RESERVE_FACTOR_ADMIN_CHECK, SET_RESERVE_FACTOR_FRESH_CHECK, SET_RESERVE_FACTOR_BOUNDS_CHECK, TRANSFER_COMPTROLLER_REJECTION, TRANSFER_NOT_ALLOWED, TRANSFER_NOT_ENOUGH, TRANSFER_TOO_MUCH }
    enum MathError { NO_ERROR, DIVISION_BY_ZERO, INTEGER_OVERFLOW, INTEGER_UNDERFLOW }
    struct Exp {
        uint256 mantissa;
    }
    struct BorrowSnapshot {
        uint256 principal;
        uint256 interestIndex;
    }
    struct AccrueInterestLocalVars {
        MathError mathErr;
        uint256 opaqueErr;
        uint256 borrowRateMantissa;
        uint256 currentBlockNumber;
        uint256 blockDelta;
        Exp simpleInterestFactor;
        uint256 interestAccumulated;
        uint256 totalBorrowsNew;
        uint256 totalReservesNew;
        uint256 borrowIndexNew;
    }
    struct MintLocalVars {
        Error err;
        MathError mathErr;
        uint256 exchangeRateMantissa;
        uint256 mintTokens;
        uint256 totalSupplyNew;
        uint256 accountTokensNew;
    }
    struct RedeemLocalVars {
        Error err;
        MathError mathErr;
        uint256 exchangeRateMantissa;
        uint256 redeemTokens;
        uint256 redeemAmount;
        uint256 totalSupplyNew;
        uint256 accountTokensNew;
    }
    struct BorrowLocalVars {
        Error err;
        MathError mathErr;
        uint256 accountBorrows;
        uint256 accountBorrowsNew;
        uint256 totalBorrowsNew;
    }
    struct RepayBorrowLocalVars {
        Error err;
        MathError mathErr;
        uint256 repayAmount;
        uint256 borrowerIndex;
        uint256 accountBorrows;
        uint256 accountBorrowsNew;
        uint256 totalBorrowsNew;
    }
    function isCToken() external returns (bool);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint256);
    function admin() external returns (address);
    function pendingAdmin() external returns (address);
    function comptroller() external returns (address);
    function interestRateModel() external returns (address);
    function initialExchangeRateMantissa() external returns (uint256);
    function reserveFactorMantissa() external returns (uint256);
    function accrualBlockNumber() external returns (uint256);
    function borrowIndex() external returns (uint256);
    function totalBorrows() external returns (uint256);
    function totalReserves() external returns (uint256);
    // function totalSupply() external returns (uint256);
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
    function totalSupply() external view returns (uint256);
    function mint() external payable;
    function redeem(uint256) external returns (uint256);
    function redeemUnderlying(uint256) external returns (uint256);
    function borrow(uint256) external returns (uint256);
    function repayBorrow() external payable;
    function repayBorrowBehalf(address) external payable;
    function liquidateBorrow(address,address) external payable;
}

interface ICErc20 {
    enum Error { NO_ERROR, UNAUTHORIZED, BAD_INPUT, COMPTROLLER_REJECTION, COMPTROLLER_CALCULATION_ERROR, INTEREST_RATE_MODEL_ERROR, INVALID_ACCOUNT_PAIR, INVALID_CLOSE_AMOUNT_REQUESTED, INVALID_COLLATERAL_FACTOR, MATH_ERROR, MARKET_NOT_FRESH, MARKET_NOT_LISTED, TOKEN_INSUFFICIENT_ALLOWANCE, TOKEN_INSUFFICIENT_BALANCE, TOKEN_INSUFFICIENT_CASH, TOKEN_TRANSFER_IN_FAILED, TOKEN_TRANSFER_OUT_FAILED }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCRUE_INTEREST_ACCUMULATED_INTEREST_CALCULATION_FAILED, ACCRUE_INTEREST_BORROW_RATE_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_BORROW_INDEX_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_TOTAL_BORROWS_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_TOTAL_RESERVES_CALCULATION_FAILED, ACCRUE_INTEREST_SIMPLE_INTEREST_FACTOR_CALCULATION_FAILED, BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, BORROW_ACCRUE_INTEREST_FAILED, BORROW_CASH_NOT_AVAILABLE, BORROW_FRESHNESS_CHECK, BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED, BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED, BORROW_MARKET_NOT_LISTED, BORROW_COMPTROLLER_REJECTION, LIQUIDATE_ACCRUE_BORROW_INTEREST_FAILED, LIQUIDATE_ACCRUE_COLLATERAL_INTEREST_FAILED, LIQUIDATE_COLLATERAL_FRESHNESS_CHECK, LIQUIDATE_COMPTROLLER_REJECTION, LIQUIDATE_COMPTROLLER_CALCULATE_AMOUNT_SEIZE_FAILED, LIQUIDATE_CLOSE_AMOUNT_IS_UINT_MAX, LIQUIDATE_CLOSE_AMOUNT_IS_ZERO, LIQUIDATE_FRESHNESS_CHECK, LIQUIDATE_LIQUIDATOR_IS_BORROWER, LIQUIDATE_REPAY_BORROW_FRESH_FAILED, LIQUIDATE_SEIZE_BALANCE_INCREMENT_FAILED, LIQUIDATE_SEIZE_BALANCE_DECREMENT_FAILED, LIQUIDATE_SEIZE_COMPTROLLER_REJECTION, LIQUIDATE_SEIZE_LIQUIDATOR_IS_BORROWER, LIQUIDATE_SEIZE_TOO_MUCH, MINT_ACCRUE_INTEREST_FAILED, MINT_COMPTROLLER_REJECTION, MINT_EXCHANGE_CALCULATION_FAILED, MINT_EXCHANGE_RATE_READ_FAILED, MINT_FRESHNESS_CHECK, MINT_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED, MINT_NEW_TOTAL_SUPPLY_CALCULATION_FAILED, MINT_TRANSFER_IN_FAILED, MINT_TRANSFER_IN_NOT_POSSIBLE, REDEEM_ACCRUE_INTEREST_FAILED, REDEEM_COMPTROLLER_REJECTION, REDEEM_EXCHANGE_TOKENS_CALCULATION_FAILED, REDEEM_EXCHANGE_AMOUNT_CALCULATION_FAILED, REDEEM_EXCHANGE_RATE_READ_FAILED, REDEEM_FRESHNESS_CHECK, REDEEM_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED, REDEEM_NEW_TOTAL_SUPPLY_CALCULATION_FAILED, REDEEM_TRANSFER_OUT_NOT_POSSIBLE, REDUCE_RESERVES_ACCRUE_INTEREST_FAILED, REDUCE_RESERVES_ADMIN_CHECK, REDUCE_RESERVES_CASH_NOT_AVAILABLE, REDUCE_RESERVES_FRESH_CHECK, REDUCE_RESERVES_VALIDATION, REPAY_BEHALF_ACCRUE_INTEREST_FAILED, REPAY_BORROW_ACCRUE_INTEREST_FAILED, REPAY_BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, REPAY_BORROW_COMPTROLLER_REJECTION, REPAY_BORROW_FRESHNESS_CHECK, REPAY_BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED, REPAY_BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED, REPAY_BORROW_TRANSFER_IN_NOT_POSSIBLE, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_VALIDATION, SET_COMPTROLLER_OWNER_CHECK, SET_INTEREST_RATE_MODEL_ACCRUE_INTEREST_FAILED, SET_INTEREST_RATE_MODEL_FRESH_CHECK, SET_INTEREST_RATE_MODEL_OWNER_CHECK, SET_MAX_ASSETS_OWNER_CHECK, SET_ORACLE_MARKET_NOT_LISTED, SET_PENDING_ADMIN_OWNER_CHECK, SET_RESERVE_FACTOR_ACCRUE_INTEREST_FAILED, SET_RESERVE_FACTOR_ADMIN_CHECK, SET_RESERVE_FACTOR_FRESH_CHECK, SET_RESERVE_FACTOR_BOUNDS_CHECK, TRANSFER_COMPTROLLER_REJECTION, TRANSFER_NOT_ALLOWED, TRANSFER_NOT_ENOUGH, TRANSFER_TOO_MUCH }
    enum MathError { NO_ERROR, DIVISION_BY_ZERO, INTEGER_OVERFLOW, INTEGER_UNDERFLOW }
    struct Exp {
        uint256 mantissa;
    }
    struct BorrowSnapshot {
        uint256 principal;
        uint256 interestIndex;
    }
    struct AccrueInterestLocalVars {
        MathError mathErr;
        uint256 opaqueErr;
        uint256 borrowRateMantissa;
        uint256 currentBlockNumber;
        uint256 blockDelta;
        Exp simpleInterestFactor;
        uint256 interestAccumulated;
        uint256 totalBorrowsNew;
        uint256 totalReservesNew;
        uint256 borrowIndexNew;
    }
    struct MintLocalVars {
        Error err;
        MathError mathErr;
        uint256 exchangeRateMantissa;
        uint256 mintTokens;
        uint256 totalSupplyNew;
        uint256 accountTokensNew;
    }
    struct RedeemLocalVars {
        Error err;
        MathError mathErr;
        uint256 exchangeRateMantissa;
        uint256 redeemTokens;
        uint256 redeemAmount;
        uint256 totalSupplyNew;
        uint256 accountTokensNew;
    }
    struct BorrowLocalVars {
        Error err;
        MathError mathErr;
        uint256 accountBorrows;
        uint256 accountBorrowsNew;
        uint256 totalBorrowsNew;
    }
    struct RepayBorrowLocalVars {
        Error err;
        MathError mathErr;
        uint256 repayAmount;
        uint256 borrowerIndex;
        uint256 accountBorrows;
        uint256 accountBorrowsNew;
        uint256 totalBorrowsNew;
    }
    function isCToken() external returns (bool);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint256);
    function admin() external returns (address);
    function pendingAdmin() external returns (address);
    function comptroller() external returns (address);
    function interestRateModel() external returns (address);
    function initialExchangeRateMantissa() external returns (uint256);
    function reserveFactorMantissa() external returns (uint256);
    function accrualBlockNumber() external returns (uint256);
    function borrowIndex() external returns (uint256);
    function totalBorrows() external returns (uint256);
    function totalReserves() external returns (uint256);
    // function totalSupply() external returns (uint256);
    function underlying() external returns (address);
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
    function totalSupply() external view returns (uint256);
    function mint(uint256) external returns (uint256);
    function redeem(uint256) external returns (uint256);
    function redeemUnderlying(uint256) external returns (uint256);
    function borrow(uint256) external returns (uint256);
    function repayBorrow(uint256) external returns (uint256);
    function repayBorrowBehalf(address,uint256) external returns (uint256);
    function liquidateBorrow(address,uint256,address) external returns (uint256);
}

interface IComp {
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
}

interface ICToken {
    enum Error { NO_ERROR, UNAUTHORIZED, BAD_INPUT, COMPTROLLER_REJECTION, COMPTROLLER_CALCULATION_ERROR, INTEREST_RATE_MODEL_ERROR, INVALID_ACCOUNT_PAIR, INVALID_CLOSE_AMOUNT_REQUESTED, INVALID_COLLATERAL_FACTOR, MATH_ERROR, MARKET_NOT_FRESH, MARKET_NOT_LISTED, TOKEN_INSUFFICIENT_ALLOWANCE, TOKEN_INSUFFICIENT_BALANCE, TOKEN_INSUFFICIENT_CASH, TOKEN_TRANSFER_IN_FAILED, TOKEN_TRANSFER_OUT_FAILED }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCRUE_INTEREST_ACCUMULATED_INTEREST_CALCULATION_FAILED, ACCRUE_INTEREST_BORROW_RATE_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_BORROW_INDEX_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_TOTAL_BORROWS_CALCULATION_FAILED, ACCRUE_INTEREST_NEW_TOTAL_RESERVES_CALCULATION_FAILED, ACCRUE_INTEREST_SIMPLE_INTEREST_FACTOR_CALCULATION_FAILED, BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, BORROW_ACCRUE_INTEREST_FAILED, BORROW_CASH_NOT_AVAILABLE, BORROW_FRESHNESS_CHECK, BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED, BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED, BORROW_MARKET_NOT_LISTED, BORROW_COMPTROLLER_REJECTION, LIQUIDATE_ACCRUE_BORROW_INTEREST_FAILED, LIQUIDATE_ACCRUE_COLLATERAL_INTEREST_FAILED, LIQUIDATE_COLLATERAL_FRESHNESS_CHECK, LIQUIDATE_COMPTROLLER_REJECTION, LIQUIDATE_COMPTROLLER_CALCULATE_AMOUNT_SEIZE_FAILED, LIQUIDATE_CLOSE_AMOUNT_IS_UINT_MAX, LIQUIDATE_CLOSE_AMOUNT_IS_ZERO, LIQUIDATE_FRESHNESS_CHECK, LIQUIDATE_LIQUIDATOR_IS_BORROWER, LIQUIDATE_REPAY_BORROW_FRESH_FAILED, LIQUIDATE_SEIZE_BALANCE_INCREMENT_FAILED, LIQUIDATE_SEIZE_BALANCE_DECREMENT_FAILED, LIQUIDATE_SEIZE_COMPTROLLER_REJECTION, LIQUIDATE_SEIZE_LIQUIDATOR_IS_BORROWER, LIQUIDATE_SEIZE_TOO_MUCH, MINT_ACCRUE_INTEREST_FAILED, MINT_COMPTROLLER_REJECTION, MINT_EXCHANGE_CALCULATION_FAILED, MINT_EXCHANGE_RATE_READ_FAILED, MINT_FRESHNESS_CHECK, MINT_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED, MINT_NEW_TOTAL_SUPPLY_CALCULATION_FAILED, MINT_TRANSFER_IN_FAILED, MINT_TRANSFER_IN_NOT_POSSIBLE, REDEEM_ACCRUE_INTEREST_FAILED, REDEEM_COMPTROLLER_REJECTION, REDEEM_EXCHANGE_TOKENS_CALCULATION_FAILED, REDEEM_EXCHANGE_AMOUNT_CALCULATION_FAILED, REDEEM_EXCHANGE_RATE_READ_FAILED, REDEEM_FRESHNESS_CHECK, REDEEM_NEW_ACCOUNT_BALANCE_CALCULATION_FAILED, REDEEM_NEW_TOTAL_SUPPLY_CALCULATION_FAILED, REDEEM_TRANSFER_OUT_NOT_POSSIBLE, REDUCE_RESERVES_ACCRUE_INTEREST_FAILED, REDUCE_RESERVES_ADMIN_CHECK, REDUCE_RESERVES_CASH_NOT_AVAILABLE, REDUCE_RESERVES_FRESH_CHECK, REDUCE_RESERVES_VALIDATION, REPAY_BEHALF_ACCRUE_INTEREST_FAILED, REPAY_BORROW_ACCRUE_INTEREST_FAILED, REPAY_BORROW_ACCUMULATED_BALANCE_CALCULATION_FAILED, REPAY_BORROW_COMPTROLLER_REJECTION, REPAY_BORROW_FRESHNESS_CHECK, REPAY_BORROW_NEW_ACCOUNT_BORROW_BALANCE_CALCULATION_FAILED, REPAY_BORROW_NEW_TOTAL_BALANCE_CALCULATION_FAILED, REPAY_BORROW_TRANSFER_IN_NOT_POSSIBLE, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_VALIDATION, SET_COMPTROLLER_OWNER_CHECK, SET_INTEREST_RATE_MODEL_ACCRUE_INTEREST_FAILED, SET_INTEREST_RATE_MODEL_FRESH_CHECK, SET_INTEREST_RATE_MODEL_OWNER_CHECK, SET_MAX_ASSETS_OWNER_CHECK, SET_ORACLE_MARKET_NOT_LISTED, SET_PENDING_ADMIN_OWNER_CHECK, SET_RESERVE_FACTOR_ACCRUE_INTEREST_FAILED, SET_RESERVE_FACTOR_ADMIN_CHECK, SET_RESERVE_FACTOR_FRESH_CHECK, SET_RESERVE_FACTOR_BOUNDS_CHECK, TRANSFER_COMPTROLLER_REJECTION, TRANSFER_NOT_ALLOWED, TRANSFER_NOT_ENOUGH, TRANSFER_TOO_MUCH, ADD_RESERVES_ACCRUE_INTEREST_FAILED, ADD_RESERVES_FRESH_CHECK, ADD_RESERVES_TRANSFER_IN_NOT_POSSIBLE }
    enum MathError { NO_ERROR, DIVISION_BY_ZERO, INTEGER_OVERFLOW, INTEGER_UNDERFLOW }
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
    struct MintLocalVars {
        Error err;
        MathError mathErr;
        uint256 exchangeRateMantissa;
        uint256 mintTokens;
        uint256 totalSupplyNew;
        uint256 accountTokensNew;
        uint256 actualMintAmount;
    }
    struct RedeemLocalVars {
        Error err;
        MathError mathErr;
        uint256 exchangeRateMantissa;
        uint256 redeemTokens;
        uint256 redeemAmount;
        uint256 totalSupplyNew;
        uint256 accountTokensNew;
    }
    struct BorrowLocalVars {
        MathError mathErr;
        uint256 accountBorrows;
        uint256 accountBorrowsNew;
        uint256 totalBorrowsNew;
    }
    struct RepayBorrowLocalVars {
        Error err;
        MathError mathErr;
        uint256 repayAmount;
        uint256 borrowerIndex;
        uint256 accountBorrows;
        uint256 accountBorrowsNew;
        uint256 totalBorrowsNew;
        uint256 actualRepayAmount;
    }
    struct SeizeInternalLocalVars {
        MathError mathErr;
        uint256 borrowerTokensNew;
        uint256 liquidatorTokensNew;
        uint256 liquidatorSeizeTokens;
        uint256 protocolSeizeTokens;
        uint256 protocolSeizeAmount;
        uint256 exchangeRateMantissa;
        uint256 totalReservesNew;
        uint256 totalSupplyNew;
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
}

interface IPriceOracle {
    function isPriceOracle() external returns (bool);
    function getUnderlyingPrice(address) external view returns (uint256);
}

interface IUnitroller {
    enum Error { NO_ERROR, UNAUTHORIZED, COMPTROLLER_MISMATCH, INSUFFICIENT_SHORTFALL, INSUFFICIENT_LIQUIDITY, INVALID_CLOSE_FACTOR, INVALID_COLLATERAL_FACTOR, INVALID_LIQUIDATION_INCENTIVE, MARKET_NOT_ENTERED, MARKET_NOT_LISTED, MARKET_ALREADY_LISTED, MATH_ERROR, NONZERO_BORROW_BALANCE, PRICE_ERROR, REJECTION, SNAPSHOT_ERROR, TOO_MANY_ASSETS, TOO_MUCH_REPAY }
    enum FailureInfo { ACCEPT_ADMIN_PENDING_ADMIN_CHECK, ACCEPT_PENDING_IMPLEMENTATION_ADDRESS_CHECK, EXIT_MARKET_BALANCE_OWED, EXIT_MARKET_REJECTION, SET_CLOSE_FACTOR_OWNER_CHECK, SET_CLOSE_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_OWNER_CHECK, SET_COLLATERAL_FACTOR_NO_EXISTS, SET_COLLATERAL_FACTOR_VALIDATION, SET_COLLATERAL_FACTOR_WITHOUT_PRICE, SET_IMPLEMENTATION_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_OWNER_CHECK, SET_LIQUIDATION_INCENTIVE_VALIDATION, SET_MAX_ASSETS_OWNER_CHECK, SET_PENDING_ADMIN_OWNER_CHECK, SET_PENDING_IMPLEMENTATION_OWNER_CHECK, SET_PRICE_ORACLE_OWNER_CHECK, SUPPORT_MARKET_EXISTS, SUPPORT_MARKET_OWNER_CHECK, ZUNUSED }
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
    event ResultsDiffer(string func, bytes result1, bytes result2);
    event ResultsDiffer(string func, uint result1, uint result2);
    event CreatedFork(uint forkId, uint block);
    event SwitchedFork(uint forkId, uint block);

    IHevm hevm = IHevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    // TODO: Deploy the contracts and put their addresses below
    IComptrollerV1 comptrollerV1;
    IComptrollerV2 comptrollerV2;
    IUnitroller unitroller;
    ICEther cEther;
    ICErc20 cErc20;
    IComp comp;
    ICToken cToken;
    IPriceOracle priceOracle;
    uint256 fork1;
    uint256 fork2;

    constructor() public {
        hevm.roll(13322796);
        fork1 = hevm.createFork();
        emit CreatedFork(fork1, block.number);
        hevm.roll(13322796);
        fork2 = hevm.createFork();
        emit CreatedFork(fork2, block.number);
        // Temporary solution to buggy return value
        fork1 = 1;
        fork2 = 2;
        comptrollerV1 = IComptrollerV1(0x75442Ac771a7243433e033F3F8EaB2631e22938f);
        comptrollerV2 = IComptrollerV2(0x374ABb8cE19A73f2c4EFAd642bda76c797f19233);
        unitroller = IUnitroller(0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B);
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
        cEther = ICEther(0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5);
        cErc20 = ICErc20(0x4B0181102A0112A2ef11AbEE5563bb4a3176c9d7);
        comp = IComp(0xc00e94Cb662C3520282E6f5717214004A7f26888);
        // TODO: Fill in target address below (address not found automatically)
        cToken = ICToken(0x6C8c6b02E7b2BE14d4fA6022Dfd6d75921D90E4E);
        // TODO: Fill in target address below (address not found automatically)
        priceOracle = IPriceOracle(IComptrollerV1(0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B).oracle());
    }

    /*** Upgrade Function ***/ 
    
    // TODO: Consider replacing this with the actual upgrade method
    // function upgradeV2() external virtual {
    //     hevm.store(
    //         address(unitroller),
    //         bytes32(uint(2)),
    //         bytes32(uint256(uint160(address(comptrollerV2))))
    //     );
    // }

    function upgradeV2() external virtual {
        hevm.selectFork(fork2);
        address admin = unitroller.admin();
        hevm.prank(admin);
        unitroller._setPendingImplementation(address(comptrollerV2));
        hevm.prank(admin);
        comptrollerV2._become(address(unitroller));
    }


    /*** Modified Functions ***/ 

    // function Comptroller__supportMarket(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2._supportMarket.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1._supportMarket.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller__become(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2._become.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1._become.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }


    /*** Tainted Functions ***/ 

    // function Comptroller_checkMembership(address a, address b) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.checkMembership.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.checkMembership.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_enterMarkets(address[] memory a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.enterMarkets.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.enterMarkets.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_exitMarket(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.exitMarket.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.exitMarket.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_mintAllowed(address a, address b, uint256 c) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.mintAllowed.selector, a, b, c
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.mintAllowed.selector, a, b, c
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_redeemAllowed(address a, address b, uint256 c) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.redeemAllowed.selector, a, b, c
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.redeemAllowed.selector, a, b, c
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_borrowAllowed(address a, address b, uint256 c) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.borrowAllowed.selector, a, b, c
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.borrowAllowed.selector, a, b, c
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_repayBorrowAllowed(address a, address b, address c, uint256 d) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.repayBorrowAllowed.selector, a, b, c, d
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.repayBorrowAllowed.selector, a, b, c, d
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_liquidateBorrowAllowed(address a, address b, address c, address d, uint256 e) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.liquidateBorrowAllowed.selector, a, b, c, d, e
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.liquidateBorrowAllowed.selector, a, b, c, d, e
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_seizeAllowed(address a, address b, address c, address d, uint256 e) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.seizeAllowed.selector, a, b, c, d, e
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.seizeAllowed.selector, a, b, c, d, e
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_transferAllowed(address a, address b, address c, uint256 d) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.transferAllowed.selector, a, b, c, d
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.transferAllowed.selector, a, b, c, d
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_getAccountLiquidity(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.getAccountLiquidity.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.getAccountLiquidity.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_getHypotheticalAccountLiquidity(address a, address b, uint256 c, uint256 d) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.getHypotheticalAccountLiquidity.selector, a, b, c, d
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.getHypotheticalAccountLiquidity.selector, a, b, c, d
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller__setCollateralFactor(address a, uint256 b) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2._setCollateralFactor.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1._setCollateralFactor.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller__setMintPaused(address a, bool b) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2._setMintPaused.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1._setMintPaused.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller__setBorrowPaused(address a, bool b) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2._setBorrowPaused.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1._setBorrowPaused.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_updateContributorRewards(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.updateContributorRewards.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.updateContributorRewards.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    function Comptroller_claimComp(address a) public virtual {
        hevm.selectFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitroller).call(
            abi.encodeWithSelector(
                comptrollerV2.claimComp.selector, a
            )
        );
        hevm.selectFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitroller).call(
            abi.encodeWithSelector(
                comptrollerV1.claimComp.selector, a
            )
        );
        assert(successV1 == successV2); 
        assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    }

    // function Comptroller_claimComp(address a, address[] memory b) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.claimComp.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.claimComp.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_claimComp(address[] memory a, address[] memory b, bool c, bool d) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.claimComp.selector, a, b, c, d
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.claimComp.selector, a, b, c, d
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller__setContributorCompSpeed(address a, uint256 b) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2._setContributorCompSpeed.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1._setContributorCompSpeed.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_getAllMarkets() public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.getAllMarkets.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.getAllMarkets.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comptroller_isDeprecated(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2.isDeprecated.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1.isDeprecated.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }


    /*** New Functions ***/ 

    // TODO: Double-check this function for correctness
    // Comptroller._setCompSpeeds(CToken[],uint256[],uint256[])
    // is a new function, which appears to replace a function with a similar name,
    // Comptroller._setCompSpeed(CToken,uint256).
    // If these functions have different arguments, this function may be incorrect.
    // function Comptroller__setCompSpeeds(address[] memory a, uint256[] memory b, uint256[] memory c) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV2._setCompSpeeds.selector, a, b, c
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             comptrollerV1._setCompSpeed.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }


    /*** Tainted Variables ***/ 

    // function Comptroller_admin() public {
    //     hevm.selectFork(fork1);
    //     address a1 = IComptrollerV1(address(unitroller)).admin();
    //     hevm.selectFork(fork2);
    //     address a2 = IComptrollerV2(address(unitroller)).admin();
    //     assert(a1 == a2);
    // }

    // function Comptroller_comptrollerImplementation() public {
    //     hevm.selectFork(fork1);
    //     address a1 = IComptrollerV1(address(unitroller)).comptrollerImplementation();
    //     hevm.selectFork(fork2);
    //     address a2 = IComptrollerV2(address(unitroller)).comptrollerImplementation();
    //     assert(a1 == a2);
    // }

    // function Comptroller_oracle() public {
    //     hevm.selectFork(fork1);
    //     address a1 = IComptrollerV1(address(unitroller)).oracle();
    //     hevm.selectFork(fork2);
    //     address a2 = IComptrollerV2(address(unitroller)).oracle();
    //     assert(a1 == a2);
    // }

    // function Comptroller_closeFactorMantissa() public {
    //     hevm.selectFork(fork1);
    //     uint256 a1 = IComptrollerV1(address(unitroller)).closeFactorMantissa();
    //     hevm.selectFork(fork2);
    //     uint256 a2 = IComptrollerV2(address(unitroller)).closeFactorMantissa();
    //     assert(a1 == a2);
    // }

    // function Comptroller_accountAssets(address a) public {
    //     hevm.selectFork(fork1);
    //     CToken[] a1 = IComptrollerV1(address(unitroller)).accountAssets(a);
    //     hevm.selectFork(fork2);
    //     CToken[] a2 = IComptrollerV2(address(unitroller)).accountAssets(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_markets(address a) public {
    //     hevm.selectFork(fork1);
    //     ComptrollerV2Storage.Market a1 = IComptrollerV1(address(unitroller)).markets(a);
    //     hevm.selectFork(fork2);
    //     ComptrollerV2Storage.Market a2 = IComptrollerV2(address(unitroller)).markets(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_pauseGuardian() public {
    //     hevm.selectFork(fork1);
    //     address a1 = IComptrollerV1(address(unitroller)).pauseGuardian();
    //     hevm.selectFork(fork2);
    //     address a2 = IComptrollerV2(address(unitroller)).pauseGuardian();
    //     assert(a1 == a2);
    // }

    // function Comptroller_transferGuardianPaused() public {
    //     hevm.selectFork(fork1);
    //     bool a1 = IComptrollerV1(address(unitroller)).transferGuardianPaused();
    //     hevm.selectFork(fork2);
    //     bool a2 = IComptrollerV2(address(unitroller)).transferGuardianPaused();
    //     assert(a1 == a2);
    // }

    // function Comptroller_seizeGuardianPaused() public {
    //     hevm.selectFork(fork1);
    //     bool a1 = IComptrollerV1(address(unitroller)).seizeGuardianPaused();
    //     hevm.selectFork(fork2);
    //     bool a2 = IComptrollerV2(address(unitroller)).seizeGuardianPaused();
    //     assert(a1 == a2);
    // }

    // function Comptroller_mintGuardianPaused(address a) public {
    //     hevm.selectFork(fork1);
    //     bool a1 = IComptrollerV1(address(unitroller)).mintGuardianPaused(a);
    //     hevm.selectFork(fork2);
    //     bool a2 = IComptrollerV2(address(unitroller)).mintGuardianPaused(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_borrowGuardianPaused(address a) public {
    //     hevm.selectFork(fork1);
    //     bool a1 = IComptrollerV1(address(unitroller)).borrowGuardianPaused(a);
    //     hevm.selectFork(fork2);
    //     bool a2 = IComptrollerV2(address(unitroller)).borrowGuardianPaused(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_allMarkets(uint i) public {
    //     hevm.selectFork(fork1);
    //     address a1 = IComptrollerV1(address(unitroller)).allMarkets(i);
    //     hevm.selectFork(fork2);
    //     address a2 = IComptrollerV2(address(unitroller)).allMarkets(i);
    //     assert(a1 == a2);
    // }

    // function Comptroller_compSpeeds(address a) public {
    //     hevm.selectFork(fork1);
    //     uint256 a1 = IComptrollerV1(address(unitroller)).compSpeeds(a);
    //     hevm.selectFork(fork2);
    //     uint256 a2 = IComptrollerV2(address(unitroller)).compSpeeds(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_compSupplyState(address a) public {
    //     hevm.selectFork(fork1);
    //     IComptrollerV1.CompMarketState memory a1 = IComptrollerV1(address(unitroller)).compSupplyState(a);
    //     hevm.selectFork(fork2);
    //     IComptrollerV2.CompMarketState memory a2 = IComptrollerV2(address(unitroller)).compSupplyState(a);
    //     assert(a1.index == a2.index);
    // }

    // function Comptroller_compBorrowState(address a) public {
    //     hevm.selectFork(fork1);
    //     IComptrollerV1.CompMarketState memory a1 = IComptrollerV1(address(unitroller)).compBorrowState(a);
    //     hevm.selectFork(fork2);
    //     IComptrollerV2.CompMarketState memory a2 = IComptrollerV2(address(unitroller)).compBorrowState(a);
    //     assert(a1.index == a2.index);
    // }

    function Comptroller_compSupplierIndex(address a, address b) public {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1, block.number);
        uint256 a1 = IComptrollerV1(address(unitroller)).compSupplierIndex(a, b);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2, block.number);
        uint256 a2 = IComptrollerV2(address(unitroller)).compSupplierIndex(a, b);
        if(a1 != a2) {
            emit ResultsDiffer("compSupplierIndex", a1, a2);
        }
        assert(a1 == a2);
    }

    function Comptroller_compBorrowerIndex(address a, address b) public {
        hevm.selectFork(fork1);
        uint256 a1 = IComptrollerV1(address(unitroller)).compBorrowerIndex(a, b);
        hevm.selectFork(fork2);
        uint256 a2 = IComptrollerV2(address(unitroller)).compBorrowerIndex(a, b);
        assert(a1 == a2);
    }

    // function Comptroller_compAccrued(address a) public {
    //     hevm.selectFork(fork1);
    //     uint256 a1 = IComptrollerV1(address(unitroller)).compAccrued(a);
    //     hevm.selectFork(fork2);
    //     uint256 a2 = IComptrollerV2(address(unitroller)).compAccrued(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_borrowCaps(address a) public {
    //     hevm.selectFork(fork1);
    //     uint256 a1 = IComptrollerV1(address(unitroller)).borrowCaps(a);
    //     hevm.selectFork(fork2);
    //     uint256 a2 = IComptrollerV2(address(unitroller)).borrowCaps(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_compContributorSpeeds(address a) public {
    //     hevm.selectFork(fork1);
    //     uint256 a1 = IComptrollerV1(address(unitroller)).compContributorSpeeds(a);
    //     hevm.selectFork(fork2);
    //     uint256 a2 = IComptrollerV2(address(unitroller)).compContributorSpeeds(a);
    //     assert(a1 == a2);
    // }

    // function Comptroller_lastContributorBlock(address a) public {
    //     hevm.selectFork(fork1);
    //     uint256 a1 = IComptrollerV1(address(unitroller)).lastContributorBlock(a);
    //     hevm.selectFork(fork2);
    //     uint256 a2 = IComptrollerV2(address(unitroller)).lastContributorBlock(a);
    //     assert(a1 == a2);
    // }


    /*** Tainted External Contracts ***/ 

    // function CToken_balanceOf(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.balanceOf.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.balanceOf.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken_borrowBalanceStored(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.borrowBalanceStored.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.borrowBalanceStored.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken_getAccountSnapshot(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.getAccountSnapshot.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.getAccountSnapshot.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken_initialize(address a, address b, uint256 c, string memory d, string memory e, uint8 f) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.initialize.selector, a, b, c, d, e, f
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.initialize.selector, a, b, c, d, e, f
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken_accrueInterest() public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.accrueInterest.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.accrueInterest.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken_totalBorrowsCurrent() public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.totalBorrowsCurrent.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.totalBorrowsCurrent.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken_supplyRatePerBlock() public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.supplyRatePerBlock.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.supplyRatePerBlock.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken_borrowRatePerBlock() public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.borrowRatePerBlock.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken.borrowRatePerBlock.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CToken__setComptroller(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken._setComptroller.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cToken).call(
    //         abi.encodeWithSelector(
    //             cToken._setComptroller.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Unitroller__acceptImplementation() public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._acceptImplementation.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._acceptImplementation.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Unitroller__setPendingImplementation(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._setPendingImplementation.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._setPendingImplementation.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Unitroller__acceptAdmin() public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._acceptAdmin.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._acceptAdmin.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Unitroller__setPendingAdmin(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._setPendingAdmin.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(unitroller).call(
    //         abi.encodeWithSelector(
    //             unitroller._setPendingAdmin.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function PriceOracle_getUnderlyingPrice(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(priceOracle).call(
    //         abi.encodeWithSelector(
    //             priceOracle.getUnderlyingPrice.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(priceOracle).call(
    //         abi.encodeWithSelector(
    //             priceOracle.getUnderlyingPrice.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comp_transfer(address a, uint256 b) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(comp).call(
    //         abi.encodeWithSelector(
    //             comp.transfer.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(comp).call(
    //         abi.encodeWithSelector(
    //             comp.transfer.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    function Comp_balanceOf(address a) public virtual {
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2, block.number);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(comp).call(
            abi.encodeWithSelector(
                comp.balanceOf.selector, a
            )
        );
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1, block.number);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(comp).call(
            abi.encodeWithSelector(
                comp.balanceOf.selector, a
            )
        );
        assert(successV1 == successV2); 
        assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    }

    // function Comp_getPriorVotes(address a, uint256 b) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(comp).call(
    //         abi.encodeWithSelector(
    //             comp.getPriorVotes.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(comp).call(
    //         abi.encodeWithSelector(
    //             comp.getPriorVotes.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function Comp_getCurrentVotes(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     hevm.prank(msg.sender);
    //     (bool successV2, bytes memory outputV2) = address(comp).call(
    //         abi.encodeWithSelector(
    //             comp.getCurrentVotes.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     hevm.prank(msg.sender);
    //     (bool successV1, bytes memory outputV1) = address(comp).call(
    //         abi.encodeWithSelector(
    //             comp.getCurrentVotes.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    function CEther_mint() public virtual {
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2, block.number);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cEther).call(
            abi.encodeWithSelector(
                cEther.mint.selector
            )
        );
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1, block.number);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cEther).call(
            abi.encodeWithSelector(
                cEther.mint.selector
            )
        );
        assert(successV1 == successV2); 
        assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    }

    // function CEther_redeem(uint256 a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.redeem.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.redeem.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CEther_redeemUnderlying(uint256 a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.redeemUnderlying.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.redeemUnderlying.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CEther_borrow(uint256 a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.borrow.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.borrow.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CEther_repayBorrow() public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.repayBorrow.selector
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.repayBorrow.selector
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CEther_repayBorrowBehalf(address a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.repayBorrowBehalf.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.repayBorrowBehalf.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CEther_liquidateBorrow(address a, address b) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.liquidateBorrow.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cEther).call(
    //         abi.encodeWithSelector(
    //             cEther.liquidateBorrow.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    function CErc20_mint(uint256 a) public virtual {
        hevm.selectFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(cErc20).call(
            abi.encodeWithSelector(
                cErc20.mint.selector, a
            )
        );
        hevm.selectFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(cErc20).call(
            abi.encodeWithSelector(
                cErc20.mint.selector, a
            )
        );
        assert(successV1 == successV2); 
        assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    }

    // function CErc20_redeem(uint256 a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.redeem.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.redeem.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CErc20_redeemUnderlying(uint256 a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.redeemUnderlying.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.redeemUnderlying.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CErc20_borrow(uint256 a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.borrow.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.borrow.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CErc20_repayBorrow(uint256 a) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.repayBorrow.selector, a
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.repayBorrow.selector, a
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CErc20_repayBorrowBehalf(address a, uint256 b) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.repayBorrowBehalf.selector, a, b
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.repayBorrowBehalf.selector, a, b
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }

    // function CErc20_liquidateBorrow(address a, uint256 b, address c) public virtual {
    //     hevm.selectFork(fork2);
    //     (bool successV2, bytes memory outputV2) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.liquidateBorrow.selector, a, b, c
    //         )
    //     );
    //     hevm.selectFork(fork1);
    //     (bool successV1, bytes memory outputV1) = address(cErc20).call(
    //         abi.encodeWithSelector(
    //             cErc20.liquidateBorrow.selector, a, b, c
    //         )
    //     );
    //     assert(successV1 == successV2); 
    //     assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    // }


    /*** Additional Targets ***/ 

    function HEVM_prank(address a) external {
        hevm.prank(a);
    }

}
