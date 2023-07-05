// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.11;

import "./Initializable.sol";
import "./SafeswapERC20.sol";
import "./ISafeswapPair.sol";
import "./IERC20.sol";

library UQ112x112 {
    uint224 constant Q112 = 2**112;

    // encode a uint112 as a UQ112x112
    function encode(uint112 y) internal pure returns (uint224 z) {
        z = uint224(y) * Q112; // never overflows
    }

    // divide a UQ112x112 by a uint112, returning a UQ112x112
    function uqdiv(uint224 x, uint112 y) internal pure returns (uint224 z) {
        z = x / uint224(y);
    }
}

library Math {
    function min(uint x, uint y) internal pure returns (uint z) {
        z = x < y ? x : y;
    }

    // babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}

interface ISafeswapCallee {
    function safeswapCall(address sender, uint amount0, uint amount1, bytes calldata data) external;
}

interface ISafeswapRouter {
    function getTokenDeduction(address token, uint256 amount) external view returns (uint256, address);
}

interface ISafeswapFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint256 length);

    function feeTo() external view returns (address);

    function router() external view returns (address);
    
    function implementation() external view returns (address);

    function feeToSetter() external view returns (address);

    function isBlacklistedStatus(address account) external view returns (bool);

    function approvePartnerStatus(address account) external view returns (bool);

    function isBlacklistedToken(address account) external view returns (bool);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(
        address tokenA,
        address tokenB,
        address to
    ) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

//    function getFeeConfig() external view returns (FeeConfig memory);
//
//    function getTotalFee() external view returns (uint256, uint256);
//
//    struct FeeConfig {
//        address feeTo;
//        address buyBackWallet;
//        uint256 companyFeePercent;
//        uint256 buyBackFeePercent;
//        uint256 lpFeePercent;
//        uint256 precision;
//    }
}

