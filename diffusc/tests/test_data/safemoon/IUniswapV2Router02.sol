// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.11;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function routerTrade() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
    );

}

interface IUniswapV2Router02 is IUniswapV2Router01 {
}
