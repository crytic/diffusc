// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.7.6;

pragma abicoder v2;

interface IExchangeV1 {
    struct SwapParams {
        address trader;
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        bool isClose;
        uint256 amount;
        uint160 sqrtPriceLimitX96;
    }
    struct SwapResponse {
        uint256 base;
        uint256 quote;
        int256 exchangedPositionSize;
        int256 exchangedPositionNotional;
        uint256 fee;
        uint256 insuranceFundFee;
        int256 pnlToBeRealized;
        uint256 sqrtPriceAfterX96;
        int24 tick;
        bool isPartialClose;
    }
    struct SwapCallbackData {
        address trader;
        address baseToken;
        address pool;
        uint24 uniswapFeeRatio;
        uint256 fee;
    }
    struct RealizePnlParams {
        address trader;
        address baseToken;
        int256 base;
        int256 quote;
    }
    struct InternalReplaySwapParams {
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        uint256 amount;
        uint160 sqrtPriceLimitX96;
        address trader;
    }
    struct InternalSwapResponse {
        int256 base;
        int256 quote;
        int256 exchangedPositionSize;
        int256 exchangedPositionNotional;
        uint256 fee;
        uint256 insuranceFundFee;
        int24 tick;
    }
    struct InternalRealizePnlParams {
        address trader;
        address baseToken;
        int256 takerPositionSize;
        int256 takerOpenNotional;
        int256 base;
        int256 quote;
    }
    struct Growth {
        int256 twPremiumX96;
        int256 twPremiumDivBySqrtPriceX96;
    }
    function getMarketRegistry() external view returns (address);
    function setClearingHouse(address) external;
    function getClearingHouse() external view returns (address);
    function renounceOwnership() external;
    function setOwner(address) external;
    function updateOwner() external;
    function owner() external view returns (address);
    function candidate() external view returns (address);
    function initialize(address,address,address) external;
    function setAccountBalance(address) external;
    function setMaxTickCrossedWithinBlock(address,uint24) external;
    function uniswapV3SwapCallback(int256,int256,bytes calldata) external;
    function swap(SwapParams memory) external returns (SwapResponse memory);
    function settleFunding(address,address) external returns (int256,Growth memory);
    function getOrderBook() external view returns (address);
    function getAccountBalance() external view returns (address);
    function getClearingHouseConfig() external view returns (address);
    function getMaxTickCrossedWithinBlock(address) external view returns (uint24);
    function getPnlToBeRealized(RealizePnlParams memory) external view returns (int256);
    function getAllPendingFundingPayment(address) external view returns (int256);
    function isOverPriceSpread(address) external view returns (bool);
    function getSqrtMarkTwapX96(address,uint32) external view returns (uint160);
    function getSqrtMarketTwapX96(address,uint32) external view returns (uint160);
    function getPendingFundingPayment(address,address) external view returns (int256);
}

