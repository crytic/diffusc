// SPDX-License-Identifier: AGPLv3
pragma solidity >=0.8.11;

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
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
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
    function setRouter(address) external;
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
    function setWhitelistBurn(address) external;
    function mint(address,uint256) external;
    function burn(uint256) external;
}

interface ISafemoonV2 {
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
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
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
    function setRouter(address) external;
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
    function setWhitelistMint(address) external;
    function mint(address,uint256) external;
    function burn(address,uint256) external;
}

interface ISafeSwapTradeRouter {
    enum SwapKind { SEND_ONLY, SWAP_AND_SEND, SWAP_AND_BURN }
    enum FeeKind { TOKEN_FEE, PORTAL_FEE }
    enum TransactionType { SELL, BUY }
    struct Trade {
        uint256 amountIn;
        uint256 amountOut;
        address[] path;
        address to;
        uint256 deadline;
    }
    struct TokenFee {
        TokenInfo tokenInfo;
        SingleSwapFee[] singleSwapFees;
    }
    struct TokenInfo {
        uint8 transactionType;
        address tokenAddress;
        uint256 feePercentage;
        bool isEnabled;
        bool isDeleted;
    }
    struct SingleSwapFee {
        uint8 swapKind;
        address assetOut;
        address beneficiary;
        uint256 percentage;
        bool isEnabled;
    }
    function feeJar() external returns (address);
    function swapRouter() external returns (address);
    function admin() external returns (address);
    function percent() external returns (uint256);
    function feePercent() external returns (uint256);
    function whitelistFfsFee(address) external returns (bool);
    function initialize(address,address,uint256,uint256) external;
    function setRouter(address) external;
    function setFeePercent(uint256) external;
    function sePercent(uint256) external;
    function addFfsWhitelist(address) external;
    function removeFfsWhitelist(address) external;
    function setFeeJar(address) external;
    function submitTokenSwapFee(address,TransactionType,SingleSwapFee memory) external;
    function updateTokenSwapFee(address,TransactionType,SingleSwapFee memory,uint256) external;
    function switchTokenDeletion(address,TransactionType) external;
    function switchTokenActivation(address,TransactionType) external;
    function switchSingleSwapActivation(address,TransactionType,uint256) external;
    function getTokenFeeAddresses() external view returns (address[] memory);
    function getTokenInfoDetails(address,TransactionType) external view returns (TokenFee memory);
    function swapExactTokensForETHAndFeeAmount(Trade memory) external payable;
    function swapTokensForExactETHAndFeeAmount(Trade memory) external payable;
    function swapExactETHForTokensWithFeeAmount(Trade memory,uint256) external payable;
    function swapETHForExactTokensWithFeeAmount(Trade memory,uint256) external payable;
    function swapExactTokensForTokensWithFeeAmount(Trade memory) external payable;
    function swapTokensForExactTokensWithFeeAmount(Trade memory) external payable;
    function getPortalSwapFee(uint256,uint256,address,address) external view returns (uint256);
    function getTotalSwapFees(uint256,address[] memory) external view returns (uint256,uint256);
    function getSwapFees(uint256,address[] memory) external view returns (uint256);
    function getTokenSwapFee(uint256,TransactionType,address,bool) external view returns (uint256);
}

