pragma solidity ^0.8.2;

import "./SimplePriceOracle.sol";
import "./token/MarketToken.sol";

contract ContractV2 {
    address admin;                      // Used for protected functions
    MarketToken mToken;                 // Used for additional targets
    SimplePriceOracle oracle;           // Used for additional targets
    uint public stateA = 0;             // Untainted public state variable
    uint public stateB = 0;             // Tainted public state variable
    uint constant CONST = 32;           // Constants should not be wrapped
    bool bug = false;                   // Tainted private variable should not be wrapped
    mapping(uint => uint) public mapB;  // Tainted public mapping should be wrapped with uint arg
    address[] public callers;           // Tainted public array should be wrapped with uint arg
    uint public stateC = 0;             // New public variable, only included in interface

    // @notice Functions with this modifier should only be wrapped if `-P --protected` flag is set
    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    // @notice Untainted function
    function setA(uint x) public {
        if (msg.sender == admin) {
            stateA = x;
        }
    }

    // @notice Modified function gets an extra statement (line 34)
    function setB(uint y) public {
        if (stateA % CONST == 1) {
            mapB[y] = 10;
            callers.push(msg.sender);
            stateB = y + mapB[y];
        }
    }

    // @notice Modified function has changed binary operation (was `stateB == 62`)
    function checkB() public {
        if (stateB == 32) {
            bug = true;
        }
    }

    // @notice Completely new function, only included in interface
    function incrementC() public {
        stateC = stateC + 1;
    }

    // @notice Tainted protected function should only be wrapped if `-P --protected` flag is set
    function setMap(uint x, uint y) public onlyAdmin {
        mapB[x] = y;
    }

    // @notice Modified function uses new `balance`, `balanceUnderlying` signatures with args
    function totalValue() public returns (uint256) {
        return balance(address(this)) * price() + balanceUnderlying(address(this)) * underlyingPrice();
    }

    // @notice Replaced `balance()` from V1, and includes cross-contract call
    function balance(address holder) public returns (uint256) {
        return mToken.balanceOf(holder);
    }

    // @notice Replaced `balanceUnderlying()` from V1, and includes cross-contract call
    // @notice Call to underlying ERC20 induces taint outside of provided targets
    function balanceUnderlying(address holder) public returns (uint256) {
        return mToken.underlying().balanceOf(holder);
    }

    // @notice Tainted function called by `totalValue()`, includes cross-contract call
    function price() internal returns (uint256) {
        return oracle.assetPrices(address(mToken));
    }

    // @notice Tainted function called by `totalValue()`, includes cross-contract call
    function underlyingPrice() internal returns (uint256) {
        return oracle.getUnderlyingPrice(mToken);
    }
}
