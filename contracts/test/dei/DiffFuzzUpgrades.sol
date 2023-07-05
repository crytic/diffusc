// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.4;

import { DEIStablecoin as DEIStablecoin_V1 } from "../../implementation/deus/0x1472b3081d81b792e697aea90accbbc4adc5baf9/DEIStablecoin/contracts/LDEI/DEIStablecoin.sol";
import { DEIStablecoin as DEIStablecoin_V2 } from "../../implementation/deus/0xbc1b62db243b51dabcd9540473324f36e094ec55/DEIStablecoin/contracts/LDEI/DEIStablecoin.sol";
import { TransparentProxyTestHarness } from "../../implementation/deus/TransparentProxyTestHarness.sol";

interface IDEIStablecoinV1 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    function lssControllerAdmin() external returns (address);
    function recoveryAdmin() external returns (address);
    function admin() external returns (address);
    function timelockPeriod() external returns (uint256);
    function losslessTurnOffTimestamp() external returns (uint256);
    function isLosslessOn() external returns (bool);
    function lossless() external returns (address);
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function MINTER_ROLE() external returns (bytes32);
    function BURNER_ROLE() external returns (bytes32);
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function transferOutBlacklistedFunds(address[] calldata) external;
    function setLosslessAdmin(address) external;
    function setTimelockPeriod(uint256) external;
    function transferRecoveryAdminOwnership(address,bytes32) external;
    function acceptRecoveryAdminOwnership(bytes memory) external;
    function proposeLosslessTurnOff() external;
    function executeLosslessTurnOff() external;
    function executeLosslessTurnOn() external;
    function getAdmin() external view returns (address);
    function setLssController(address) external;
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
    function initialize(uint256,address,address,uint256,address) external;
    function mint(address,uint256) external;
    function burnFrom(address,uint256) external;
}