interface IExchangeV2 {
    struct SwapParams {
        address trader;
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        bool isClose;
        uint256 amount;
        uint160 sqrtPriceLimitX96;
    }
    struct SwapResponse {
        uint256 base;
        uint256 quote;
        int256 exchangedPositionSize;
        int256 exchangedPositionNotional;
        uint256 fee;
        uint256 insuranceFundFee;
        int256 pnlToBeRealized;
        uint256 sqrtPriceAfterX96;
        int24 tick;
        bool isPartialClose;
        uint24 closedRatio;
    }
    struct SwapCallbackData {
        address trader;
        address baseToken;
        address pool;
        uint24 uniswapFeeRatio;
        uint256 fee;
    }
    struct RealizePnlParams {
        address trader;
        address baseToken;
        int256 base;
        int256 quote;
    }
    struct InternalSwapResponse {
        int256 base;
        int256 quote;
        int256 exchangedPositionSize;
        int256 exchangedPositionNotional;
        uint256 fee;
        uint256 insuranceFundFee;
        int24 tick;
    }
    struct InternalRealizePnlParams {
        address trader;
        address baseToken;
        int256 takerPositionSize;
        int256 takerOpenNotional;
        int256 base;
        int256 quote;
    }
    struct Growth {
        int256 twPremiumX96;
        int256 twPremiumDivBySqrtPriceX96;
    }
    function getMarketRegistry() external view returns (address);
    function setClearingHouse(address) external;
    function getClearingHouse() external view returns (address);
    function renounceOwnership() external;
    function setOwner(address) external;
    function updateOwner() external;
    function owner() external view returns (address);
    function candidate() external view returns (address);
    function initialize(address,address,address) external;
    function setAccountBalance(address) external;
    function setMaxTickCrossedWithinBlock(address,uint24) external;
    function uniswapV3SwapCallback(int256,int256,bytes calldata) external;
    function swap(SwapParams memory) external returns (SwapResponse memory);
    function settleFunding(address,address) external returns (int256,Growth memory);
    function getOrderBook() external view returns (address);
    function getAccountBalance() external view returns (address);
    function getClearingHouseConfig() external view returns (address);
    function getMaxTickCrossedWithinBlock(address) external view returns (uint24);
    function getPnlToBeRealized(RealizePnlParams memory) external view returns (int256);
    function getAllPendingFundingPayment(address) external view returns (int256);
    function isOverPriceSpread(address) external view returns (bool);
    function getSqrtMarkTwapX96(address,uint32) external view returns (uint160);
    function getSqrtMarketTwapX96(address,uint32) external view returns (uint160);
    function getPendingFundingPayment(address,address) external view returns (int256);
}

