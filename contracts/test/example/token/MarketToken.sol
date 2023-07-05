pragma solidity ^0.8.0;

import "./ERC20/ERC20.sol";

contract MarketToken is ERC20 {
    ERC20 public underlying;

    constructor(address _underlying, string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        underlying = ERC20(_underlying);
    }

    function mint(uint256 _amount) public { }
    function redeem(uint256 _amount) public { }
    function borrow(uint256 _amount) public { }
    function underlyingBalance(address _holder) public returns (uint256) {
        return underlying.balanceOf(_holder);
    }
}