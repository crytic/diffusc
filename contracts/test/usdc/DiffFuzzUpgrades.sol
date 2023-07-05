// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.6.12;

pragma experimental ABIEncoderV2;

interface IFiatTokenV2V1 {
    enum AuthorizationState { Unused, Used, Canceled }
    function pauser() external returns (address);
    function paused() external returns (bool);
    function blacklister() external returns (address);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function currency() external returns (string memory);
    function masterMinter() external returns (address);
    function DOMAIN_SEPARATOR() external returns (bytes32);
    function TRANSFER_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function APPROVE_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function INCREASE_ALLOWANCE_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function DECREASE_ALLOWANCE_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function CANCEL_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function PERMIT_TYPEHASH() external returns (bytes32);
    function nonces(address) external view returns (uint256);
    function authorizationState(address,bytes32) external view returns (AuthorizationState);
    function rescuer() external view returns (address);
    function rescueERC20(address,address,uint256) external;
    function updateRescuer(address) external;
    function owner() external view returns (address);
    function transferOwnership(address) external;
    function initialize(string memory,string memory,string memory,uint8,address,address,address,address) external;
    function mint(address,uint256) external returns (bool);
    function minterAllowance(address) external view returns (uint256);
    function isMinter(address) external view returns (bool);
    function allowance(address,address) external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function transfer(address,uint256) external returns (bool);
    function configureMinter(address,uint256) external returns (bool);
    function removeMinter(address) external returns (bool);
    function burn(uint256) external;
    function updateMasterMinter(address) external;
    function isBlacklisted(address) external view returns (bool);
    function blacklist(address) external;
    function unBlacklist(address) external;
    function updateBlacklister(address) external;
    function pause() external;
    function unpause() external;
    function updatePauser(address) external;
    function initializeV2(string calldata) external;
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function transferWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function approveWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function increaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function decreaseAllowanceWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function cancelAuthorization(address,bytes32,uint8,bytes32,bytes32) external;
    function permit(address,address,uint256,uint256,uint8,bytes32,bytes32) external;
}

interface IFiatTokenV2_1V2 {
    function pauser() external returns (address);
    function paused() external returns (bool);
    function blacklister() external returns (address);
    function name() external returns (string memory);
    function symbol() external returns (string memory);
    function decimals() external returns (uint8);
    function currency() external returns (string memory);
    function masterMinter() external returns (address);
    function DOMAIN_SEPARATOR() external returns (bytes32);
    function TRANSFER_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function RECEIVE_WITH_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function CANCEL_AUTHORIZATION_TYPEHASH() external returns (bytes32);
    function PERMIT_TYPEHASH() external returns (bytes32);
    function initializeV2(string calldata) external;
    function increaseAllowance(address,uint256) external returns (bool);
    function decreaseAllowance(address,uint256) external returns (bool);
    function transferWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function receiveWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32) external;
    function cancelAuthorization(address,bytes32,uint8,bytes32,bytes32) external;
    function permit(address,address,uint256,uint256,uint8,bytes32,bytes32) external;
    function nonces(address) external view returns (uint256);
    function authorizationState(address,bytes32) external view returns (bool);
    function rescuer() external view returns (address);
    function rescueERC20(address,address,uint256) external;
    function updateRescuer(address) external;
    function owner() external view returns (address);
    function transferOwnership(address) external;
    function initialize(string memory,string memory,string memory,uint8,address,address,address,address) external;
    function mint(address,uint256) external returns (bool);
    function minterAllowance(address) external view returns (uint256);
    function isMinter(address) external view returns (bool);
    function allowance(address,address) external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function approve(address,uint256) external returns (bool);
    function transferFrom(address,address,uint256) external returns (bool);
    function transfer(address,uint256) external returns (bool);
    function configureMinter(address,uint256) external returns (bool);
    function removeMinter(address) external returns (bool);
    function burn(uint256) external;
    function updateMasterMinter(address) external;
    function isBlacklisted(address) external view returns (bool);
    function blacklist(address) external;
    function unBlacklist(address) external;
    function updateBlacklister(address) external;
    function pause() external;
    function unpause() external;
    function updatePauser(address) external;
    function initializeV2_1(address) external;
    function version() external view returns (string memory);
}