interface IAccountBalance {
    struct Info {
        int256 takerPositionSize;
        int256 takerOpenNotional;
        int256 lastTwPremiumGrowthGlobalX96;
    }
    function setClearingHouse(address) external;
    function getClearingHouse() external view returns (address);
    function renounceOwnership() external;
    function setOwner(address) external;
    function updateOwner() external;
    function owner() external view returns (address);
    function candidate() external view returns (address);
    function initialize(address,address) external;
    function setVault(address) external;
    function modifyTakerBalance(address,address,int256,int256) external returns (int256,int256);
    function modifyOwedRealizedPnl(address,int256) external;
    function settleQuoteToOwedRealizedPnl(address,address,int256) external;
    function settleOwedRealizedPnl(address) external returns (int256);
    function settleBalanceAndDeregister(address,address,int256,int256,int256,int256) external;
    function registerBaseToken(address,address) external;
    function deregisterBaseToken(address,address) external;
    function updateTwPremiumGrowthGlobal(address,address,int256) external;
    function settlePositionInClosedMarket(address,address) external returns (int256,int256,int256,uint256);
    function getClearingHouseConfig() external view returns (address);
    function getOrderBook() external view returns (address);
    function getVault() external view returns (address);
    function getBaseTokens(address) external view returns (address[] memory);
    function getAccountInfo(address,address) external view returns (Info memory);
    function getTakerOpenNotional(address,address) external view returns (int256);
    function getTotalOpenNotional(address,address) external view returns (int256);
    function getTotalDebtValue(address) external view returns (uint256);
    function getPnlAndPendingFee(address) external view returns (int256,int256,uint256);
    function hasOrder(address) external view returns (bool);
    function getLiquidatablePositionSize(address,address,int256) external view returns (int256);
    function getMarkPrice(address) external view returns (uint256);
    function getBase(address,address) external view returns (int256);
    function getQuote(address,address) external view returns (int256);
    function getTakerPositionSize(address,address) external view returns (int256);
    function getTotalPositionSize(address,address) external view returns (int256);
    function getTotalPositionValue(address,address) external view returns (int256);
    function getTotalAbsPositionValue(address) external view returns (uint256);
    function getMarginRequirementForLiquidation(address) external view returns (int256);
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

interface IClearingHouse {
    struct AddLiquidityParams {
        address baseToken;
        uint256 base;
        uint256 quote;
        int24 lowerTick;
        int24 upperTick;
        uint256 minBase;
        uint256 minQuote;
        bool useTakerBalance;
        uint256 deadline;
    }
    struct RemoveLiquidityParams {
        address baseToken;
        int24 lowerTick;
        int24 upperTick;
        uint128 liquidity;
        uint256 minBase;
        uint256 minQuote;
        uint256 deadline;
    }
    struct AddLiquidityResponse {
        uint256 base;
        uint256 quote;
        uint256 fee;
        uint256 liquidity;
    }
    struct RemoveLiquidityResponse {
        uint256 base;
        uint256 quote;
        uint256 fee;
    }
    struct OpenPositionParams {
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        uint256 amount;
        uint256 oppositeAmountBound;
        uint256 deadline;
        uint160 sqrtPriceLimitX96;
        bytes32 referralCode;
    }
    struct ClosePositionParams {
        address baseToken;
        uint160 sqrtPriceLimitX96;
        uint256 oppositeAmountBound;
        uint256 deadline;
        bytes32 referralCode;
    }
    struct CollectPendingFeeParams {
        address trader;
        address baseToken;
        int24 lowerTick;
        int24 upperTick;
    }
    struct InternalOpenPositionParams {
        address trader;
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        bool isClose;
        uint256 amount;
        uint160 sqrtPriceLimitX96;
    }
    struct InternalCheckSlippageParams {
        bool isBaseToQuote;
        bool isExactInput;
        uint256 base;
        uint256 quote;
        uint256 oppositeAmountBound;
    }
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
    function initialize(address,address,address,address,address,address,address) external;
    function setDelegateApproval(address) external;
    function addLiquidity(AddLiquidityParams memory) external returns (AddLiquidityResponse memory);
    function removeLiquidity(RemoveLiquidityParams memory) external returns (RemoveLiquidityResponse memory);
    function settleAllFunding(address) external;
    function openPosition(OpenPositionParams memory) external returns (uint256,uint256);
    function openPositionFor(address,OpenPositionParams memory) external returns (uint256,uint256,uint256);
    function closePosition(ClosePositionParams memory) external returns (uint256,uint256);
    function liquidate(address,address,int256) external;
    function liquidate(address,address) external;
    function cancelExcessOrders(address,address,bytes32[] calldata) external;
    function cancelAllExcessOrders(address,address) external;
    function quitMarket(address,address) external returns (uint256,uint256);
    function uniswapV3MintCallback(uint256,uint256,bytes calldata) external;
    function uniswapV3SwapCallback(int256,int256,bytes calldata) external;
    function getQuoteToken() external view returns (address);
    function getUniswapV3Factory() external view returns (address);
    function getClearingHouseConfig() external view returns (address);
    function getVault() external view returns (address);
    function getExchange() external view returns (address);
    function getOrderBook() external view returns (address);
    function getAccountBalance() external view returns (address);
    function getInsuranceFund() external view returns (address);
    function getDelegateApproval() external view returns (address);
    function getAccountValue(address) external view returns (int256);
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

interface IUniswapV3Pool {
    struct Slot0 {
        uint160 sqrtPriceX96;
        int24 tick;
        uint16 observationIndex;
        uint16 observationCardinality;
        uint16 observationCardinalityNext;
        uint8 feeProtocol;
        bool unlocked;
    }
    struct ProtocolFees {
        uint128 token0;
        uint128 token1;
    }
    struct ModifyPositionParams {
        address owner;
        int24 tickLower;
        int24 tickUpper;
        int128 liquidityDelta;
    }
    struct SwapCache {
        uint8 feeProtocol;
        uint128 liquidityStart;
        uint32 blockTimestamp;
        int56 tickCumulative;
        uint160 secondsPerLiquidityCumulativeX128;
        bool computedLatestObservation;
    }
    struct SwapState {
        int256 amountSpecifiedRemaining;
        int256 amountCalculated;
        uint160 sqrtPriceX96;
        int24 tick;
        uint256 feeGrowthGlobalX128;
        uint128 protocolFee;
        uint128 liquidity;
    }
    struct StepComputations {
        uint160 sqrtPriceStartX96;
        int24 tickNext;
        bool initialized;
        uint160 sqrtPriceNextX96;
        uint256 amountIn;
        uint256 amountOut;
        uint256 feeAmount;
    }
    struct Info {
        uint128 liquidity;
        uint256 feeGrowthInside0LastX128;
        uint256 feeGrowthInside1LastX128;
        uint128 tokensOwed0;
        uint128 tokensOwed1;
    }
    function factory() external returns (address);
    function token0() external returns (address);
    function token1() external returns (address);
    function fee() external returns (uint24);
    function tickSpacing() external returns (int24);
    function maxLiquidityPerTick() external returns (uint128);
    function slot0() external returns (Slot0 memory);
    function feeGrowthGlobal0X128() external returns (uint256);
    function feeGrowthGlobal1X128() external returns (uint256);
    function protocolFees() external returns (ProtocolFees memory);
    function liquidity() external returns (uint128);
    function ticks(int24) external returns (Info memory);
    function tickBitmap(int16) external returns (uint256);
    function positions(bytes32) external returns (Info memory);
//    function observations(uint256) external returns (Observation memory);
    function snapshotCumulativesInside(int24,int24) external view returns (int56,uint160,uint32);
    function observe(uint32[] calldata) external view returns (int56[] memory,uint160[] memory);
    function increaseObservationCardinalityNext(uint16) external;
    function initialize(uint160) external;
    function mint(address,int24,int24,uint128,bytes calldata) external returns (uint256,uint256);
    function collect(address,int24,int24,uint128,uint128) external returns (uint128,uint128);
    function burn(int24,int24,uint128) external returns (uint256,uint256);
    function swap(address,bool,int256,uint160,bytes calldata) external returns (int256,int256);
    function flash(address,uint256,uint256,bytes calldata) external;
    function setFeeProtocol(uint8,uint8) external;
    function collectProtocol(address,uint128,uint128) external returns (uint128,uint128);
}

interface IVault {
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

interface IIAccountBalance {
    struct Info {
        int256 takerPositionSize;
        int256 takerOpenNotional;
        int256 lastTwPremiumGrowthGlobalX96;
    }
}

interface IIBaseToken {
    enum Status { Open, Paused, Closed }
}

interface IIClearingHouseConfig {
}

interface IIIndexPrice {
}

interface IIMarketRegistry {
    struct MarketInfo {
        address pool;
        uint24 exchangeFeeRatio;
        uint24 uniswapFeeRatio;
        uint24 insuranceFundFeeRatio;
        uint24 maxPriceSpreadRatio;
    }
}

interface IIOrderBook {
    struct AddLiquidityParams {
        address trader;
        address baseToken;
        uint256 base;
        uint256 quote;
        int24 lowerTick;
        int24 upperTick;
        Growth fundingGrowthGlobal;
    }
    struct RemoveLiquidityParams {
        address maker;
        address baseToken;
        int24 lowerTick;
        int24 upperTick;
        uint128 liquidity;
    }
    struct AddLiquidityResponse {
        uint256 base;
        uint256 quote;
        uint256 fee;
        uint128 liquidity;
    }
    struct RemoveLiquidityResponse {
        uint256 base;
        uint256 quote;
        uint256 fee;
        int256 takerBase;
        int256 takerQuote;
    }
    struct ReplaySwapParams {
        address baseToken;
        bool isBaseToQuote;
        bool shouldUpdateState;
        int256 amount;
        uint160 sqrtPriceLimitX96;
        uint24 exchangeFeeRatio;
        uint24 uniswapFeeRatio;
        Growth globalFundingGrowth;
        address pool;
        uint24 insuranceFundFeeRatio;
    }
    struct ReplaySwapResponse {
        int24 tick;
        uint256 fee;
        uint256 insuranceFundFee;
    }
    struct MintCallbackData {
        address trader;
        address pool;
    }
    struct Growth {
        int256 twPremiumX96;
        int256 twPremiumDivBySqrtPriceX96;
    }
    struct Info {
        uint128 liquidity;
        int24 lowerTick;
        int24 upperTick;
        uint256 lastFeeGrowthInsideX128;
        int256 lastTwPremiumGrowthInsideX96;
        int256 lastTwPremiumGrowthBelowX96;
        int256 lastTwPremiumDivBySqrtPriceGrowthInsideX96;
        uint256 baseDebt;
        uint256 quoteDebt;
    }
}

interface IIUniswapV3Pool {
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

