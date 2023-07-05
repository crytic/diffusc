// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.9;

interface IFortaStakingV1 {
    struct Balances {
        mapping(uint256 => uint256) _balances;
        uint256 _totalSupply;
    }
    struct SignedBalances {
        mapping(address => int256) _balances;
        int256 _totalSupply;
    }
    struct Timestamp {
        uint64 _deadline;
    }
    function stakedToken() external returns (address);
    function version() external returns (string memory);
    function totalSupply(uint256) external view returns (uint256);
    function exists(uint256) external view returns (bool);
    function supportsInterface(bytes4) external view returns (bool);
    function uri(uint256) external view returns (string memory);
    function balanceOf(address,uint256) external view returns (uint256);
    function balanceOfBatch(address[] memory,uint256[] memory) external view returns (uint256[] memory);
    function setApprovalForAll(address,bool) external;
    function isApprovedForAll(address,address) external view returns (bool);
    function safeTransferFrom(address,address,uint256,uint256,bytes memory) external;
    function safeBatchTransferFrom(address,address,uint256[] memory,uint256[] memory,bytes memory) external;
    function setName(address,string calldata) external;
    function upgradeTo(address) external;
    function upgradeToAndCall(address,bytes memory) external payable;
    function multicall(bytes[] calldata) external returns (bytes[] memory);
    function setRouter(address) external;
    function setAccessManager(address) external;
    function isTrustedForwarder(address) external view returns (bool);
    function initialize(address,address,address,uint64,address) external;
    function activeStakeFor(uint8,uint256) external view returns (uint256);
    function totalActiveStake() external view returns (uint256);
    function inactiveStakeFor(uint8,uint256) external view returns (uint256);
    function totalInactiveStake() external view returns (uint256);
    function sharesOf(uint8,uint256,address) external view returns (uint256);
    function totalShares(uint8,uint256) external view returns (uint256);
    function inactiveSharesOf(uint8,uint256,address) external view returns (uint256);
    function totalInactiveShares(uint8,uint256) external view returns (uint256);
    function isFrozen(uint8,uint256) external view returns (bool);
    function deposit(uint8,uint256,uint256) external returns (uint256);
    function initiateWithdrawal(uint8,uint256,uint256) external returns (uint64);
    function withdraw(uint8,uint256) external returns (uint256);
    function slash(uint8,uint256,uint256) external returns (uint256);
    function freeze(uint8,uint256,bool) external;
    function reward(uint8,uint256,uint256) external;
    function sweep(address,address) external returns (uint256);
    function releaseReward(uint8,uint256,address) external returns (uint256);
    function availableReward(uint8,uint256,address) external view returns (uint256);
    function relayPermit(uint256,uint256,uint8,bytes32,bytes32) external;
    function setDelay(uint64) external;
    function setTreasury(address) external;
    function setStakingParametersManager(address) external;
    function setURI(string memory) external;
}

