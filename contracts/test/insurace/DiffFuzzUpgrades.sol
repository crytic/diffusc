// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.7.3;

pragma experimental ABIEncoderV2;

interface IStakersPoolV2V1 {
    function securityMatrix() external returns (address);
    function insurTokenAddress() external returns (address);
    function stakedAmountPT(address) external returns (uint256);
    function poolLastCalcBlock(address) external returns (uint256);
    function poolWeightPT(address) external returns (uint256);
    function totalPoolWeight() external returns (uint256);
    function poolRewardPerLPToken(address) external returns (uint256);
    function rewardStartBlock() external returns (uint256);
    function rewardEndBlock() external returns (uint256);
    function rewardPerBlock() external returns (uint256);
    function stkRewardsPerAPerLPT(address,address) external returns (uint256);
    function harvestedRewardsPerAPerLPT(address,address) external returns (uint256);
    function paused() external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initializeStakersPoolV2() external;
    function setup(address,address) external;
    function setPoolWeight(address,uint256,address[] memory) external;
    function setRewardInfo(uint256,uint256,uint256,address[] memory) external;
    function reCalcPoolPT(address) external;
    function showPendingRewards(address,address) external view returns (uint256);
    function settlePendingRewards(address,address) external;
    function showHarvestRewards(address,address) external view returns (uint256);
    function harvestRewards(address,address,address) external returns (uint256);
    function getPoolRewardPerLPToken(address) external view returns (uint256);
    function addStkAmount(address,uint256) external payable;
    function getStakedAmountPT(address) external view returns (uint256);
    function withdrawTokens(address,uint256,address,address,uint256) external;
    function claimPayout(address,address,uint256,address,uint256,uint256,uint256) external;
}

interface IStakersPoolV2V2 {
    function securityMatrix() external returns (address);
    function insurTokenAddress() external returns (address);
    function stakedAmountPT(address) external returns (uint256);
    function poolLastCalcBlock(address) external returns (uint256);
    function poolWeightPT(address) external returns (uint256);
    function totalPoolWeight() external returns (uint256);
    function poolRewardPerLPToken(address) external returns (uint256);
    function rewardStartBlock() external returns (uint256);
    function rewardEndBlock() external returns (uint256);
    function rewardPerBlock() external returns (uint256);
    function stkRewardsPerAPerLPT(address,address) external returns (uint256);
    function harvestedRewardsPerAPerLPT(address,address) external returns (uint256);
    function signerFlagMap(address) external returns (bool);
    function nonceFlagMap(uint256) external returns (bool);
    function paused() external view returns (bool);
    function owner() external view returns (address);
    function renounceOwnership() external;
    function transferOwnership(address) external;
    function initializeStakersPoolV2() external;
    function setup(address,address) external;
    function setPoolWeight(address,uint256,address[] memory) external;
    function setRewardInfo(uint256,uint256,uint256,address[] memory) external;
    function reCalcPoolPT(address) external;
    function showPendingRewards(address,address) external view returns (uint256);
    function settlePendingRewards(address,address) external;
    function showHarvestRewards(address,address) external view returns (uint256);
    function harvestRewards(address,address,address) external returns (uint256);
    function getPoolRewardPerLPToken(address) external view returns (uint256);
    function addStkAmount(address,uint256) external payable;
    function getStakedAmountPT(address) external view returns (uint256);
    function withdrawTokens(address,uint256,address,address,uint256) external;
    function claimPayout(address,address,uint256,address,uint256,uint256,uint256) external;
    function getRewardToken() external view returns (address);
    function getRewardPerBlockPerPool(address) external view returns (uint256);
    function rebalancePools(uint256,address[] memory,uint256[] memory,uint256,uint8[] memory,bytes32[] memory,bytes32[] memory) external;
    function setStakersPoolSigner(address,bool) external;
}

interface IInsurAceToken {
    struct RoleData {
        AddressSet members;
        bytes32 adminRole;
    }
    struct Checkpoint {
        uint256 fromBlock;
        uint256 votes;
    }
    struct AddressSet {
        Set _inner;
    }
    struct Set {
        bytes32[] _values;
        mapping(bytes32 => uint256) _indexes;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function MINTER_ROLE() external returns (bytes32);
    function PAUSER_ROLE() external returns (bytes32);
    function transferFromAllowedList(address) external returns (uint256);
    function membersFrom(uint256) external returns (address);
    function delegates(address) external returns (address);
    function numCheckpoints(address) external returns (uint256);
    function checkpoints(address,uint256) external returns (Checkpoint memory);
    function hackerList(address) external returns (uint256);
    function initialize(string memory,string memory) external;
    function mint(address,uint256) external;
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
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
    function burn(uint256) external;
    function burnFrom(address,uint256) external;
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleMemberCount(bytes32) external view returns (uint256);
    function getRoleMember(bytes32,uint256) external view returns (address);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initializeINSUR() external;
    function addSender(address) external;
    function addHacker(address) external;
    function removeHacker(address) external;
    function getSenders() external view returns (address[] memory);
    function removeSender(address) external;
    function delegate(address) external;
    function getPriorVotes(address,uint256) external view returns (uint256);
}

interface IAdminUpgradeabilityProxy {
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

    IStakersPoolV2V1 stakersPoolV2V1;
    IStakersPoolV2V2 stakersPoolV2V2;
    IAdminUpgradeabilityProxy adminUpgradeabilityProxy;
    IInsurAceToken insurAceToken;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

    struct RoleData {
        AddressSet members;
        bytes32 adminRole;
    }
    struct Checkpoint {
        uint256 fromBlock;
        uint256 votes;
    }
    struct AddressSet {
        Set _inner;
    }
    struct Set {
        bytes32[] _values;
        mapping(bytes32 => uint256) _indexes;
    }

