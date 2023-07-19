// SPDX-License-Identifier: AGPLv3
pragma solidity >=0.8.2;

import { ContractV1 as ContractV1_V1 } from "../ContractV1.sol";
import { ContractV2 as ContractV2_V2 } from "../ContractV2.sol";
import { MarketToken } from "../token/MarketToken.sol";
import { SimplePriceOracle } from "../SimplePriceOracle.sol";

interface IContractV1V1 {
    function stateA() external returns (uint256);
    function stateB() external returns (uint256);
    function mapB(uint256) external returns (uint256);
    function callers(uint256) external returns (address);
    function f(uint256) external;
    function g(uint256) external;
    function h() external;
    function setMap(uint256,uint256) external;
    function totalValue() external returns (uint256);
    function balance() external returns (uint256);
    function balanceUnderlying() external returns (uint256);
}

interface IContractV2V2 {
    function stateA() external returns (uint256);
    function stateB() external returns (uint256);
    function mapB(uint256) external returns (uint256);
    function callers(uint256) external returns (address);
    function stateC() external returns (uint256);
    function f(uint256) external;
    function g(uint256) external;
    function h() external;
    function i() external;
    function j() external;
    function setMap(uint256,uint256) external;
    function totalValue() external returns (uint256);
    function balance(address) external returns (uint256);
    function balanceUnderlying(address) external returns (uint256);
}

interface IMarketToken {
    function underlying() external returns (address);
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
    function mint(uint256) external;
    function redeem(uint256) external;
    function borrow(uint256) external;
    function underlyingBalance(address) external returns (uint256);
}

interface ISimplePriceOracle {
    function getUnderlyingPrice(address) external view returns (uint256);
    function setUnderlyingPrice(address,uint256) external;
    function setDirectPrice(address,uint256) external;
    function assetPrices(address) external view returns (uint256);
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

    IContractV1V1 contractV1V1;
    IContractV2V2 contractV2V2;
    IMarketToken marketTokenV1;
    IMarketToken marketTokenV2;
    ISimplePriceOracle simplePriceOracleV1;
    ISimplePriceOracle simplePriceOracleV2;

    constructor() public {
        contractV1V1 = IContractV1V1(address(new ContractV1_V1()));
        contractV2V2 = IContractV2V2(address(new ContractV2_V2()));
        marketTokenV1 = IMarketToken(address(new MarketToken()));
        marketTokenV2 = IMarketToken(address(new MarketToken()));
        simplePriceOracleV1 = ISimplePriceOracle(address(new SimplePriceOracle()));
        simplePriceOracleV2 = ISimplePriceOracle(address(new SimplePriceOracle()));
    }


    /*** Modified Functions ***/ 

    function ContractV2_g(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(contractV1V1).call(
            abi.encodeWithSignature(
                'g(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(contractV2V2).call(
            abi.encodeWithSignature(
                'g(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ContractV2_totalValue() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(contractV1V1).call(
            abi.encodeWithSignature(
                'totalValue()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(contractV2V2).call(
            abi.encodeWithSignature(
                'totalValue()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Functions ***/ 

    function ContractV2_h() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(contractV1V1).call(
            abi.encodeWithSignature(
                'h()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(contractV2V2).call(
            abi.encodeWithSignature(
                'h()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** New Functions ***/ 

    function ContractV2_i() public virtual {
        // This function does nothing with the V1, since i is new in the V2
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(contractV2V2).call(
            abi.encodeWithSignature(
                'i()'
            )
        );
        // Never fail assertion, since there is nothing to compare
        assert(true);
    }

    // TODO: Double-check this function for correctness
    // ContractV2.balance(address)
    // is a new function which appears to replace a function with a similar name,
    // ContractV1.balance().
    // If the functions have different arguments this function may be incorrect.
    function ContractV2_balance(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(contractV1V1).call(
            abi.encodeWithSignature(
                'balance()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(contractV2V2).call(
            abi.encodeWithSignature(
                'balance(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    // TODO: Double-check this function for correctness
    // ContractV2.balanceUnderlying(address)
    // is a new function which appears to replace a function with a similar name,
    // ContractV1.balanceUnderlying().
    // If the functions have different arguments this function may be incorrect.
    function ContractV2_balanceUnderlying(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(contractV1V1).call(
            abi.encodeWithSignature(
                'balanceUnderlying()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(contractV2V2).call(
            abi.encodeWithSignature(
                'balanceUnderlying(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }


    /*** Tainted Variables ***/ 

    function ContractV1_stateB() public virtual returns (uint256) {
        assert(contractV1V1.stateB() == contractV2V2.stateB());
        return contractV1V1.stateB();
    }

    function ContractV1_mapB(uint256 a) public virtual returns (uint256) {
        assert(contractV1V1.mapB(a) == contractV2V2.mapB(a));
        return contractV1V1.mapB(a);
    }

    function ContractV1_callers(uint i) public virtual returns (address) {
        assert(contractV1V1.callers(i) == contractV2V2.callers(i));
        return contractV1V1.callers(i);
    }


    /*** Additional Targets ***/ 

    function MarketToken_allowance(address a, address b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'allowance(address,address)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_approve(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'approve(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_balanceOf(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'balanceOf(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_borrow(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'borrow(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'borrow(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_decimals() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'decimals()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_decreaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'decreaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_increaseAllowance(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'increaseAllowance(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_mint(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'mint(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'mint(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_name() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'name()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_redeem(uint256 a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'redeem(uint256)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'redeem(uint256)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_symbol() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'symbol()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_totalSupply() public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_transfer(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'transfer(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_transferFrom(address a, address b, uint256 c) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'transferFrom(address,address,uint256)', a, b, c
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function MarketToken_underlyingBalance(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(marketTokenV1).call(
            abi.encodeWithSignature(
                'underlyingBalance(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(marketTokenV2).call(
            abi.encodeWithSignature(
                'underlyingBalance(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SimplePriceOracle_assetPrices(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(simplePriceOracleV1).call(
            abi.encodeWithSignature(
                'assetPrices(address)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(simplePriceOracleV2).call(
            abi.encodeWithSignature(
                'assetPrices(address)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SimplePriceOracle_getUnderlyingPrice(address a) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(simplePriceOracleV1).call(
            abi.encodeWithSignature(
                'getUnderlyingPrice(MarketToken)', a
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(simplePriceOracleV2).call(
            abi.encodeWithSignature(
                'getUnderlyingPrice(MarketToken)', a
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SimplePriceOracle_setDirectPrice(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(simplePriceOracleV1).call(
            abi.encodeWithSignature(
                'setDirectPrice(address,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(simplePriceOracleV2).call(
            abi.encodeWithSignature(
                'setDirectPrice(address,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function SimplePriceOracle_setUnderlyingPrice(address a, uint256 b) public virtual {
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(simplePriceOracleV1).call(
            abi.encodeWithSignature(
                'setUnderlyingPrice(MarketToken,uint256)', a, b
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(simplePriceOracleV2).call(
            abi.encodeWithSignature(
                'setUnderlyingPrice(MarketToken,uint256)', a, b
            )
        );
        assert(successV1 == successV2); 
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

}