interface IFortaStakingV2 {
    struct Balances {
        mapping(uint256 => uint256) _balances;
        uint256 _totalSupply;
    }
    struct SignedBalances {
        mapping(address => int256) _balances;
        int256 _totalSupply;
    }
    struct Timestamp {
        uint64 _deadline;
    }
    function stakedToken() external returns (address);
    function MIN_WITHDRAWAL_DELAY() external returns (uint256);
    function MAX_WITHDRAWAL_DELAY() external returns (uint256);
    function version() external returns (string memory);
    function totalSupply(uint256) external view returns (uint256);
    function exists(uint256) external view returns (bool);
    function supportsInterface(bytes4) external view returns (bool);
    function uri(uint256) external view returns (string memory);
    function balanceOf(address,uint256) external view returns (uint256);
    function balanceOfBatch(address[] memory,uint256[] memory) external view returns (uint256[] memory);
    function setApprovalForAll(address,bool) external;
    function isApprovedForAll(address,address) external view returns (bool);
    function safeTransferFrom(address,address,uint256,uint256,bytes memory) external;
    function safeBatchTransferFrom(address,address,uint256[] memory,uint256[] memory,bytes memory) external;
    function setName(address,string calldata) external;
    function proxiableUUID() external view returns (bytes32);
    function upgradeTo(address) external;
    function upgradeToAndCall(address,bytes memory) external payable;
    function multicall(bytes[] calldata) external returns (bytes[] memory);
    function setRouter(address) external;
    function setAccessManager(address) external;
    function isTrustedForwarder(address) external view returns (bool);
    function initialize(address,address,uint64,address,address) external;
    function treasury() external view returns (address);
    function activeStakeFor(uint8,uint256) external view returns (uint256);
    function totalActiveStake() external view returns (uint256);
    function inactiveStakeFor(uint8,uint256) external view returns (uint256);
    function totalInactiveStake() external view returns (uint256);
    function sharesOf(uint8,uint256,address) external view returns (uint256);
    function totalShares(uint8,uint256) external view returns (uint256);
    function inactiveSharesOf(uint8,uint256,address) external view returns (uint256);
    function totalInactiveShares(uint8,uint256) external view returns (uint256);
    function isFrozen(uint8,uint256) external view returns (bool);
    function deposit(uint8,uint256,uint256) external returns (uint256);
    function initiateWithdrawal(uint8,uint256,uint256) external returns (uint64);
    function withdraw(uint8,uint256) external returns (uint256);
    function slash(uint8,uint256,uint256,address,uint256) external returns (uint256);
    function freeze(uint8,uint256,bool) external;
    function reward(uint8,uint256,uint256) external;
    function sweep(address,address) external returns (uint256);
    function releaseReward(uint8,uint256,address) external returns (uint256);
    function availableReward(uint8,uint256,address) external view returns (uint256);
    function relayPermit(uint256,uint256,uint8,bytes32,bytes32) external;
    function stakeToActiveShares(uint256,uint256) external view returns (uint256);
    function stakeToInactiveShares(uint256,uint256) external view returns (uint256);
    function activeSharesToStake(uint256,uint256) external view returns (uint256);
    function inactiveSharesToStake(uint256,uint256) external view returns (uint256);
    function setDelay(uint64) external;
    function setTreasury(address) external;
    function setStakingParametersManager(address) external;
    function setURI(string memory) external;
}

interface IFortaBridgedPolygon {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct Checkpoint {
        uint32 fromBlock;
        uint224 votes;
    }
    struct Counter {
        uint256 _value;
    }
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function ADMIN_ROLE() external returns (bytes32);
    function WHITELISTER_ROLE() external returns (bytes32);
    function WHITELIST_ROLE() external returns (bytes32);
    function whitelistDisabled() external returns (bool);
    function childChainManagerProxy() external returns (address);
    function grantWhitelister(address) external;
    function setName(address,string calldata) external;
    function disableWhitelist() external;
    function enableWhitelist() external;
    function upgradeTo(address) external;
    function upgradeToAndCall(address,bytes memory) external payable;
    function checkpoints(address,uint32) external view returns (Checkpoint memory);
    function numCheckpoints(address) external view returns (uint32);
    function delegates(address) external view returns (address);
    function getVotes(address) external view returns (uint256);
    function getPastVotes(address,uint256) external view returns (uint256);
    function getPastTotalSupply(uint256) external view returns (uint256);
    function delegate(address) external;
    function delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32) external;
    function permit(address,address,uint256,uint256,uint8,bytes32,bytes32) external;
    function nonces(address) external view returns (uint256);
    function DOMAIN_SEPARATOR() external view returns (bytes32);
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
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function initialize(address) external;
    function deposit(address,bytes calldata) external;
    function withdraw(uint256) external;
    function withdrawTo(uint256,address) external;
    function version() external pure returns (string memory);
}

interface IERC1967Proxy {
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