    constructor() public {
        hevm.roll(14478265);
        hevm.warp(1648518770);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        stakersPoolV2V1 = IStakersPoolV2V1(0xA237a4E37c90E87C41B534a03Ccd8Daaf85Bd14E);
        stakersPoolV2V2 = IStakersPoolV2V2(0xA03d480cd2E10Ad36ED098898357DBe4C349fB02);
        adminUpgradeabilityProxy = IAdminUpgradeabilityProxy(0x136D841d4beCe3Fc0E4dEbb94356D8b6B4b93209);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(adminUpgradeabilityProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(stakersPoolV2V1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(adminUpgradeabilityProxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(stakersPoolV2V2))))
        );
        insurAceToken = IInsurAceToken(0x544c42fBB96B39B21DF61cf322b5EDC285EE7429);
    }


    /*** Modified Functions ***/ 


    /*** Tainted Functions ***/ 

    function StakersPoolV2_reCalcPoolPT(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'reCalcPoolPT(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'reCalcPoolPT(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StakersPoolV2_showPendingRewards(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'showPendingRewards(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'showPendingRewards(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StakersPoolV2_settlePendingRewards(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'settlePendingRewards(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'settlePendingRewards(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function StakersPoolV2_getPoolRewardPerLPToken(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'getPoolRewardPerLPToken(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'getPoolRewardPerLPToken(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function StakersPoolV2_getRewardToken() public virtual {
        // This function does nothing with the V1, since getRewardToken is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(adminUpgradeabilityProxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(stakersPoolV2V2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'getRewardToken()'
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

    function StakersPoolV2_getRewardPerBlockPerPool(address a) public virtual {
        // This function does nothing with the V1, since getRewardPerBlockPerPool is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(adminUpgradeabilityProxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(stakersPoolV2V2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'getRewardPerBlockPerPool(address)', a
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

    function StakersPoolV2_rebalancePools(uint256 a, address[] memory b, uint256[] memory c, uint256 d, uint8[] memory e, bytes32[] memory f, bytes32[] memory g) public virtual {
        // This function does nothing with the V1, since rebalancePools is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(adminUpgradeabilityProxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(stakersPoolV2V2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(adminUpgradeabilityProxy).call(
            abi.encodeWithSignature(
                'rebalancePools(uint256,address[],uint256[],uint256,uint8[],bytes32[],bytes32[])', a, b, c, d, e, f, g
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

    function StakersPoolV2_poolLastCalcBlock(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IStakersPoolV2V1(address(adminUpgradeabilityProxy)).poolLastCalcBlock(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IStakersPoolV2V2(address(adminUpgradeabilityProxy)).poolLastCalcBlock(a);
        assert(a1 == a2);
        return a1;
    }

    function StakersPoolV2_poolWeightPT(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IStakersPoolV2V1(address(adminUpgradeabilityProxy)).poolWeightPT(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IStakersPoolV2V2(address(adminUpgradeabilityProxy)).poolWeightPT(a);
        assert(a1 == a2);
        return a1;
    }

    function StakersPoolV2_totalPoolWeight() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IStakersPoolV2V1(address(adminUpgradeabilityProxy)).totalPoolWeight();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IStakersPoolV2V2(address(adminUpgradeabilityProxy)).totalPoolWeight();
        assert(a1 == a2);
        return a1;
    }

    function StakersPoolV2_poolRewardPerLPToken(address a) public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IStakersPoolV2V1(address(adminUpgradeabilityProxy)).poolRewardPerLPToken(a);
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IStakersPoolV2V2(address(adminUpgradeabilityProxy)).poolRewardPerLPToken(a);
        assert(a1 == a2);
        return a1;
    }

    function StakersPoolV2_rewardStartBlock() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IStakersPoolV2V1(address(adminUpgradeabilityProxy)).rewardStartBlock();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IStakersPoolV2V2(address(adminUpgradeabilityProxy)).rewardStartBlock();
        assert(a1 == a2);
        return a1;
    }

    function StakersPoolV2_rewardEndBlock() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IStakersPoolV2V1(address(adminUpgradeabilityProxy)).rewardEndBlock();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IStakersPoolV2V2(address(adminUpgradeabilityProxy)).rewardEndBlock();
        assert(a1 == a2);
        return a1;
    }

    function StakersPoolV2_rewardPerBlock() public virtual returns (uint256) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint256 a1 = IStakersPoolV2V1(address(adminUpgradeabilityProxy)).rewardPerBlock();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint256 a2 = IStakersPoolV2V2(address(adminUpgradeabilityProxy)).rewardPerBlock();
        assert(a1 == a2);
        return a1;
    }


    /*** Additional Targets ***/ 

    function InsurAceToken_allowance(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_burn(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_burnFrom(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'burnFrom(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'burnFrom(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_decimals() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_delegate(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'delegate(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'delegate(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_getPriorVotes(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getPriorVotes(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getPriorVotes(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_getRoleAdmin(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_getRoleMember(bytes32 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getRoleMember(bytes32,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getRoleMember(bytes32,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_getRoleMemberCount(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getRoleMemberCount(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'getRoleMemberCount(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_grantRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_hasRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_increaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_initialize(string memory a, string memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'initialize(string,string)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'initialize(string,string)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_initializeINSUR() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'initializeINSUR()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'initializeINSUR()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_mint(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_name() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_pause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'pause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_paused() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'paused()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_renounceRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_revokeRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_symbol() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_totalSupply() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function InsurAceToken_unpause() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(insurAceToken).call(
            abi.encodeWithSignature(
                'unpause()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