interface ISafeswapRouterProxy1 {
    struct TokenInfo {
        bool enabled;
        bool isDeleted;
        string tokenName;
        address tokenAddress;
        address feesAddress;
        uint256 buyFeePercent;
        uint256 sellFeePercent;
    }
    function ONE() external returns (uint256);
    function factory() external returns (address);
    function WETH() external returns (address);
    function admin() external returns (address);
    function idToAddress(uint256) external returns (address);
    function routerTrade() external returns (address);
    function whitelistAccess(address) external returns (bool);
    function impls(uint256) external returns (address);
    function initialize(address,address) external;
    function setRouterTrade(address) external;
    function setWhitelist(address,bool) external;
    function version() external view returns (uint256);
    function setImpls(uint256,address) external;
    function addLiquidity(address,address,uint256,uint256,uint256,uint256,address,uint256) external returns (uint256,uint256,uint256);
    function addLiquidityETH(address,uint256,uint256,uint256,address,uint256) external payable returns (uint256,uint256,uint256);
    function removeLiquidity(address,address,uint256,uint256,uint256,address,uint256) external returns (uint256,uint256);
    function removeLiquidityETH(address,uint256,uint256,uint256,address,uint256) external returns (uint256,uint256);
    function removeLiquidityWithPermit(address,address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32) external returns (uint256,uint256);
    function removeLiquidityETHWithPermit(address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32) external returns (uint256,uint256);
    function removeLiquidityETHSupportingFeeOnTransferTokens(address,uint256,uint256,uint256,address,uint256) external returns (uint256);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32) external returns (uint256);
    function swapExactETHForTokens(uint256,address[] calldata,address,uint256) external payable returns (uint256[] memory);
    function swapTokensForExactETH(uint256,uint256,address[] calldata,address,address,uint256) external returns (uint256[] memory);
    function swapExactTokensForETH(uint256,uint256,address[] calldata,address,address,uint256) external returns (uint256[] memory);
    function swapETHForExactTokens(uint256,address[] calldata,address,uint256) external payable returns (uint256[] memory);
    function swapExactETHForTokensSupportingFeeOnTransferTokens(uint256,address[] calldata,address,uint256) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(uint256,uint256,address[] calldata,address,address,uint256) external;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(uint256,uint256,address[] calldata,address,uint256) external;
    function swapTokensForExactETH(uint256,uint256,address[] calldata,address,uint256) external returns (uint256[] memory);
    function swapExactTokensForETH(uint256,uint256,address[] calldata,address,uint256) external returns (uint256[] memory);
    function quote(uint256,uint256,uint256) external pure returns (uint256);
    function getAmountOut(uint256,uint256,uint256) external pure returns (uint256);
    function getAmountIn(uint256,uint256,uint256) external pure returns (uint256);
    function getAmountsOut(uint256,address[] memory) external view returns (uint256[] memory);
    function getAmountsIn(uint256,address[] memory) external view returns (uint256[] memory);
    function lockLP(address,uint256) external;
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
    ISafemoonV2 safemoonV2;
    ISafeSwapTradeRouter safeSwapTradeRouter;
    ISafeswapRouterProxy1 safeswapRouterProxy1;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

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
    struct Trade {
        uint256 amountIn;
        uint256 amountOut;
        address[] path;
        address to;
        uint256 deadline;
    }
    struct TokenFee {
        TokenInfo tokenInfo;
        SingleSwapFee[] singleSwapFees;
    }
    struct TokenInfo {
        uint8 transactionType;
        address tokenAddress;
        uint256 feePercentage;
        bool isEnabled;
        bool isDeleted;
    }
    struct SingleSwapFee {
        uint8 swapKind;
        address assetOut;
        address beneficiary;
        uint256 percentage;
        bool isEnabled;
    }

    constructor() public {
        hevm.roll(26857408);
        hevm.warp(1680008936);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        safemoonV1 = ISafemoonV1(0x0296201BfDfB410C29EF30BCaE1b395537aeEB31);
        safemoonV2 = ISafemoonV2(0xEb11a0a0beF1AC028B8C2d4CD64138DD5938cA7A);
        safeSwapTradeRouter = ISafeSwapTradeRouter(0x524BC73fCb4fB70E2E84dC08EFE255252A3b026E);
        safeswapRouterProxy1 = ISafeswapRouterProxy1(0x6AC68913d8FcCD52d196B09e6bC0205735A4be5f);
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 

    function Safemoon_initialize() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'initialize()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'initialize()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_totalFees() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'totalFees()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'totalFees()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_reflectionFromTokenInTiers(uint256 a, uint256 b, bool c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'reflectionFromTokenInTiers(uint256,uint256,bool)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'reflectionFromTokenInTiers(uint256,uint256,bool)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_reflectionFromToken(uint256 a, bool b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'reflectionFromToken(uint256,bool)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'reflectionFromToken(uint256,bool)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_tokenFromReflection(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'tokenFromReflection(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'tokenFromReflection(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_accountTier(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'accountTier(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'accountTier(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_feeTier(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'feeTier(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'feeTier(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_migrate(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'migrate(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'migrate(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_feeTiersLength() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'feeTiersLength()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'feeTiersLength()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_getContractBalance() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'getContractBalance()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'getContractBalance()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function Safemoon_mint(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    // TODO: Double-check this function for correctness
    // Safemoon.burn(address,uint256)
    // is a new function which appears to replace a function with a similar name,
    // Safemoon.burn(uint256).
    // If the functions have different arguments this function may be incorrect.
    function Safemoon_burn(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(safemoonV1).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safemoonV2).call(
            abi.encodeWithSignature(
                'burn(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Variables ***/ 

    function Safemoon__burnAddress() public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = safemoonV1._burnAddress();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = safemoonV2._burnAddress();
        assert(a1 == a2);
        return a1;
    }

    function Safemoon__maxTxAmount() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = safemoonV1._maxTxAmount();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = safemoonV2._maxTxAmount();
        assert(a1 == a2);
        return a1;
    }

    function Safemoon_whitelistMint(address a) public virtual returns (bool) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        bool a1 = safemoonV1.whitelistMint(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        bool a2 = safemoonV2.whitelistMint(a);
        assert(a1 == a2);
        return a1;
    }


    /*** Additional Targets ***/ 

    function SafeSwapTradeRouter_getPortalSwapFee(uint256 a, uint256 b, address c, address d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getPortalSwapFee(uint256,uint256,address,address)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getPortalSwapFee(uint256,uint256,address,address)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_getSwapFees(uint256 a, address[] memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getSwapFees(uint256,address[])', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getSwapFees(uint256,address[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_getTokenFeeAddresses() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTokenFeeAddresses()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTokenFeeAddresses()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_getTokenInfoDetails(address a, uint8 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTokenInfoDetails(address,SafeSwapTradeRouter.TransactionType)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTokenInfoDetails(address,SafeSwapTradeRouter.TransactionType)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_getTokenSwapFee(uint256 a, uint8 b, address c, bool d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTokenSwapFee(uint256,SafeSwapTradeRouter.TransactionType,address,bool)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTokenSwapFee(uint256,SafeSwapTradeRouter.TransactionType,address,bool)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_getTotalSwapFees(uint256 a, address[] memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTotalSwapFees(uint256,address[])', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'getTotalSwapFees(uint256,address[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_initialize(address a, address b, uint256 c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'initialize(address,address,uint256,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'initialize(address,address,uint256,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_swapETHForExactTokensWithFeeAmount(Trade calldata a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapETHForExactTokensWithFeeAmount(SafeSwapTradeRouter.Trade,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapETHForExactTokensWithFeeAmount(SafeSwapTradeRouter.Trade,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_swapExactETHForTokensWithFeeAmount(Trade calldata a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapExactETHForTokensWithFeeAmount(SafeSwapTradeRouter.Trade,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapExactETHForTokensWithFeeAmount(SafeSwapTradeRouter.Trade,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_swapExactTokensForETHAndFeeAmount(Trade calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapExactTokensForETHAndFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapExactTokensForETHAndFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_swapExactTokensForTokensWithFeeAmount(Trade calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapExactTokensForTokensWithFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapExactTokensForTokensWithFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_swapTokensForExactETHAndFeeAmount(Trade calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapTokensForExactETHAndFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapTokensForExactETHAndFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeSwapTradeRouter_swapTokensForExactTokensWithFeeAmount(Trade calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapTokensForExactTokensWithFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(safeSwapTradeRouter).call(
            abi.encodeWithSignature(
                'swapTokensForExactTokensWithFeeAmount(SafeSwapTradeRouter.Trade)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_WETH() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'WETH()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'WETH()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_addLiquidity(address a, address b, uint256 c, uint256 d, uint256 e, uint256 f, address g, uint256 h) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'addLiquidity(address,address,uint256,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f, g, h
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'addLiquidity(address,address,uint256,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f, g, h
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_addLiquidityETH(address a, uint256 b, uint256 c, uint256 d, address e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'addLiquidityETH(address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'addLiquidityETH(address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_factory() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'factory()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'factory()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_getAmountIn(uint256 a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountIn(uint256,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountIn(uint256,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_getAmountOut(uint256 a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountOut(uint256,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountOut(uint256,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_getAmountsIn(uint256 a, address[] memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountsIn(uint256,address[])', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountsIn(uint256,address[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_getAmountsOut(uint256 a, address[] memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountsOut(uint256,address[])', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'getAmountsOut(uint256,address[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_initialize(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'initialize(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'initialize(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_quote(uint256 a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'quote(uint256,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'quote(uint256,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_removeLiquidity(address a, address b, uint256 c, uint256 d, uint256 e, address f, uint256 g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidity(address,address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidity(address,address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_removeLiquidityETH(address a, uint256 b, uint256 c, uint256 d, address e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETH(address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETH(address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_removeLiquidityETHSupportingFeeOnTransferTokens(address a, uint256 b, uint256 c, uint256 d, address e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETHSupportingFeeOnTransferTokens(address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETHSupportingFeeOnTransferTokens(address,uint256,uint256,uint256,address,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_removeLiquidityETHWithPermit(address a, uint256 b, uint256 c, uint256 d, address e, uint256 f, bool g, uint8 h, bytes32 i, bytes32 j) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETHWithPermit(address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i, j
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETHWithPermit(address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i, j
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(address a, uint256 b, uint256 c, uint256 d, address e, uint256 f, bool g, uint8 h, bytes32 i, bytes32 j) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i, j
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i, j
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_removeLiquidityWithPermit(address a, address b, uint256 c, uint256 d, uint256 e, address f, uint256 g, bool h, uint8 i, bytes32 j, bytes32 k) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityWithPermit(address,address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i, j, k
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'removeLiquidityWithPermit(address,address,uint256,uint256,uint256,address,uint256,bool,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i, j, k
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapETHForExactTokens(uint256 a, address[] calldata b, address c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapETHForExactTokens(uint256,address[],address,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapETHForExactTokens(uint256,address[],address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapExactETHForTokens(uint256 a, address[] calldata b, address c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactETHForTokens(uint256,address[],address,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactETHForTokens(uint256,address[],address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapExactETHForTokensSupportingFeeOnTransferTokens(uint256 a, address[] calldata b, address c, uint256 d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactETHForTokensSupportingFeeOnTransferTokens(uint256,address[],address,uint256)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactETHForTokensSupportingFeeOnTransferTokens(uint256,address[],address,uint256)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapExactTokensForETH(uint256 a, uint256 b, address[] calldata c, address d, address e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETH(uint256,uint256,address[],address,address,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETH(uint256,uint256,address[],address,address,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapExactTokensForETH(uint256 a, uint256 b, address[] calldata c, address d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETH(uint256,uint256,address[],address,uint256)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETH(uint256,uint256,address[],address,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapExactTokensForETHSupportingFeeOnTransferTokens(uint256 a, uint256 b, address[] calldata c, address d, address e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETHSupportingFeeOnTransferTokens(uint256,uint256,address[],address,address,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETHSupportingFeeOnTransferTokens(uint256,uint256,address[],address,address,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapExactTokensForETHSupportingFeeOnTransferTokens(uint256 a, uint256 b, address[] calldata c, address d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETHSupportingFeeOnTransferTokens(uint256,uint256,address[],address,uint256)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapExactTokensForETHSupportingFeeOnTransferTokens(uint256,uint256,address[],address,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapTokensForExactETH(uint256 a, uint256 b, address[] calldata c, address d, address e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapTokensForExactETH(uint256,uint256,address[],address,address,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapTokensForExactETH(uint256,uint256,address[],address,address,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_swapTokensForExactETH(uint256 a, uint256 b, address[] calldata c, address d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapTokensForExactETH(uint256,uint256,address[],address,uint256)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'swapTokensForExactETH(uint256,uint256,address[],address,uint256)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SafeswapRouterProxy1_version() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'version()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(safeswapRouterProxy1).call(
            abi.encodeWithSignature(
                'version()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