    IFortaStakingV1 fortaStakingV1;
    IFortaStakingV2 fortaStakingV2;
    IERC1967Proxy eRC1967Proxy;
    IFortaBridgedPolygon fortaBridgedPolygon;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);

    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    struct Checkpoint {
        uint32 fromBlock;
        uint224 votes;
    }

    constructor() public {
        hevm.roll(34754728);
        hevm.warp(1666643161);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        fortaStakingV1 = IFortaStakingV1(0x62FCaA1eDA3bcf18133510e52D28C8B79C912734);
        fortaStakingV2 = IFortaStakingV2(0xD6eBEbD5B165b56E2F55F69D70F414B8aDc2696d);
        eRC1967Proxy = IERC1967Proxy(0xd2863157539b1D11F39ce23fC4834B62082F6874);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(eRC1967Proxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(fortaStakingV1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(eRC1967Proxy),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(fortaStakingV2))))
        );
        fortaBridgedPolygon = IFortaBridgedPolygon(0x9ff62d1FC52A907B6DCbA8077c2DDCA6E6a9d3e1);
    }


    /*** Modified Functions ***/ 

    function FortaStaking_setDelay(uint64 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setDelay(uint64)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setDelay(uint64)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function FortaStaking_totalSupply(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'totalSupply(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'totalSupply(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_exists(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'exists(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'exists(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_uri(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'uri(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'uri(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_balanceOf(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'balanceOf(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'balanceOf(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_balanceOfBatch(address[] memory a, uint256[] memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'balanceOfBatch(address[],uint256[])', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'balanceOfBatch(address[],uint256[])', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_safeTransferFrom(address a, address b, uint256 c, uint256 d, bytes memory e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'safeTransferFrom(address,address,uint256,uint256,bytes)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'safeTransferFrom(address,address,uint256,uint256,bytes)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_safeBatchTransferFrom(address a, address b, uint256[] memory c, uint256[] memory d, bytes memory e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'safeBatchTransferFrom(address,address,uint256[],uint256[],bytes)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'safeBatchTransferFrom(address,address,uint256[],uint256[],bytes)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_setName(address a, string memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setName(address,string)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setName(address,string)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_upgradeTo(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'upgradeTo(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'upgradeTo(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_upgradeToAndCall(address a, bytes memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'upgradeToAndCall(address,bytes)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'upgradeToAndCall(address,bytes)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_setRouter(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setRouter(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setRouter(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_setAccessManager(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setAccessManager(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setAccessManager(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_sharesOf(uint8 a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'sharesOf(uint8,uint256,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'sharesOf(uint8,uint256,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_totalShares(uint8 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'totalShares(uint8,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'totalShares(uint8,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_inactiveSharesOf(uint8 a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'inactiveSharesOf(uint8,uint256,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'inactiveSharesOf(uint8,uint256,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_totalInactiveShares(uint8 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'totalInactiveShares(uint8,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'totalInactiveShares(uint8,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_deposit(uint8 a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'deposit(uint8,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'deposit(uint8,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_initiateWithdrawal(uint8 a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'initiateWithdrawal(uint8,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'initiateWithdrawal(uint8,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_withdraw(uint8 a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'withdraw(uint8,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'withdraw(uint8,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_freeze(uint8 a, uint256 b, bool c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'freeze(uint8,uint256,bool)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'freeze(uint8,uint256,bool)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_reward(uint8 a, uint256 b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'reward(uint8,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'reward(uint8,uint256,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_sweep(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'sweep(IERC20,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'sweep(IERC20,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_releaseReward(uint8 a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'releaseReward(uint8,uint256,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'releaseReward(uint8,uint256,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_availableReward(uint8 a, uint256 b, address c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'availableReward(uint8,uint256,address)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'availableReward(uint8,uint256,address)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_relayPermit(uint256 a, uint256 b, uint8 c, bytes32 d, bytes32 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'relayPermit(uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'relayPermit(uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_setTreasury(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setTreasury(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setTreasury(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_setStakingParametersManager(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setStakingParametersManager(IStakeController)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setStakingParametersManager(IStakeController)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_setURI(string memory a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setURI(string)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'setURI(string)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    // TODO: Double-check this function for correctness
    // FortaStaking.slash(uint8,uint256,uint256,address,uint256)
    // is a new function which appears to replace a function with a similar name,
    // FortaStaking.slash(uint8,uint256,uint256).
    // If the functions have different arguments this function may be incorrect.
    function FortaStaking_slash(uint8 a, uint256 b, uint256 c, address d, uint256 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'slash(uint8,uint256,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        bool successV2;
        bytes memory outputV2;
        if(impl == address(fortaStakingV2)) {
            (successV2, outputV2) = address(eRC1967Proxy).call(
                abi.encodeWithSignature(
                        'slash(uint8,uint256,uint256,address,uint256)', a, b, c, d, e
                )
            );
        } else {
            (successV2, outputV2) = address(eRC1967Proxy).call(
                abi.encodeWithSignature(
                        'slash(uint8,uint256,uint256)', a, b, c
                )
            );
        }
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_treasury() public virtual {
        // This function does nothing with the V1, since treasury is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(fortaStakingV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'treasury()'
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

    function FortaStaking_proxiableUUID() public virtual {
        // This function does nothing with the V1, since proxiableUUID is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(fortaStakingV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'proxiableUUID()'
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
    // FortaStaking.initialize(address,address,uint64,address,address)
    // is a new function which appears to replace a function with a similar name,
    // FortaStaking.initialize(address,address,IERC20,uint64,address).
    // If the functions have different arguments this function may be incorrect.
    function FortaStaking_initialize(address a, address b, address c, uint64 d, address e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'initialize(address,address,IERC20,uint64,address)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        hevm.prank(msg.sender);
        bool successV2;
        bytes memory outputV2;
        if(impl == address(fortaStakingV2)) {
            (successV2, outputV2) = address(eRC1967Proxy).call(
                abi.encodeWithSignature(
                        'initialize(address,address,uint64,address,address)', a, b, c, d, e
                )
            );
        } else {
            (successV2, outputV2) = address(eRC1967Proxy).call(
                abi.encodeWithSignature(
                        'initialize(address,address,IERC20,uint64,address)', a, b, c, d, e
                )
            );
        }
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaStaking_stakeToActiveShares(uint256 a, uint256 b) public virtual {
        // This function does nothing with the V1, since stakeToActiveShares is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(fortaStakingV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'stakeToActiveShares(uint256,uint256)', a, b
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

    function FortaStaking_stakeToInactiveShares(uint256 a, uint256 b) public virtual {
        // This function does nothing with the V1, since stakeToInactiveShares is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(fortaStakingV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'stakeToInactiveShares(uint256,uint256)', a, b
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

    function FortaStaking_activeSharesToStake(uint256 a, uint256 b) public virtual {
        // This function does nothing with the V1, since activeSharesToStake is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(fortaStakingV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'activeSharesToStake(uint256,uint256)', a, b
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

    function FortaStaking_inactiveSharesToStake(uint256 a, uint256 b) public virtual {
        // This function does nothing with the V1, since inactiveSharesToStake is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(eRC1967Proxy),0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)
        )));
        require(impl == address(fortaStakingV2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(eRC1967Proxy).call(
            abi.encodeWithSignature(
                'inactiveSharesToStake(uint256,uint256)', a, b
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

    function FortaStaking_stakedToken() public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = IFortaStakingV1(address(eRC1967Proxy)).stakedToken();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = IFortaStakingV2(address(eRC1967Proxy)).stakedToken();
        assert(a1 == a2);
        return a1;
    }


    /*** Additional Targets ***/ 

    function FortaBridgedPolygon_DOMAIN_SEPARATOR() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'DOMAIN_SEPARATOR()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'DOMAIN_SEPARATOR()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_allowance(address a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_checkpoints(address a, uint32 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'checkpoints(address,uint32)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'checkpoints(address,uint32)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_decimals() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_delegate(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'delegate(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'delegate(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_delegateBySig(address a, uint256 b, uint256 c, uint8 d, bytes32 e, bytes32 f) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_delegates(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'delegates(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'delegates(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_deposit(address a, bytes memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'deposit(address,bytes)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'deposit(address,bytes)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_disableWhitelist() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'disableWhitelist()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'disableWhitelist()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_enableWhitelist() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'enableWhitelist()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'enableWhitelist()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_getPastTotalSupply(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getPastTotalSupply(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getPastTotalSupply(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_getPastVotes(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getPastVotes(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getPastVotes(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_getRoleAdmin(bytes32 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_getVotes(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getVotes(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'getVotes(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_grantRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_grantWhitelister(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'grantWhitelister(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'grantWhitelister(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_hasRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_increaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_initialize(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'initialize(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'initialize(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_name() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_nonces(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'nonces(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'nonces(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_numCheckpoints(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'numCheckpoints(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'numCheckpoints(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_permit(address a, address b, uint256 c, uint256 d, uint8 e, bytes32 f, bytes32 g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_renounceRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_revokeRole(bytes32 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_setName(address a, string memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'setName(address,string)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'setName(address,string)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_supportsInterface(bytes4 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_symbol() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_totalSupply() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_upgradeTo(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'upgradeTo(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'upgradeTo(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_upgradeToAndCall(address a, bytes memory b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'upgradeToAndCall(address,bytes)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'upgradeToAndCall(address,bytes)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_version() public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'version()'
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'version()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_withdraw(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'withdraw(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'withdraw(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FortaBridgedPolygon_withdrawTo(uint256 a, address b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'withdrawTo(uint256,address)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fortaBridgedPolygon).call(
            abi.encodeWithSignature(
                'withdrawTo(uint256,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
