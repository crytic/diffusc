// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.0;

interface ILiquidityPoolV1 {
    struct PermitRequest {
        uint256 nonce;
        uint256 expiry;
        bool allowed;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }
    struct TokenInfo {
        uint256 transferOverhead;
        bool supportedToken;
        uint256 equilibriumFee;
        uint256 maxFee;
        TokenConfig tokenConfig;
    }
    struct TokenConfig {
        uint256 min;
        uint256 max;
    }
    function baseGas() external returns (uint256);
    function tokenManager() external returns (address);
    function liquidityProviders() external returns (address);
    function processedHash(bytes32) external returns (bool);
    function gasFeeAccumulatedByToken(address) external returns (uint256);
    function gasFeeAccumulated(address,address) external returns (uint256);
    function incentivePool(address) external returns (uint256);
    function isTrustedForwarder(address) external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function isPauser(address) external view returns (bool);
    function changePauser(address) external;
    function renouncePauser() external;
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
    function initialize(address,address,address,address,address) external;
    function setTrustedForwarder(address) external;
    function setLiquidityProviders(address) external;
    function setTokenManager(address) external;
    function setBaseGas(uint128) external;
    function getExecutorManager() external view returns (address);
    function setExecutorManager(address) external;
    function getCurrentLiquidity(address) external view returns (uint256);
    function depositErc20(uint256,address,address,uint256,string calldata) external;
    function getRewardAmount(uint256,address) external view returns (uint256);
    function permitAndDepositErc20(address,address,uint256,uint256,PermitRequest memory,string calldata) external;
    function permitEIP2612AndDepositErc20(address,address,uint256,uint256,PermitRequest memory,string calldata) external;
    function depositNative(address,uint256,string calldata) external payable;
    function sendFundsToUser(address,uint256,address,bytes calldata,uint256,uint256) external;
    function getTransferFee(address,uint256) external view returns (uint256);
    function checkHashStatus(address,uint256,address,bytes calldata) external view returns (bytes32,bool);
    function withdrawErc20GasFee(address) external;
    function withdrawNativeGasFee() external;
    function transfer(address,address,uint256) external;
}

interface ILiquidityPoolV2 {
    struct PermitRequest {
        uint256 nonce;
        uint256 expiry;
        bool allowed;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }
    struct TokenInfo {
        uint256 transferOverhead;
        bool supportedToken;
        uint256 equilibriumFee;
        uint256 maxFee;
        TokenConfig tokenConfig;
    }
    struct TokenConfig {
        uint256 min;
        uint256 max;
    }
    function baseGas() external returns (uint256);
    function tokenManager() external returns (address);
    function liquidityProviders() external returns (address);
    function processedHash(bytes32) external returns (bool);
    function gasFeeAccumulatedByToken(address) external returns (uint256);
    function gasFeeAccumulated(address,address) external returns (uint256);
    function incentivePool(address) external returns (uint256);
    function isTrustedForwarder(address) external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function isPauser(address) external view returns (bool);
    function changePauser(address) external;
    function renouncePauser() external;
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
    function initialize(address,address,address,address,address) external;
    function setTrustedForwarder(address) external;
    function setLiquidityProviders(address) external;
    function setTokenManager(address) external;
    function setBaseGas(uint128) external;
    function getExecutorManager() external view returns (address);
    function setExecutorManager(address) external;
    function getCurrentLiquidity(address) external view returns (uint256);
    function depositErc20(uint256,address,address,uint256,string calldata) external;
    function getRewardAmount(uint256,address) external view returns (uint256);
    function permitAndDepositErc20(address,address,uint256,uint256,PermitRequest memory,string calldata) external;
    function permitEIP2612AndDepositErc20(address,address,uint256,uint256,PermitRequest memory,string calldata) external;
    function depositNative(address,uint256,string calldata) external payable;
    function sendFundsToUser(address,uint256,address,bytes calldata,uint256,uint256) external;
    function sendFundsToUserV2(address,uint256,address,bytes calldata,uint256,uint256) external;
    function getTransferFee(address,uint256) external view returns (uint256);
    function checkHashStatus(address,uint256,address,bytes calldata) external view returns (bytes32,bool);
    function withdrawErc20GasFee(address) external;
    function withdrawNativeGasFee() external;
    function transfer(address,address,uint256) external;
}

