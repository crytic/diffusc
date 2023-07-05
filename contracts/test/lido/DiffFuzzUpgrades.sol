// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.7;

import { StMATIC as StMATIC_V1 } from "../../implementation/lido/StakedMATIC/0x5604332de9e9dd8f485bcbb3442809498ab7983e/StMATIC/contracts/StMATIC.sol";
import { StMATIC as StMATIC_V2 } from "../../implementation/lido/StakedMATIC/0x6c25aebd494a9984a3d7c8cf395c8713e0c74d98/StMATIC/contracts/StMATIC.sol";
import { TransparentProxyTestHarness } from "../../implementation/deus/TransparentProxyTestHarness.sol";

interface IStMATICV1 {
    struct RequestWithdraw {
        uint256 amount2WithdrawFromStMATIC;
        uint256 validatorNonce;
        uint256 requestEpoch;
        address validatorAddress;
    }
    struct FeeDistribution {
        uint8 dao;
        uint8 operators;
        uint8 insurance;
    }
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function nodeOperatorRegistry() external returns (address);
    function entityFees() external returns (FeeDistribution memory);
    function stakeManager() external returns (address);
    function poLidoNFT() external returns (address);
    function fxStateRootTunnel() external returns (address);
    function version() external returns (string memory);
    function dao() external returns (address);
    function insurance() external returns (address);
    function token() external returns (address);
    function lastWithdrawnValidatorId() external returns (uint256);
    function totalBuffered() external returns (uint256);
    function delegationLowerBound() external returns (uint256);
    function rewardDistributionLowerBound() external returns (uint256);
    function reservedFunds() external returns (uint256);
    function submitThreshold() external returns (uint256);
    function submitHandler() external returns (bool);
    function token2WithdrawRequest(uint256) external returns (RequestWithdraw memory);
    function DAO() external returns (bytes32);
    function PAUSE_ROLE() external returns (bytes32);
    function UNPAUSE_ROLE() external returns (bytes32);
    function stMaticWithdrawRequest(uint256) external returns (RequestWithdraw memory);
    function token2WithdrawRequests(uint256,uint256) external returns (RequestWithdraw memory);
    function protocolFee() external returns (uint8);
    function paused() external view returns (bool);
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
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
    function initialize(address,address,address,address,address,address,address) external;
    function submit(uint256,address) external returns (uint256);
    function requestWithdraw(uint256,address) external returns (uint256);
    function delegate() external;
    function claimTokens(uint256) external;
    function distributeRewards() external;
    function withdrawTotalDelegated(address) external;
    function rebalanceDelegatedTokens() external;
    function calculatePendingBufferedTokens() external view returns (uint256);
    function claimTokensFromValidatorToContract(uint256) external;
    function pause() external;
    function unpause() external;
    function getTotalWithdrawRequest() external view returns (RequestWithdraw[] memory);
    function getTotalStake(address) external view returns (uint256,uint256);
    function getLiquidRewards(address) external view returns (uint256);
    function getTotalStakeAcrossAllValidators() external view returns (uint256);
    function getTotalPooledMatic() external view returns (uint256);
    function convertStMaticToMatic(uint256) external view returns (uint256,uint256,uint256);
    function convertMaticToStMatic(uint256) external view returns (uint256,uint256,uint256);
    function getToken2WithdrawRequests(uint256) external view returns (RequestWithdraw[] memory);
    function setFees(uint8,uint8,uint8) external;
    function setProtocolFee(uint8) external;
    function setDaoAddress(address) external;
    function setInsuranceAddress(address) external;
    function setNodeOperatorRegistryAddress(address) external;
    function setDelegationLowerBound(uint256) external;
    function setRewardDistributionLowerBound(uint256) external;
    function setFxStateRootTunnel(address) external;
    function getMaticFromTokenId(uint256) external view returns (uint256);
    function recover(address[] memory,uint256[] memory,address,uint256) external;
}