    IExchangeV1 exchangeV1;
    IExchangeV2 exchangeV2;
    ITransparentUpgradeableProxy transparentUpgradeableProxy;
    IAccountBalance accountBalance;
    IBaseToken baseToken;
    IClearingHouse clearingHouse;
    IQuoteToken quoteToken;
    IUniswapV3Pool uniswapV3Pool;
    IVault vault;
    IIAccountBalance iAccountBalance;
    IIBaseToken iBaseToken;
    IIClearingHouseConfig iClearingHouseConfig;
    IIIndexPrice iIndexPrice;
    IIMarketRegistry iMarketRegistry;
    IIOrderBook iOrderBook;
    IIUniswapV3Pool iUniswapV3Pool;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

    struct SwapParams {
        address trader;
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        bool isClose;
        uint256 amount;
        uint160 sqrtPriceLimitX96;
    }
    struct SwapResponse {
        uint256 base;
        uint256 quote;
        int256 exchangedPositionSize;
        int256 exchangedPositionNotional;
        uint256 fee;
        uint256 insuranceFundFee;
        int256 pnlToBeRealized;
        uint256 sqrtPriceAfterX96;
        int24 tick;
        bool isPartialClose;
        uint24 closedRatio;
    }
    struct SwapCallbackData {
        address trader;
        address baseToken;
        address pool;
        uint24 uniswapFeeRatio;
        uint256 fee;
    }
    struct RealizePnlParams {
        address trader;
        address baseToken;
        int256 base;
        int256 quote;
    }
    struct InternalSwapResponse {
        int256 base;
        int256 quote;
        int256 exchangedPositionSize;
        int256 exchangedPositionNotional;
        uint256 fee;
        uint256 insuranceFundFee;
        int24 tick;
    }
    struct InternalRealizePnlParams {
        address trader;
        address baseToken;
        int256 takerPositionSize;
        int256 takerOpenNotional;
        int256 base;
        int256 quote;
    }
    struct AddLiquidityParams {
        address baseToken;
        uint256 base;
        uint256 quote;
        int24 lowerTick;
        int24 upperTick;
        uint256 minBase;
        uint256 minQuote;
        bool useTakerBalance;
        uint256 deadline;
    }
    struct RemoveLiquidityParams {
        address baseToken;
        int24 lowerTick;
        int24 upperTick;
        uint128 liquidity;
        uint256 minBase;
        uint256 minQuote;
        uint256 deadline;
    }
    struct AddLiquidityResponse {
        uint256 base;
        uint256 quote;
        uint256 fee;
        uint256 liquidity;
    }
    struct RemoveLiquidityResponse {
        uint256 base;
        uint256 quote;
        uint256 fee;
    }
    struct OpenPositionParams {
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        uint256 amount;
        uint256 oppositeAmountBound;
        uint256 deadline;
        uint160 sqrtPriceLimitX96;
        bytes32 referralCode;
    }
    struct ClosePositionParams {
        address baseToken;
        uint160 sqrtPriceLimitX96;
        uint256 oppositeAmountBound;
        uint256 deadline;
        bytes32 referralCode;
    }
    struct CollectPendingFeeParams {
        address trader;
        address baseToken;
        int24 lowerTick;
        int24 upperTick;
    }
    struct InternalOpenPositionParams {
        address trader;
        address baseToken;
        bool isBaseToQuote;
        bool isExactInput;
        bool isClose;
        uint256 amount;
        uint160 sqrtPriceLimitX96;
    }
    struct InternalCheckSlippageParams {
        bool isBaseToQuote;
        bool isExactInput;
        uint256 base;
        uint256 quote;
        uint256 oppositeAmountBound;
    }
    struct Slot0 {
        uint160 sqrtPriceX96;
        int24 tick;
        uint16 observationIndex;
        uint16 observationCardinality;
        uint16 observationCardinalityNext;
        uint8 feeProtocol;
        bool unlocked;
    }
    struct ProtocolFees {
        uint128 token0;
        uint128 token1;
    }
    struct ModifyPositionParams {
        address owner;
        int24 tickLower;
        int24 tickUpper;
        int128 liquidityDelta;
    }
    struct SwapCache {
        uint8 feeProtocol;
        uint128 liquidityStart;
        uint32 blockTimestamp;
        int56 tickCumulative;
        uint160 secondsPerLiquidityCumulativeX128;
        bool computedLatestObservation;
    }
    struct SwapState {
        int256 amountSpecifiedRemaining;
        int256 amountCalculated;
        uint160 sqrtPriceX96;
        int24 tick;
        uint256 feeGrowthGlobalX128;
        uint128 protocolFee;
        uint128 liquidity;
    }
    struct StepComputations {
        uint160 sqrtPriceStartX96;
        int24 tickNext;
        bool initialized;
        uint160 sqrtPriceNextX96;
        uint256 amountIn;
        uint256 amountOut;
        uint256 feeAmount;
    }
    struct MarketInfo {
        address pool;
        uint24 exchangeFeeRatio;
        uint24 uniswapFeeRatio;
        uint24 insuranceFundFeeRatio;
        uint24 maxPriceSpreadRatio;
    }
    struct ReplaySwapParams {
        address baseToken;
        bool isBaseToQuote;
        bool shouldUpdateState;
        int256 amount;
        uint160 sqrtPriceLimitX96;
        uint24 exchangeFeeRatio;
        uint24 uniswapFeeRatio;
        Growth globalFundingGrowth;
        address pool;
        uint24 insuranceFundFeeRatio;
    }
    struct ReplaySwapResponse {
        int24 tick;
        uint256 fee;
        uint256 insuranceFundFee;
    }
    struct MintCallbackData {
        address trader;
        address pool;
    }
    struct Growth {
        int256 twPremiumX96;
        int256 twPremiumDivBySqrtPriceX96;
    }