interface IExecutorManager {
    struct AddressSet {
        Set _inner;
    }
    struct Set {
        bytes32[] _values;
        mapping(bytes32 => uint256) _indexes;
    }
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function getExecutorStatus(address) external view returns (bool);
    function getAllExecutors() external view returns (address[] memory);
    function addExecutors(address[] calldata) external;
    function addExecutor(address) external;
    function removeExecutors(address[] calldata) external;
    function removeExecutor(address) external;
}

interface ILiquidityProviders {
    struct LpTokenMetadata {
        address token;
        uint256 suppliedLiquidity;
        uint256 shares;
    }
    struct TokenInfo {
        uint256 transferOverhead;
        bool supportedToken;
        uint256 equilibriumFee;
        uint256 maxFee;
        TokenConfig tokenConfig;
    }
    struct TokenConfig {
        uint256 min;
        uint256 max;
    }
    function BASE_DIVISOR() external returns (uint256);
    function totalReserve(address) external returns (uint256);
    function totalLiquidity(address) external returns (uint256);
    function currentLiquidity(address) external returns (uint256);
    function totalLPFees(address) external returns (uint256);
    function totalSharesMinted(address) external returns (uint256);
    function isPauser(address) external view returns (bool);
    function changePauser(address) external;
    function renouncePauser() external;
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function isTrustedForwarder(address) external view returns (bool);
    function initialize(address,address,address,address) external;
    function getTotalReserveByToken(address) external view returns (uint256);
    function getSuppliedLiquidityByToken(address) external view returns (uint256);
    function getTotalLPFeeByToken(address) external view returns (uint256);
    function getCurrentLiquidity(address) external view returns (uint256);
    function setLpToken(address) external;
    function increaseCurrentLiquidity(address,uint256) external;
    function decreaseCurrentLiquidity(address,uint256) external;
    function setTokenManager(address) external;
    function setTrustedForwarder(address) external;
    function setWhiteListPeriodManager(address) external;
    function setLiquidityPool(address) external;
    function getTokenPriceInLPShares(address) external view returns (uint256);
    function sharesToTokenAmount(uint256,address) external view returns (uint256);
    function getFeeAccumulatedOnNft(uint256) external view returns (uint256);
    function addLPFee(address,uint256) external;
    function addNativeLiquidity() external payable;
    function addTokenLiquidity(address,uint256) external;
    function increaseTokenLiquidity(uint256,uint256) external;
    function increaseNativeLiquidity(uint256) external payable;
    function removeLiquidity(uint256,uint256) external;
    function claimFee(uint256) external;
    function getSuppliedLiquidity(uint256) external view returns (uint256);
}

interface ITokenManager {
    struct TokenInfo {
        uint256 transferOverhead;
        bool supportedToken;
        uint256 equilibriumFee;
        uint256 maxFee;
        TokenConfig tokenConfig;
    }
    struct TokenConfig {
        uint256 min;
        uint256 max;
    }
    function tokensInfo(address) external returns (TokenInfo memory);
    function excessStateTransferFeePerc(address) external returns (uint256);
    function depositConfig(uint256,address) external returns (TokenConfig memory);
    function transferConfig(address) external returns (TokenConfig memory);
    function isPauser(address) external view returns (bool);
    function changePauser(address) external;
    function renouncePauser() external;
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function isTrustedForwarder(address) external view returns (bool);
    function initialize(address,address) external;
    function getEquilibriumFee(address) external view returns (uint256);
    function getMaxFee(address) external view returns (uint256);
    function changeFee(address,uint256,uint256) external;
    function changeExcessStateFee(address,uint256) external;
    function setTokenTransferOverhead(address,uint256) external;
    function setDepositConfig(uint256[] memory,address[] memory,TokenConfig[] memory) external;
    function addSupportedToken(address,uint256,uint256,uint256,uint256,uint256) external;
    function removeSupportedToken(address) external;
    function updateTokenCap(address,uint256,uint256) external;
    function getTokensInfo(address) external view returns (TokenInfo memory);
    function getDepositConfig(uint256,address) external view returns (TokenConfig memory);
    function getTransferConfig(address) external view returns (TokenConfig memory);
    function setTrustedForwarder(address) external;
}