interface IStMATICV2 {
    struct RequestWithdraw {
        uint256 amount2WithdrawFromStMATIC;
        uint256 validatorNonce;
        uint256 requestEpoch;
        address validatorAddress;
    }
    struct FeeDistribution {
        uint8 dao;
        uint8 operators;
        uint8 insurance;
    }
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function nodeOperatorRegistry() external returns (address);
    function entityFees() external returns (FeeDistribution memory);
    function stakeManager() external returns (address);
    function poLidoNFT() external returns (address);
    function fxStateRootTunnel() external returns (address);
    function version() external returns (string memory);
    function dao() external returns (address);
    function insurance() external returns (address);
    function token() external returns (address);
    function lastWithdrawnValidatorId() external returns (uint256);
    function totalBuffered() external returns (uint256);
    function delegationLowerBound() external returns (uint256);
    function rewardDistributionLowerBound() external returns (uint256);
    function reservedFunds() external returns (uint256);
    function submitThreshold() external returns (uint256);
    function submitHandler() external returns (bool);
    function token2WithdrawRequest(uint256) external returns (RequestWithdraw memory);
    function DAO() external returns (bytes32);
    function PAUSE_ROLE() external returns (bytes32);
    function UNPAUSE_ROLE() external returns (bytes32);
    function stMaticWithdrawRequest(uint256) external returns (RequestWithdraw memory);
    function token2WithdrawRequests(uint256,uint256) external returns (RequestWithdraw memory);
    function protocolFee() external returns (uint8);
    function paused() external view returns (bool);
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
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
    function initialize(address,address,address,address,address,address,address) external;
    function submit(uint256,address) external returns (uint256);
    function requestWithdraw(uint256,address) external returns (uint256);
    function delegate() external;
    function claimTokens(uint256) external;
    function distributeRewards() external;
    function withdrawTotalDelegated(address) external;
    function rebalanceDelegatedTokens() external;
    function calculatePendingBufferedTokens() external view returns (uint256);
    function claimTokensFromValidatorToContract(uint256) external;
    function pause() external;
    function unpause() external;
    function getTotalWithdrawRequest() external view returns (RequestWithdraw[] memory);
    function getTotalStake(address) external view returns (uint256,uint256);
    function getLiquidRewards(address) external view returns (uint256);
    function getTotalStakeAcrossAllValidators() external view returns (uint256);
    function getTotalPooledMatic() external view returns (uint256);
    function convertStMaticToMatic(uint256) external view returns (uint256,uint256,uint256);
    function convertMaticToStMatic(uint256) external view returns (uint256,uint256,uint256);
    function getToken2WithdrawRequests(uint256) external view returns (RequestWithdraw[] memory);
    function setFees(uint8,uint8,uint8) external;
    function setProtocolFee(uint8) external;
    function setDaoAddress(address) external;
    function setInsuranceAddress(address) external;
    function setNodeOperatorRegistryAddress(address) external;
    function setDelegationLowerBound(uint256) external;
    function setRewardDistributionLowerBound(uint256) external;
    function setPoLidoNFT(address) external;
    function setFxStateRootTunnel(address) external;
    function setVersion(string calldata) external;
    function getMaticFromTokenId(uint256) external view returns (uint256);
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