    constructor() public {
        hevm.roll(105828093);
        hevm.warp(1687254963);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        exchangeV1 = IExchangeV1(0x81d4BDb63E59339375A1376a3Bd0d99c22FC0126);
        exchangeV2 = IExchangeV2(0xF482304D9D9fC5629E45f4077A3a2DbCEda15890);
        transparentUpgradeableProxy = ITransparentUpgradeableProxy(0xBd7a3B7DbEb096F0B832Cf467B94b091f30C34ec);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(exchangeV1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(exchangeV2))))
        );
        accountBalance = IAccountBalance(0xA7f3FC32043757039d5e13d790EE43edBcBa8b7c);
        baseToken = IBaseToken(0x86f1e0420c26a858fc203A3645dD1A36868F18e5);
        clearingHouse = IClearingHouse(0x82ac2CE43e33683c58BE4cDc40975E73aA50f459);
        quoteToken = IQuoteToken(0xC84Da6c8ec7A57cD10B939E79eaF9d2D17834E04);
        uniswapV3Pool = IUniswapV3Pool(0xC64f9436f8Ca50CDCC096105C62DaD52FAEb1f2e);
        vault = IVault(0xAD7b4C162707E0B2b5f6fdDbD3f8538A5fbA0d60);
        // TODO: Fill in target address below (address not found automatically)
        iAccountBalance = IIAccountBalance(0xA7f3FC32043757039d5e13d790EE43edBcBa8b7c);
        // TODO: Fill in target address below (address not found automatically)
        iBaseToken = IIBaseToken(0x86f1e0420c26a858fc203A3645dD1A36868F18e5);
        // TODO: Fill in target address below (address not found automatically)
        iClearingHouseConfig = IIClearingHouseConfig(0xA4c817a425D3443BAf610CA614c8B11688a288Fb);
        // TODO: Fill in target address below (address not found automatically)
        iIndexPrice = IIIndexPrice(0x86f1e0420c26a858fc203A3645dD1A36868F18e5);
        // TODO: Fill in target address below (address not found automatically)
        iMarketRegistry = IIMarketRegistry(0xd5820eE0F55205f6cdE8BB0647072143b3060067);
        // TODO: Fill in target address below (address not found automatically)
        iOrderBook = IIOrderBook(0xDfcaEBe8f6ea5E022BeFAFaE8c6Cdae8D4E1094b);
        // TODO: Fill in target address below (address not found automatically)
        iUniswapV3Pool = IIUniswapV3Pool(0xC64f9436f8Ca50CDCC096105C62DaD52FAEb1f2e);
    }