interface IFiatTokenProxy {
    function admin() external view returns (address);
    function implementation() external view returns (address);
    function changeAdmin(address) external;
    function upgradeTo(address) external;
    function upgradeToAndCall(address,bytes memory) external payable;
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

    IFiatTokenV2V1 fiatTokenV2V1;
    IFiatTokenV2_1V2 fiatTokenV21V2;
    IFiatTokenProxy fiatTokenProxy;
    uint256 fork1;
    uint256 fork2;

    event SwitchedFork(uint256 forkId);


    constructor() public {
        hevm.roll(13322797);
        hevm.warp(1632947034);
        fork1 = hevm.createFork();
        fork2 = hevm.createFork();
        fork1 = 1;
        fork2 = 2;
        fiatTokenV2V1 = IFiatTokenV2V1(0xB7277a6e95992041568D9391D09d0122023778A2);
        fiatTokenV21V2 = IFiatTokenV2_1V2(0xa2327a938Febf5FEC13baCFb16Ae10EcBc4cbDCF);
        fiatTokenProxy = IFiatTokenProxy(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
        // Store the implementation addresses in the proxy.
        hevm.selectFork(fork1);
        hevm.store(
            address(fiatTokenProxy),
            bytes32(uint(50801780122331352337026042894847907698553222651959119521779622085092237899971)),
            bytes32(uint256(uint160(address(fiatTokenV2V1))))
        );
        hevm.selectFork(fork2);
        hevm.store(
            address(fiatTokenProxy),
            bytes32(uint(50801780122331352337026042894847907698553222651959119521779622085092237899971)),
            bytes32(uint256(uint160(address(fiatTokenV2V1))))
        );
    }

    /*** Upgrade Function ***/ 

    // TODO: Consider replacing this with the actual upgrade method
    function upgradeV2() external virtual {
        hevm.selectFork(fork2);
        hevm.store(
            address(fiatTokenProxy),
            bytes32(uint(50801780122331352337026042894847907698553222651959119521779622085092237899971)),
            bytes32(uint256(uint160(address(fiatTokenV21V2))))
        );
        hevm.selectFork(fork1);
        bytes32 impl1 = hevm.load(
            address(fiatTokenProxy),
            bytes32(uint(50801780122331352337026042894847907698553222651959119521779622085092237899971))
        );
        bytes32 implV1 = bytes32(uint256(uint160(address(fiatTokenV2V1))));
        assert(impl1 == implV1);
    }


    /*** Modified Functions ***/ 

    function FiatTokenV2_1_initializeV2(string calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'initializeV2(string)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'initializeV2(string)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function FiatTokenV2_1_increaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_transferWithAuthorization(address a, address b, uint256 c, uint256 d, uint256 e, bytes32 f, uint8 g, bytes32 h, bytes32 i) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'transferWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'transferWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_cancelAuthorization(address a, bytes32 b, uint8 c, bytes32 d, bytes32 e) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'cancelAuthorization(address,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'cancelAuthorization(address,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_permit(address a, address b, uint256 c, uint256 d, uint8 e, bytes32 f, bytes32 g) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'permit(address,address,uint256,uint256,uint8,bytes32,bytes32)', a, b, c, d, e, f, g
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_authorizationState(address a, bytes32 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'authorizationState(address,bytes32)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'authorizationState(address,bytes32)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_initialize(string memory a, string memory b, string memory c, uint8 d, address e, address f, address g, address h) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'initialize(string,string,string,uint8,address,address,address,address)', a, b, c, d, e, f, g, h
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'initialize(string,string,string,uint8,address,address,address,address)', a, b, c, d, e, f, g, h
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_mint(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_balanceOf(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_approve(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_transfer(address a, uint256 b) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_burn(uint256 a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_isBlacklisted(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'isBlacklisted(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'isBlacklisted(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_blacklist(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'blacklist(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'blacklist(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_unBlacklist(address a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'unBlacklist(address)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'unBlacklist(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function FiatTokenV2_1_receiveWithAuthorization(address a, address b, uint256 c, uint256 d, uint256 e, bytes32 f, uint8 g, bytes32 h, bytes32 i) public virtual {
        // This function does nothing with the V1, since receiveWithAuthorization is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(fiatTokenProxy),0x7050c9e0f4ca769c69bd3a8ef740bc37934f8e2c036e5a723fd8ee048ed3f8c3)
        )));
        require(impl == address(fiatTokenV21V2));
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'receiveWithAuthorization(address,address,uint256,uint256,uint256,bytes32,uint8,bytes32,bytes32)', a, b, c, d, e, f, g, h, i
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
    // FiatTokenV2_1.initializeV2_1(address)
    // is a new function which appears to replace a function with a similar name,
    // FiatTokenV2.initializeV2(string).
    // If the functions have different arguments this function may be incorrect.
    function FiatTokenV2_1_initializeV2_1(string calldata a) public virtual {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'initializeV2(string)', a
            )
        );
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(fiatTokenProxy),0x7050c9e0f4ca769c69bd3a8ef740bc37934f8e2c036e5a723fd8ee048ed3f8c3)
        )));
        hevm.prank(msg.sender);
        bool successV2;
        bytes memory outputV2;
        if(impl == address(fiatTokenV21V2)) {
            (successV2, outputV2) = address(fiatTokenProxy).call(
                abi.encodeWithSignature(
                        'initializeV2_1(address)', a
                )
            );
        } else {
            (successV2, outputV2) = address(fiatTokenProxy).call(
                abi.encodeWithSignature(
                        'initializeV2(string)', a
                )
            );
        }
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function FiatTokenV2_1_version() public virtual {
        // This function does nothing with the V1, since version is new in the V2
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address impl = address(uint160(uint256(
            hevm.load(address(fiatTokenProxy),0x7050c9e0f4ca769c69bd3a8ef740bc37934f8e2c036e5a723fd8ee048ed3f8c3)
        )));
        require(impl == address(fiatTokenV21V2));
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(fiatTokenProxy).call(
            abi.encodeWithSignature(
                'version()'
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

    function FiatTokenV2_pauser() public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = IFiatTokenV2V1(address(fiatTokenProxy)).pauser();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = IFiatTokenV2_1V2(address(fiatTokenProxy)).pauser();
        assert(a1 == a2);
        return a1;
    }

    function FiatTokenV2_blacklister() public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = IFiatTokenV2V1(address(fiatTokenProxy)).blacklister();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = IFiatTokenV2_1V2(address(fiatTokenProxy)).blacklister();
        assert(a1 == a2);
        return a1;
    }

    function FiatTokenV2_decimals() public virtual returns (uint8) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        uint8 a1 = IFiatTokenV2V1(address(fiatTokenProxy)).decimals();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        uint8 a2 = IFiatTokenV2_1V2(address(fiatTokenProxy)).decimals();
        assert(a1 == a2);
        return a1;
    }

    function FiatTokenV2_masterMinter() public virtual returns (address) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        address a1 = IFiatTokenV2V1(address(fiatTokenProxy)).masterMinter();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        address a2 = IFiatTokenV2_1V2(address(fiatTokenProxy)).masterMinter();
        assert(a1 == a2);
        return a1;
    }

    function FiatTokenV2_DOMAIN_SEPARATOR() public virtual returns (bytes32) {
        hevm.selectFork(fork1);
        emit SwitchedFork(fork1);
        bytes32 a1 = IFiatTokenV2V1(address(fiatTokenProxy)).DOMAIN_SEPARATOR();
        hevm.selectFork(fork2);
        emit SwitchedFork(fork2);
        bytes32 a2 = IFiatTokenV2_1V2(address(fiatTokenProxy)).DOMAIN_SEPARATOR();
        assert(a1 == a2);
        return a1;
    }


    /*** Additional Targets ***/ 

}