contract SafeswapPair is ISafeswapPair, SafeswapERC20, Initializable {
    using UQ112x112 for uint224;

    uint256 public constant MINIMUM_LIQUIDITY = 10**3;
    bytes4 private constant SELECTOR = bytes4(keccak256(bytes("transfer(address,uint256)")));

    address public factory;
    address public token0;
    address public token1;
    // address public router;

    uint112 private reserve0; // uses single storage slot, accessible via getReserves
    uint112 private reserve1; // uses single storage slot, accessible via getReserves
    uint32 private blockTimestampLast; // uses single storage slot, accessible via getReserves

    uint256 public price0CumulativeLast;
    uint256 public price1CumulativeLast;
    uint256 public kLast; // reserve0 * reserve1, as of immediately after the most recent liquidity event

    uint256 private unlocked = 1;
    modifier lock() {
        require(unlocked == 1, "Safeswap: LOCKED");
        unlocked = 0;
        _;
        unlocked = 1;
    }

    modifier onlyRouter() {
        require(msg.sender == ISafeswapFactory(factory).router(), "Safeswap: ONLY_ROUTER");
        _;
    }

    function getReserves()
        public
        view
        returns (
            uint112 _reserve0,
            uint112 _reserve1,
            uint32 _blockTimestampLast
        )
    {
        _reserve0 = reserve0;
        _reserve1 = reserve1;
        _blockTimestampLast = blockTimestampLast;
    }

    function _safeTransfer(
        address token,
        address to,
        uint256 value
    ) private {
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(SELECTOR, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), "Safeswap: TRANSFER_FAILED");
    }

    function _transferSTPtaxFees(address token, uint256 amount) internal {
        address router = ISafeswapFactory(factory).router();
        (uint256 deduction, address to) = ISafeswapRouter(router).getTokenDeduction(token, amount);
        if (deduction > 0 && to != address(0)) {
            _safeTransfer(token, to, deduction);
        }
    }

    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );

    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external initializer {
        factory = msg.sender;
        token0 = _token0;
        token1 = _token1;
        _SafeswapERC20_init_();
        unlocked = 1;
    }

    // update reserves and, on the first call per block, price accumulators
    function _update(
        uint256 balance0,
        uint256 balance1,
        uint112 _reserve0,
        uint112 _reserve1
    ) private {
        require(balance0 <= type(uint112).max && balance1 <= type(uint112).max, "Safeswap: OVERFLOW");
        uint32 blockTimestamp = uint32(block.timestamp % 2**32);
        uint32 timeElapsed = blockTimestamp - blockTimestampLast; // overflow is desired
        if (timeElapsed > 0 && _reserve0 != 0 && _reserve1 != 0) {
            // * never overflows, and + overflow is desired
            price0CumulativeLast += uint256(UQ112x112.encode(_reserve1).uqdiv(_reserve0)) * timeElapsed;
            price1CumulativeLast += uint256(UQ112x112.encode(_reserve0).uqdiv(_reserve1)) * timeElapsed;
        }
        reserve0 = uint112(balance0);
        reserve1 = uint112(balance1);
        blockTimestampLast = blockTimestamp;
        emit Sync(reserve0, reserve1);
    }

    function _takeFee(
        address token,
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) private returns (uint256 _fee) {
        require(token == token0 || token == token1, "Safeswap: INVALID_TOKEN");
        address feeTo = ISafeswapFactory(factory).feeTo();
        uint256 _totalSupply = totalSupply;

        bool feeOn = feeTo != address(0);
        uint256 amountOutWithoutFee = (amountOut * 10000) / 9975;
        //uint FeeSTP = amountOutWithoutFee.mul(100) / 10000;
        uint256 burnFee = (amountOutWithoutFee * 3) / 10000;
        uint256 supportFee = (amountOutWithoutFee * 5) / 10000;

        uint256 numerator = reserveIn * burnFee;
        uint256 denominator = reserveOut - burnFee;
        uint256 amountIn = numerator / denominator;

        uint256 liquidity = Math.min((amountIn * _totalSupply) / reserveIn, (burnFee * _totalSupply) / reserveOut);
        _mint(0x000000000000000000000000000000000000dEaD, liquidity);
        _fee = burnFee;

        if (feeOn) {
            numerator = reserveIn * supportFee;
            denominator = reserveOut - supportFee;
            amountIn = numerator / denominator;

            liquidity = Math.min((amountIn * _totalSupply) / reserveIn, (supportFee * _totalSupply) / reserveOut);
            _mint(feeTo, liquidity);
            _fee = _fee + supportFee;
            //_safeTransfer(token0, 0x6B6003F0F3E7C9F096813b5c4F0F6DA9FD8D24Ba, FeeSTP);
        }
    }

    // if fee is on, mint liquidity equivalent to 1/6th of the growth in sqrt(k)
    function _mintFee(uint112 _reserve0, uint112 _reserve1) private returns (bool feeOn) {
        address feeTo = ISafeswapFactory(factory).feeTo();
        feeOn = feeTo != address(0);
        uint256 _kLast = kLast; // gas savings
        if (feeOn) {
            if (_kLast != 0) {
                uint256 rootK = Math.sqrt(uint256(_reserve0) * _reserve1);
                uint256 rootKLast = Math.sqrt(_kLast);
                if (rootK > rootKLast) {
                    uint256 numerator = totalSupply * (rootK - rootKLast);
                    uint256 denominator = rootK * 3 + rootKLast;
                    uint256 liquidity = numerator / denominator;
                    if (liquidity > 0) _mint(feeTo, liquidity);
                }
            }
        } else if (_kLast != 0) {
            kLast = 0;
        }
    }

    // this low-level function should be called from a contract which performs important safety checks
    function mint(address to) external lock returns (uint256 liquidity) {
        require(ISafeswapFactory(factory).isBlacklistedStatus(to) == false, "Address is blacklisted");
        (uint112 _reserve0, uint112 _reserve1, ) = getReserves(); // gas savings
        uint256 balance0 = IERC20(token0).balanceOf(address(this));
        uint256 balance1 = IERC20(token1).balanceOf(address(this));
        uint256 amount0 = balance0 - _reserve0;
        uint256 amount1 = balance1 - _reserve1;

        bool feeOn = _mintFee(_reserve0, _reserve1);
        uint256 _totalSupply = totalSupply; // gas savings, must be defined here since totalSupply can update in _mintFee
        if (_totalSupply == 0) {
            liquidity = Math.sqrt(amount0 * amount1) - MINIMUM_LIQUIDITY;
            _mint(address(0), MINIMUM_LIQUIDITY); // permanently lock the first MINIMUM_LIQUIDITY tokens
        } else {
            liquidity = Math.min((amount0 * _totalSupply) / _reserve0, (amount1 * _totalSupply) / _reserve1);
        }
        require(liquidity > 0, "Safeswap: INSUFFICIENT_LIQUIDITY_MINTED");
        _mint(to, liquidity);

        _update(balance0, balance1, _reserve0, _reserve1);
        if (feeOn) kLast = uint256(reserve0) * reserve1; // reserve0 and reserve1 are up-to-date
        emit Mint(msg.sender, amount0, amount1);
    }

    // this low-level function should be called from a contract which performs important safety checks
    function burn(address to) external lock returns (uint256 amount0, uint256 amount1) {
        require(ISafeswapFactory(factory).isBlacklistedStatus(to) == false, "Address is blacklisted");
        (uint112 _reserve0, uint112 _reserve1, ) = getReserves(); // gas savings
        address _token0 = token0; // gas savings
        address _token1 = token1; // gas savings
        uint256 balance0 = IERC20(_token0).balanceOf(address(this));
        uint256 balance1 = IERC20(_token1).balanceOf(address(this));
        uint256 liquidity = balanceOf[address(this)];

        bool feeOn = _mintFee(_reserve0, _reserve1);
        uint256 _totalSupply = totalSupply; // gas savings, must be defined here since totalSupply can update in _mintFee
        amount0 = (liquidity * balance0) / _totalSupply; // using balances ensures pro-rata distribution
        amount1 = (liquidity * balance1) / _totalSupply; // using balances ensures pro-rata distribution
        require(amount0 > 0 && amount1 > 0, "Safeswap: INSUFFICIENT_LIQUIDITY_BURNED");
        _burn(address(this), liquidity);
        _safeTransfer(_token0, to, amount0);
        _safeTransfer(_token1, to, amount1);
        balance0 = IERC20(_token0).balanceOf(address(this));
        balance1 = IERC20(_token1).balanceOf(address(this));

        _update(balance0, balance1, _reserve0, _reserve1);
        if (feeOn) kLast = uint256(reserve0) * reserve1; // reserve0 and reserve1 are up-to-date
        emit Burn(msg.sender, amount0, amount1, to);
    }

    // this low-level function should be called from a contract which performs important safety checks
    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external lock onlyRouter {
        require(ISafeswapFactory(factory).isBlacklistedStatus(to) == false, "Address is blacklisted");
        require(amount0Out > 0 || amount1Out > 0, "Safeswap: INSUFFICIENT_OUTPUT_AMOUNT");
        (uint112 _reserve0, uint112 _reserve1, ) = getReserves(); // gas savings
        require(amount0Out < _reserve0 && amount1Out < _reserve1, "Safeswap: INSUFFICIENT_LIQUIDITY");

        uint256 balance0;
        uint256 balance1;
        {
            // scope for _token{0,1}, avoids stack too deep errors
            address _token0 = token0;
            address _token1 = token1;
            require(to != _token0 && to != _token1, "Safeswap: INVALID_TO");
            if (amount0Out > 0) {
                // _takeFee(_token0, amount0Out, _reserve1, reserve0);
                _safeTransfer(_token0, to, amount0Out);
            } // optimistically transfer tokens
            if (amount1Out > 0) {
                // _takeFee(_token1, amount1Out, _reserve0, _reserve1);
                _safeTransfer(_token1, to, amount1Out);
            } // optimistically transfer tokens
            if (data.length > 0) ISafeswapCallee(to).safeswapCall(msg.sender, amount0Out, amount1Out, data);
            if (amount0Out > 0) {
                _transferSTPtaxFees(token0, amount0Out);
            }
            if (amount1Out > 0) {
                _transferSTPtaxFees(token1, amount1Out);
            }
            balance0 = IERC20(_token0).balanceOf(address(this));
            balance1 = IERC20(_token1).balanceOf(address(this));
        }
        uint256 amount0In = balance0 > _reserve0 - amount0Out ? balance0 - (_reserve0 - amount0Out) : 0;
        uint256 amount1In = balance1 > _reserve1 - amount1Out ? balance1 - (_reserve1 - amount1Out) : 0;
        require(amount0In > 0 || amount1In > 0, "Safeswap: INSUFFICIENT_INPUT_AMOUNT");
        {
            // scope for reserve{0,1}Adjusted, avoids stack too deep errors
            uint256 balance0Adjusted = balance0 * 1000 - amount0In * 2;
            uint256 balance1Adjusted = balance1 * 1000 - amount1In * 2;
            require(balance0Adjusted * balance1Adjusted >= uint256(_reserve0) * _reserve1 * (1000**2), "Safeswap: K");
        }

        _update(balance0, balance1, _reserve0, _reserve1);
        emit Swap(msg.sender, amount0In, amount1In, amount0Out, amount1Out, to);
    }

    // force balances to match reserves
    function skim(address to) external lock {
        address _token0 = token0; // gas savings
        address _token1 = token1; // gas savings
        _safeTransfer(_token0, to, IERC20(_token0).balanceOf(address(this)) - reserve0);
        _safeTransfer(_token1, to, IERC20(_token1).balanceOf(address(this)) - reserve1);
    }

    // force reserves to match balances
    function sync() external lock {
        _update(IERC20(token0).balanceOf(address(this)), IERC20(token1).balanceOf(address(this)), reserve0, reserve1);
    }
}