    /*** Modified Functions ***/ 

    function Exchange_swap(SwapParams memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'swap(IExchange.SwapParams)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'swap(IExchange.SwapParams)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function Exchange_settleFunding(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'settleFunding(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'settleFunding(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Exchange_getAllPendingFundingPayment(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getAllPendingFundingPayment(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getAllPendingFundingPayment(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Exchange_getPendingFundingPayment(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getPendingFundingPayment(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getPendingFundingPayment(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 


    /*** Tainted Variables ***/ 


    /*** Tainted External Contracts ***/ 

    function IAccountBalance_getAccountInfo(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getAccountInfo(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getAccountInfo(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IAccountBalance_getBase(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getBase(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getBase(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IAccountBalance_getBaseTokens(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getBaseTokens(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getBaseTokens(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IAccountBalance_getTakerOpenNotional(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getTakerOpenNotional(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getTakerOpenNotional(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IAccountBalance_getTakerPositionSize(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getTakerPositionSize(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iAccountBalance).call(
            abi.encodeWithSignature(
                'getTakerPositionSize(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IBaseToken_cacheTwap(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'cacheTwap(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'cacheTwap(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IBaseToken_getPausedIndexPrice() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'getPausedIndexPrice()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'getPausedIndexPrice()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IBaseToken_getPausedTimestamp() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'getPausedTimestamp()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'getPausedTimestamp()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IBaseToken_isOpen() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'isOpen()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iBaseToken).call(
            abi.encodeWithSignature(
                'isOpen()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IClearingHouseConfig_getMarkPriceConfig() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iClearingHouseConfig).call(
            abi.encodeWithSignature(
                'getMarkPriceConfig()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iClearingHouseConfig).call(
            abi.encodeWithSignature(
                'getMarkPriceConfig()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IClearingHouseConfig_getMaxFundingRate() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iClearingHouseConfig).call(
            abi.encodeWithSignature(
                'getMaxFundingRate()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iClearingHouseConfig).call(
            abi.encodeWithSignature(
                'getMaxFundingRate()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IClearingHouseConfig_getTwapInterval() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iClearingHouseConfig).call(
            abi.encodeWithSignature(
                'getTwapInterval()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iClearingHouseConfig).call(
            abi.encodeWithSignature(
                'getTwapInterval()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IIndexPrice_getIndexPrice(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iIndexPrice).call(
            abi.encodeWithSignature(
                'getIndexPrice(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iIndexPrice).call(
            abi.encodeWithSignature(
                'getIndexPrice(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IMarketRegistry_getMarketInfoByTrader(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iMarketRegistry).call(
            abi.encodeWithSignature(
                'getMarketInfoByTrader(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iMarketRegistry).call(
            abi.encodeWithSignature(
                'getMarketInfoByTrader(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IMarketRegistry_getPool(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iMarketRegistry).call(
            abi.encodeWithSignature(
                'getPool(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iMarketRegistry).call(
            abi.encodeWithSignature(
                'getPool(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IMarketRegistry_hasPool(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iMarketRegistry).call(
            abi.encodeWithSignature(
                'hasPool(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iMarketRegistry).call(
            abi.encodeWithSignature(
                'hasPool(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IOrderBook_getLiquidityCoefficientInFundingPayment(address a, address b, Growth memory c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iOrderBook).call(
            abi.encodeWithSignature(
                'getLiquidityCoefficientInFundingPayment(address,address,Funding.Growth)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iOrderBook).call(
            abi.encodeWithSignature(
                'getLiquidityCoefficientInFundingPayment(address,address,Funding.Growth)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IOrderBook_replaySwap(ReplaySwapParams memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iOrderBook).call(
            abi.encodeWithSignature(
                'replaySwap(IOrderBook.ReplaySwapParams)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iOrderBook).call(
            abi.encodeWithSignature(
                'replaySwap(IOrderBook.ReplaySwapParams)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IOrderBook_updateFundingGrowthAndLiquidityCoefficientInFundingPayment(address a, address b, Growth memory c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iOrderBook).call(
            abi.encodeWithSignature(
                'updateFundingGrowthAndLiquidityCoefficientInFundingPayment(address,address,Funding.Growth)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iOrderBook).call(
            abi.encodeWithSignature(
                'updateFundingGrowthAndLiquidityCoefficientInFundingPayment(address,address,Funding.Growth)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IUniswapV3Pool_swap(address a, bool b, int256 c, uint160 d, bytes calldata e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iUniswapV3Pool).call(
            abi.encodeWithSignature(
                'swap(address,bool,int256,uint160,bytes)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iUniswapV3Pool).call(
            abi.encodeWithSignature(
                'swap(address,bool,int256,uint160,bytes)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IUniswapV3Pool_observe(uint32[] calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iUniswapV3Pool).call(
            abi.encodeWithSignature(
                'observe(uint32[])', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iUniswapV3Pool).call(
            abi.encodeWithSignature(
                'observe(uint32[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function IUniswapV3Pool_slot0() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(iUniswapV3Pool).call(
            abi.encodeWithSignature(
                'slot0()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(iUniswapV3Pool).call(
            abi.encodeWithSignature(
                'slot0()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Additional Targets ***/ 

    function AccountBalance_getAccountInfo(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getAccountInfo(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getAccountInfo(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AccountBalance_getBase(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getBase(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getBase(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AccountBalance_getBaseTokens(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getBaseTokens(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getBaseTokens(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AccountBalance_getTakerOpenNotional(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getTakerOpenNotional(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getTakerOpenNotional(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function AccountBalance_getTakerPositionSize(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getTakerPositionSize(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(accountBalance).call(
            abi.encodeWithSignature(
                'getTakerPositionSize(address,address)', a, b
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

    function UniswapV3Pool_observe(uint32[] calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uniswapV3Pool).call(
            abi.encodeWithSignature(
                'observe(uint32[])', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uniswapV3Pool).call(
            abi.encodeWithSignature(
                'observe(uint32[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UniswapV3Pool_slot0() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uniswapV3Pool).call(
            abi.encodeWithSignature(
                'slot0()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uniswapV3Pool).call(
            abi.encodeWithSignature(
                'slot0()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UniswapV3Pool_swap(address a, bool b, int256 c, uint160 d, bytes calldata e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uniswapV3Pool).call(
            abi.encodeWithSignature(
                'swap(address,bool,int256,uint160,bytes)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uniswapV3Pool).call(
            abi.encodeWithSignature(
                'swap(address,bool,int256,uint160,bytes)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