interface IUChildAdministrableERC20 {
    enum AuthorizationState { Unused, Used, Canceled }
    struct RoleData {
        AddressSet members;
        bytes32 adminRole;
    }
    struct MetaTransaction {
        uint256 nonce;
        address from;
        bytes functionSignature;
    }
    struct AddressSet {
        Set _inner;
    }
    struct Set {
        bytes32[] _values;
        mapping(bytes32 => uint256) _indexes;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function DOMAIN_SEPARATOR() external returns (bytes32);
    function META_TRANSACTION_TYPEHASH() external returns (bytes32);
    function PERMIT_TYPEHASH() external returns (bytes32);
    function TRANSFER_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function APPROVE_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function INCREASE_ALLOWANCE_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function DECREASE_ALLOWANCE_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function CANCEL_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function WITHDRAW_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function DEPOSITOR_ROLE() external returns (bytes32);
    function EIP712_VERSION() external returns (string memory);
    function BLACKLISTER_ROLE() external returns (bytes32);
    function PAUSER_ROLE() external returns (bytes32);
    function RESCUER_ROLE() external returns (bytes32);
    function rescuers() external view returns (address[] memory);
    function rescueERC20(address,address,uint256) external;
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleMemberCount(bytes32) external view returns (uint256);
    function getRoleMember(bytes32,uint256) external view returns (address);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function pausers() external view returns (address[] memory);
    function paused() external view returns (bool);
    function pause() external;
    function unpause() external;
    function blacklisters() external view returns (address[] memory);
    function isBlacklisted(address) external view returns (bool);
    function blacklist(address) external;
    function unBlacklist(address) external;
    function initialize(string calldata,string calldata,uint8,address) external;
    function updateMetadata(string calldata,string calldata) external;
    function deposit(address,bytes calldata) external;
    function authorizationState(address,bytes32) external view returns (AuthorizationState);
    function nonces(address) external view returns (uint256);
    function executeMetaTransaction(address,bytes memory,bytes32,bytes32,uint8) external payable returns (bytes memory);
    function initialized() external view returns (bool);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address,address) external view returns (uint256);
    function withdraw(uint256) external;
    function transfer(address,uint256) external returns (bool);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function permit(address,address,uint256,uint256,uint8,bytes32,bytes32) external;
    function transferWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function approveWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function increaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function decreaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function withdrawWithAuthorization(address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function cancelAuthorization(address,bytes32,uint8,bytes32,bytes32) external;
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

    ILiquidityPoolV1 liquidityPoolV1;
    ILiquidityPoolV2 liquidityPoolV2;
    ITransparentUpgradeableProxy transparentUpgradeableProxy;
    IExecutorManager executorManager;
    ILiquidityProviders liquidityProviders;
    ITokenManager tokenManager;
    IUChildAdministrableERC20 uChildAdministrableERC20;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

    struct PermitRequest {
        uint256 nonce;
        uint256 expiry;
        bool allowed;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }
    struct TokenInfo {
        uint256 transferOverhead;
        bool supportedToken;
        uint256 equilibriumFee;
        uint256 maxFee;
        TokenConfig tokenConfig;
    }
    struct TokenConfig {
        uint256 min;
        uint256 max;
    }
    struct RoleData {
        AddressSet members;
        bytes32 adminRole;
    }
    struct MetaTransaction {
        uint256 nonce;
        address from;
        bytes functionSignature;
    }
    struct AddressSet {
        Set _inner;
    }
    struct Set {
        bytes32[] _values;
        mapping(bytes32 => uint256) _indexes;
    }

    constructor() public {
        hevm.roll(28237665);
        hevm.warp(1652379594);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        liquidityPoolV1 = ILiquidityPoolV1(0xD0eE149a4Ceec165C456C1E2D4372318e4Df82bd);
        liquidityPoolV2 = ILiquidityPoolV2(0x6C0CbaC5337Cf577452e99A18320fc5656Bd61E7);
        transparentUpgradeableProxy = ITransparentUpgradeableProxy(0x2A5c2568b10A0E826BfA892Cf21BA7218310180b);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(liquidityPoolV1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(transparentUpgradeableProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(liquidityPoolV2))))
        );
        executorManager = IExecutorManager(0xbd761D917fB77381B4398Bda89C7F0d9A2BD1399);
        liquidityProviders = ILiquidityProviders(0xebaB24F13de55789eC1F3fFe99A285754e15F7b9);
        tokenManager = ITokenManager(0x79E559AC5b499A5676e28f0074e29763F6c2A27e);
        uChildAdministrableERC20 = IUChildAdministrableERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);
    }


    /*** Modified Functions ***/ 

    function LiquidityPool_changePauser(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'changePauser(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'changePauser(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_renouncePauser() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'renouncePauser()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'renouncePauser()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_setTrustedForwarder(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setTrustedForwarder(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setTrustedForwarder(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_depositErc20(uint256 a, address b, address c, uint256 d, string memory e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'depositErc20(uint256,address,address,uint256,string)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'depositErc20(uint256,address,address,uint256,string)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_depositNative(address a, uint256 b, string memory c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'depositNative(address,uint256,string)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'depositNative(address,uint256,string)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function LiquidityPool_isTrustedForwarder(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'isTrustedForwarder(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'isTrustedForwarder(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_renounceOwnership() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_transferOwnership(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_isPauser(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'isPauser(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'isPauser(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_pause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_unpause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_initialize(address a, address b, address c, address d, address e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,address,address)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,address,address)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_setLiquidityProviders(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setLiquidityProviders(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setLiquidityProviders(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_setTokenManager(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setTokenManager(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setTokenManager(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_setBaseGas(uint128 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setBaseGas(uint128)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setBaseGas(uint128)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_setExecutorManager(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setExecutorManager(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'setExecutorManager(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_getCurrentLiquidity(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getCurrentLiquidity(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getCurrentLiquidity(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_getRewardAmount(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getRewardAmount(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getRewardAmount(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_permitAndDepositErc20(address a, address b, uint256 c, uint256 d, PermitRequest calldata e, string memory f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'permitAndDepositErc20(address,address,uint256,uint256,LiquidityPool.PermitRequest,string)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'permitAndDepositErc20(address,address,uint256,uint256,LiquidityPool.PermitRequest,string)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_permitEIP2612AndDepositErc20(address a, address b, uint256 c, uint256 d, PermitRequest calldata e, string memory f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'permitEIP2612AndDepositErc20(address,address,uint256,uint256,LiquidityPool.PermitRequest,string)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'permitEIP2612AndDepositErc20(address,address,uint256,uint256,LiquidityPool.PermitRequest,string)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_sendFundsToUser(address a, uint256 b, address c, bytes memory d, uint256 e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'sendFundsToUser(address,uint256,address,bytes,uint256,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'sendFundsToUser(address,uint256,address,bytes,uint256,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_getTransferFee(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getTransferFee(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'getTransferFee(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_checkHashStatus(address a, uint256 b, address c, bytes memory d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'checkHashStatus(address,uint256,address,bytes)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'checkHashStatus(address,uint256,address,bytes)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_withdrawErc20GasFee(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'withdrawErc20GasFee(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'withdrawErc20GasFee(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_withdrawNativeGasFee() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'withdrawNativeGasFee()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'withdrawNativeGasFee()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityPool_transfer(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'transfer(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'transfer(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    // TODO: Double-check this function for correctness
    // LiquidityPool.sendFundsToUserV2(address,uint256,address,bytes,uint256,uint256)
    // is a new function which appears to replace a function with a similar name,
    // LiquidityPool.sendFundsToUser(address,uint256,address,bytes,uint256,uint256).
    // If the functions have different arguments this function may be incorrect.
    function LiquidityPool_sendFundsToUserV2(address a, uint256 b, address c, bytes memory d, uint256 e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(transparentUpgradeableProxy).call(
            abi.encodeWithSignature(
                'sendFundsToUser(address,uint256,address,bytes,uint256,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(transparentUpgradeableProxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        bool successV2;
        bytes memory outputV2;
        if(impl == address(liquidityPoolV2)) {
            (successV2, outputV2) = address(transparentUpgradeableProxy).call(
                abi.encodeWithSignature(
                        'sendFundsToUserV2(address,uint256,address,bytes,uint256,uint256)', a, b, c, d, e, f
                )
            );
        } else {
            (successV2, outputV2) = address(transparentUpgradeableProxy).call(
                abi.encodeWithSignature(
                        'sendFundsToUser(address,uint256,address,bytes,uint256,uint256)', a, b, c, d, e, f
                )
            );
        }
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Variables ***/ 

    function LiquidityPool_baseGas() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = ILiquidityPoolV1(address(transparentUpgradeableProxy)).baseGas();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = ILiquidityPoolV2(address(transparentUpgradeableProxy)).baseGas();
        assert(a1 == a2);
        return a1;
    }

    function LiquidityPool_tokenManager() public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = ILiquidityPoolV1(address(transparentUpgradeableProxy)).tokenManager();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = ILiquidityPoolV2(address(transparentUpgradeableProxy)).tokenManager();
        assert(a1 == a2);
        return a1;
    }

    function LiquidityPool_liquidityProviders() public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = ILiquidityPoolV1(address(transparentUpgradeableProxy)).liquidityProviders();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = ILiquidityPoolV2(address(transparentUpgradeableProxy)).liquidityProviders();
        assert(a1 == a2);
        return a1;
    }

    function LiquidityPool_processedHash(bytes32 a) public virtual returns (bool) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        bool a1 = ILiquidityPoolV1(address(transparentUpgradeableProxy)).processedHash(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        bool a2 = ILiquidityPoolV2(address(transparentUpgradeableProxy)).processedHash(a);
        assert(a1 == a2);
        return a1;
    }

    function LiquidityPool_gasFeeAccumulatedByToken(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = ILiquidityPoolV1(address(transparentUpgradeableProxy)).gasFeeAccumulatedByToken(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = ILiquidityPoolV2(address(transparentUpgradeableProxy)).gasFeeAccumulatedByToken(a);
        assert(a1 == a2);
        return a1;
    }

    function LiquidityPool_incentivePool(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = ILiquidityPoolV1(address(transparentUpgradeableProxy)).incentivePool(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = ILiquidityPoolV2(address(transparentUpgradeableProxy)).incentivePool(a);
        assert(a1 == a2);
        return a1;
    }


    /*** Additional Targets ***/ 

    function ExecutorManager_addExecutor(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'addExecutor(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'addExecutor(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_addExecutors(address[] calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'addExecutors(address[])', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'addExecutors(address[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_getAllExecutors() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'getAllExecutors()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'getAllExecutors()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_getExecutorStatus(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'getExecutorStatus(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'getExecutorStatus(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_owner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_removeExecutor(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'removeExecutor(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'removeExecutor(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_removeExecutors(address[] calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'removeExecutors(address[])', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'removeExecutors(address[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_renounceOwnership() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ExecutorManager_transferOwnership(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(executorManager).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(executorManager).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_addLPFee(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'addLPFee(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'addLPFee(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_addNativeLiquidity() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'addNativeLiquidity()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'addNativeLiquidity()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_addTokenLiquidity(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'addTokenLiquidity(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'addTokenLiquidity(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_changePauser(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'changePauser(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'changePauser(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_claimFee(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'claimFee(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'claimFee(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_decreaseCurrentLiquidity(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'decreaseCurrentLiquidity(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'decreaseCurrentLiquidity(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_getCurrentLiquidity(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getCurrentLiquidity(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getCurrentLiquidity(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_getFeeAccumulatedOnNft(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getFeeAccumulatedOnNft(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getFeeAccumulatedOnNft(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_getSuppliedLiquidity(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getSuppliedLiquidity(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getSuppliedLiquidity(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_getSuppliedLiquidityByToken(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getSuppliedLiquidityByToken(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getSuppliedLiquidityByToken(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_getTokenPriceInLPShares(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getTokenPriceInLPShares(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getTokenPriceInLPShares(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_getTotalLPFeeByToken(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getTotalLPFeeByToken(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getTotalLPFeeByToken(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_getTotalReserveByToken(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getTotalReserveByToken(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'getTotalReserveByToken(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_increaseCurrentLiquidity(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'increaseCurrentLiquidity(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'increaseCurrentLiquidity(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_increaseNativeLiquidity(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'increaseNativeLiquidity(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'increaseNativeLiquidity(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_increaseTokenLiquidity(uint256 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'increaseTokenLiquidity(uint256,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'increaseTokenLiquidity(uint256,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_initialize(address a, address b, address c, address d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,address)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,address)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_isPauser(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'isPauser(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'isPauser(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_isTrustedForwarder(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'isTrustedForwarder(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'isTrustedForwarder(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_owner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_pause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_paused() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_removeLiquidity(uint256 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'removeLiquidity(uint256,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'removeLiquidity(uint256,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_renounceOwnership() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_renouncePauser() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'renouncePauser()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'renouncePauser()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_setLiquidityPool(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setLiquidityPool(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setLiquidityPool(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_setLpToken(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setLpToken(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setLpToken(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_setTokenManager(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setTokenManager(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setTokenManager(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_setTrustedForwarder(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setTrustedForwarder(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setTrustedForwarder(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_setWhiteListPeriodManager(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setWhiteListPeriodManager(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'setWhiteListPeriodManager(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_sharesToTokenAmount(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'sharesToTokenAmount(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'sharesToTokenAmount(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_transferOwnership(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function LiquidityProviders_unpause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(liquidityProviders).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_addSupportedToken(address a, uint256 b, uint256 c, uint256 d, uint256 e, uint256 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'addSupportedToken(address,uint256,uint256,uint256,uint256,uint256)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'addSupportedToken(address,uint256,uint256,uint256,uint256,uint256)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_changeExcessStateFee(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'changeExcessStateFee(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'changeExcessStateFee(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_changeFee(address a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'changeFee(address,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'changeFee(address,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_changePauser(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'changePauser(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'changePauser(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_excessStateTransferFeePerc(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'excessStateTransferFeePerc(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'excessStateTransferFeePerc(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_getDepositConfig(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getDepositConfig(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getDepositConfig(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_getEquilibriumFee(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getEquilibriumFee(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getEquilibriumFee(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_getMaxFee(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getMaxFee(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getMaxFee(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_getTokensInfo(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getTokensInfo(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getTokensInfo(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_getTransferConfig(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getTransferConfig(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'getTransferConfig(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_initialize(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'initialize(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'initialize(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_isPauser(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'isPauser(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'isPauser(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_isTrustedForwarder(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'isTrustedForwarder(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'isTrustedForwarder(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_owner() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'owner()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_pause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_paused() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_removeSupportedToken(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'removeSupportedToken(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'removeSupportedToken(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_renounceOwnership() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'renounceOwnership()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_renouncePauser() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'renouncePauser()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'renouncePauser()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_setDepositConfig(uint256[] memory a, address[] memory b, TokenConfig[] memory c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'setDepositConfig(uint256[],address[],TokenConfig[])', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'setDepositConfig(uint256[],address[],TokenConfig[])', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_setTokenTransferOverhead(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'setTokenTransferOverhead(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'setTokenTransferOverhead(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_setTrustedForwarder(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'setTrustedForwarder(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'setTrustedForwarder(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_tokensInfo(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'tokensInfo(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'tokensInfo(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_transferOwnership(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'transferOwnership(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_unpause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function TokenManager_updateTokenCap(address a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(tokenManager).call(
            abi.encodeWithSignature(
                'updateTokenCap(address,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(tokenManager).call(
            abi.encodeWithSignature(
                'updateTokenCap(address,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_allowance(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_approveWithAuthorization(address a, address b, uint256 c, uint256 d, uint256 e, bytes32 f, uint8 g, bytes32 h, bytes32 i) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'approveWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'approveWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_authorizationState(address a, bytes32 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'authorizationState(address,bytes32)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'authorizationState(address,bytes32)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_blacklist(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'blacklist(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'blacklist(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_blacklisters() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'blacklisters()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'blacklisters()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_cancelAuthorization(address a, bytes32 b, uint8 c, bytes32 d, bytes32 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'cancelAuthorization(address,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'cancelAuthorization(address,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_decimals() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_decreaseAllowanceWithAuthorization(address a, address b, uint256 c, uint256 d, uint256 e, bytes32 f, uint8 g, bytes32 h, bytes32 i) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'decreaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'decreaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_deposit(address a, bytes memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'deposit(address,bytes)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'deposit(address,bytes)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_executeMetaTransaction(address a, bytes memory b, bytes32 c, bytes32 d, uint8 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'executeMetaTransaction(address,bytes,bytes32,bytes32,uint8)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'executeMetaTransaction(address,bytes,bytes32,bytes32,uint8)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_getRoleAdmin(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_getRoleMember(bytes32 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'getRoleMember(bytes32,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'getRoleMember(bytes32,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_getRoleMemberCount(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'getRoleMemberCount(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'getRoleMemberCount(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_grantRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_hasRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_increaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_increaseAllowanceWithAuthorization(address a, address b, uint256 c, uint256 d, uint256 e, bytes32 f, uint8 g, bytes32 h, bytes32 i) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'increaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'increaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_initialize(string memory a, string memory b, uint8 c, address d) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'initialize(string,string,uint8,address)', a, b, c, d
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'initialize(string,string,uint8,address)', a, b, c, d
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_initialized() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'initialized()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'initialized()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_isBlacklisted(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'isBlacklisted(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'isBlacklisted(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_name() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_nonces(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'nonces(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'nonces(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_pause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_paused() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_pausers() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'pausers()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'pausers()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_permit(address a, address b, uint256 c, uint256 d, uint8 e, bytes32 f, bytes32 g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_renounceRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_rescueERC20(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'rescueERC20(IERC20,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'rescueERC20(IERC20,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_rescuers() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'rescuers()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'rescuers()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_revokeRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_symbol() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_totalSupply() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_transferWithAuthorization(address a, address b, uint256 c, uint256 d, uint256 e, bytes32 f, uint8 g, bytes32 h, bytes32 i) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'transferWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'transferWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_unBlacklist(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'unBlacklist(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'unBlacklist(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_unpause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_updateMetadata(string memory a, string memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'updateMetadata(string,string)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'updateMetadata(string,string)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_withdraw(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'withdraw(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'withdraw(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function UChildAdministrableERC20_withdrawWithAuthorization(address a, uint256 b, uint256 c, uint256 d, bytes32 e, uint8 f, bytes32 g, bytes32 h) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'withdrawWithAuthorization(address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(uChildAdministrableERC20).call(
            abi.encodeWithSignature(
                'withdrawWithAuthorization(address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