    IStMATICV1 stMATICV1;
    IStMATICV2 stMATICV2;
    ITransparentProxyTestHarness transparentProxyTestHarnessV1;
    ITransparentProxyTestHarness transparentProxyTestHarnessV2;
    struct RequestWithdraw {
        uint256 amount2WithdrawFromStMATIC;
        uint256 validatorNonce;
        uint256 requestEpoch;
        address validatorAddress;
    }
    struct FeeDistribution {
        uint8 dao;
        uint8 operators;
        uint8 insurance;
    }
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    constructor() public {
        stMATICV1 = IStMATICV1(address(new StMATIC_V1()));
        stMATICV2 = IStMATICV2(address(new StMATIC_V2()));
        transparentProxyTestHarnessV1 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        transparentProxyTestHarnessV2 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        // Store the implementation addresses in the proxy.
        hevm.store(
            address(transparentProxyTestHarnessV1),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(stMATICV1))))
        );
        hevm.store(
            address(transparentProxyTestHarnessV2),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(stMATICV2))))
        );
    }


    /*** Modified Functions ***/ 

    function StMATIC_submit(uint256 a, address b) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'submit(uint256,address)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'submit(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_requestWithdraw(uint256 a, address b) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'requestWithdraw(uint256,address)', a, b
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'requestWithdraw(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_delegate() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'delegate()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'delegate()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_distributeRewards() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'distributeRewards()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'distributeRewards()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_claimTokensFromValidatorToContract(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'claimTokensFromValidatorToContract(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claimTokensFromValidatorToContract(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_rebalanceDelegatedTokens() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'rebalanceDelegatedTokens()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'rebalanceDelegatedTokens()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_getTotalStakeAcrossAllValidators() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getTotalStakeAcrossAllValidators()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getTotalStakeAcrossAllValidators()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function StMATIC_totalSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_initialize(address a, address b, address c, address d, address e, address f, address g) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,address,address,address,address)', a, b, c, d, e, f, g
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'initialize(address,address,address,address,address,address,address)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_claimTokens(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'claimTokens(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'claimTokens(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_withdrawTotalDelegated(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'withdrawTotalDelegated(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'withdrawTotalDelegated(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_calculatePendingBufferedTokens() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'calculatePendingBufferedTokens()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'calculatePendingBufferedTokens()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_getTotalWithdrawRequest() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getTotalWithdrawRequest()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getTotalWithdrawRequest()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_getTotalPooledMatic() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getTotalPooledMatic()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getTotalPooledMatic()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_convertStMaticToMatic(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'convertStMaticToMatic(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'convertStMaticToMatic(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_convertMaticToStMatic(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'convertMaticToStMatic(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'convertMaticToStMatic(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_getToken2WithdrawRequests(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getToken2WithdrawRequests(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getToken2WithdrawRequests(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StMATIC_getMaticFromTokenId(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getMaticFromTokenId(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getMaticFromTokenId(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function StMATIC_setPoLidoNFT(address a) public virtual {
        // This function does nothing with the V1, since setPoLidoNFT is new in the V2
        address impl = address(uint160(uint256(
            hevm.load(address(transparentProxyTestHarnessV2),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(stMATICV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setPoLidoNFT(address)', a
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }

    function StMATIC_setVersion(string calldata a) public virtual {
        // This function does nothing with the V1, since setVersion is new in the V2
        address impl = address(uint160(uint256(
            hevm.load(address(transparentProxyTestHarnessV2),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(stMATICV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setVersion(string)', a
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }


    /*** Tainted Variables ***/ 

    function StMATIC_nodeOperatorRegistry() public virtual returns (address) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).nodeOperatorRegistry() == IStMATICV2(address(transparentProxyTestHarnessV2)).nodeOperatorRegistry());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).nodeOperatorRegistry();
    }

    function StMATIC_stakeManager() public virtual returns (address) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).stakeManager() == IStMATICV2(address(transparentProxyTestHarnessV2)).stakeManager());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).stakeManager();
    }

    function StMATIC_poLidoNFT() public virtual returns (address) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).poLidoNFT() == IStMATICV2(address(transparentProxyTestHarnessV2)).poLidoNFT());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).poLidoNFT();
    }

    function StMATIC_fxStateRootTunnel() public virtual returns (address) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).fxStateRootTunnel() == IStMATICV2(address(transparentProxyTestHarnessV2)).fxStateRootTunnel());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).fxStateRootTunnel();
    }

    function StMATIC_dao() public virtual returns (address) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).dao() == IStMATICV2(address(transparentProxyTestHarnessV2)).dao());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).dao();
    }

    function StMATIC_insurance() public virtual returns (address) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).insurance() == IStMATICV2(address(transparentProxyTestHarnessV2)).insurance());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).insurance();
    }

    function StMATIC_token() public virtual returns (address) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).token() == IStMATICV2(address(transparentProxyTestHarnessV2)).token());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).token();
    }

    function StMATIC_totalBuffered() public virtual returns (uint256) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).totalBuffered() == IStMATICV2(address(transparentProxyTestHarnessV2)).totalBuffered());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).totalBuffered();
    }

    function StMATIC_reservedFunds() public virtual returns (uint256) {
        assert(IStMATICV1(address(transparentProxyTestHarnessV1)).reservedFunds() == IStMATICV2(address(transparentProxyTestHarnessV2)).reservedFunds());
        return IStMATICV1(address(transparentProxyTestHarnessV1)).reservedFunds();
    }


    /*** Additional Targets ***/ 

}
