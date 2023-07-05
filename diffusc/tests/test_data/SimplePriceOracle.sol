// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.10;

import "./token/MarketToken.sol";

contract SimplePriceOracle {
    mapping(address => uint) prices;

    function _getUnderlyingAddress(MarketToken mToken) private view returns (address) {
        address asset;
        if (compareStrings(mToken.symbol(), "cETH")) {
            asset = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
        } else {
            asset = address(mToken.underlying());
        }
        return asset;
    }

    function getUnderlyingPrice(MarketToken mToken) public view returns (uint) {
        return prices[_getUnderlyingAddress(mToken)];
    }

    function setUnderlyingPrice(MarketToken mToken, uint underlyingPrice) public {
        address asset = _getUnderlyingAddress(mToken);
        prices[asset] = underlyingPrice;
    }

    function setDirectPrice(address asset, uint price) public {
        prices[asset] = price;
    }

    // v1 price oracle interface for use as backing of proxy
    function assetPrices(address asset) external view returns (uint) {
        return prices[asset];
    }

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
}