interface IDEIStablecoinV2 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    function lssControllerAdmin() external returns (address);
    function recoveryAdmin() external returns (address);
    function admin() external returns (address);
    function timelockPeriod() external returns (uint256);
    function losslessTurnOffTimestamp() external returns (uint256);
    function isLosslessOn() external returns (bool);
    function lossless() external returns (address);
    function DEFAULT_ADMIN_ROLE() external returns (bytes32);
    function MINTER_ROLE() external returns (bytes32);
    function BURNER_ROLE() external returns (bytes32);
    function supportsInterface(bytes4) external view returns (bool);
    function hasRole(bytes32,address) external view returns (bool);
    function getRoleAdmin(bytes32) external view returns (bytes32);
    function grantRole(bytes32,address) external;
    function revokeRole(bytes32,address) external;
    function renounceRole(bytes32,address) external;
    function transferOutBlacklistedFunds(address[] calldata) external;
    function setLosslessAdmin(address) external;
    function setTimelockPeriod(uint256) external;
    function transferRecoveryAdminOwnership(address,bytes32) external;
    function acceptRecoveryAdminOwnership(bytes memory) external;
    function proposeLosslessTurnOff() external;
    function executeLosslessTurnOff() external;
    function executeLosslessTurnOn() external;
    function getAdmin() external view returns (address);
    function setLssController(address) external;
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
    function initialize(uint256,address,address,uint256,address) external;
    function mint(address,uint256) external;
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

    IDEIStablecoinV1 dEIStablecoinV1;
    IDEIStablecoinV2 dEIStablecoinV2;
    ITransparentProxyTestHarness transparentProxyTestHarnessV1;
    ITransparentProxyTestHarness transparentProxyTestHarnessV2;
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    constructor() public {
        dEIStablecoinV1 = IDEIStablecoinV1(address(new DEIStablecoin_V1()));
        dEIStablecoinV2 = IDEIStablecoinV2(address(new DEIStablecoin_V2()));
        transparentProxyTestHarnessV1 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        transparentProxyTestHarnessV2 = ITransparentProxyTestHarness(address(new TransparentProxyTestHarness()));
        // Store the implementation addresses in the proxy.
        hevm.store(
            address(transparentProxyTestHarnessV1),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(dEIStablecoinV1))))
        );
        hevm.store(
            address(transparentProxyTestHarnessV2),
            bytes32(uint(24440054405305269366569402256811496959409073762505157381672968839269610695612)),
            bytes32(uint256(uint160(address(dEIStablecoinV2))))
        );
    }


    /*** All V2 Functions ***/ 

    function DEIStablecoin_getRoleAdmin(bytes32 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getRoleAdmin(bytes32)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_grantRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'grantRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_hasRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'hasRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_renounceRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'renounceRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_revokeRole(bytes32 a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'revokeRole(bytes32,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_supportsInterface(bytes4 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'supportsInterface(bytes4)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_initialize(uint256 a, address b, address c, uint256 d, address e) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'initialize(uint256,address,address,uint256,address)', a, b, c, d, e
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'initialize(uint256,address,address,uint256,address)', a, b, c, d, e
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_mint(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'mint(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_acceptRecoveryAdminOwnership(bytes memory a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'acceptRecoveryAdminOwnership(bytes)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'acceptRecoveryAdminOwnership(bytes)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_allowance(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_approve(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_balanceOf(address a) public virtual {
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

    function DEIStablecoin_burn(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'burn(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_burnFrom(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'burnFrom(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'burnFrom(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_decimals() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_executeLosslessTurnOff() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'executeLosslessTurnOff()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'executeLosslessTurnOff()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_executeLosslessTurnOn() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'executeLosslessTurnOn()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'executeLosslessTurnOn()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_getAdmin() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'getAdmin()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'getAdmin()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_increaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_name() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_proposeLosslessTurnOff() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'proposeLosslessTurnOff()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'proposeLosslessTurnOff()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_setLosslessAdmin(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'setLosslessAdmin(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setLosslessAdmin(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_setLssController(address a) public virtual {
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'setLssController(address)', a
            )
        );
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setLssController(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_setTimelockPeriod(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'setTimelockPeriod(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'setTimelockPeriod(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_symbol() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_totalSupply() public virtual {
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

    function DEIStablecoin_transfer(address a, uint256 b) public virtual {
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

    function DEIStablecoin_transferFrom(address a, address b, uint256 c) public virtual {
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

    function DEIStablecoin_transferOutBlacklistedFunds(address[] calldata a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'transferOutBlacklistedFunds(address[])', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'transferOutBlacklistedFunds(address[])', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function DEIStablecoin_transferRecoveryAdminOwnership(address a, bytes32 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(transparentProxyTestHarnessV1).call(
            abi.encodeWithSignature(
                'transferRecoveryAdminOwnership(address,bytes32)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(transparentProxyTestHarnessV2).call(
            abi.encodeWithSignature(
                'transferRecoveryAdminOwnership(address,bytes32)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** All V2 Public Variables ***/ 


    /*** Tainted Variables ***/ 

    function DEIStablecoin_lssControllerAdmin() public virtual returns (address) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).lssControllerAdmin() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).lssControllerAdmin());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).lssControllerAdmin();
    }

    function DEIStablecoin_recoveryAdmin() public virtual returns (address) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).recoveryAdmin() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).recoveryAdmin());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).recoveryAdmin();
    }

    function DEIStablecoin_admin() public virtual returns (address) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).admin() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).admin());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).admin();
    }

    function DEIStablecoin_timelockPeriod() public virtual returns (uint256) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).timelockPeriod() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).timelockPeriod());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).timelockPeriod();
    }

    function DEIStablecoin_losslessTurnOffTimestamp() public virtual returns (uint256) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).losslessTurnOffTimestamp() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).losslessTurnOffTimestamp());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).losslessTurnOffTimestamp();
    }

    function DEIStablecoin_isLosslessOn() public virtual returns (bool) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).isLosslessOn() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).isLosslessOn());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).isLosslessOn();
    }

    function DEIStablecoin_lossless() public virtual returns (address) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).lossless() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).lossless());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).lossless();
    }

    function DEIStablecoin_DEFAULT_ADMIN_ROLE() public virtual returns (bytes32) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).DEFAULT_ADMIN_ROLE() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).DEFAULT_ADMIN_ROLE());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).DEFAULT_ADMIN_ROLE();
    }

    function DEIStablecoin_MINTER_ROLE() public virtual returns (bytes32) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).MINTER_ROLE() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).MINTER_ROLE());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).MINTER_ROLE();
    }

    function DEIStablecoin_BURNER_ROLE() public virtual returns (bytes32) {
        assert(IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).BURNER_ROLE() == IDEIStablecoinV2(address(transparentProxyTestHarnessV2)).BURNER_ROLE());
        return IDEIStablecoinV1(address(transparentProxyTestHarnessV1)).BURNER_ROLE();
    }


    /*** Additional Targets ***/ 


    /*** Additional Targets ***/ 

}
