// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.6;

import "../../../@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../interfaces/IInternetBondRatioFeed.sol";

contract InternetBondRatioFeed_R2 is
    OwnableUpgradeable,
    IInternetBondRatioFeed
{
    event OperatorAdded(address operator);
    event OperatorRemoved(address operator);

    struct HistoricalRatios {
        uint64[9] historicalRatios;
        uint40 lastUpdate;
    }

    mapping(address => bool) _isOperator;
    mapping(address => uint256) private _ratios;

    mapping(address => HistoricalRatios) public historicalRatios;

    uint32 public constant MAX_THRESHOLD = uint32(1e8); // 100000000

    /// @dev diff between the current ratio and a new one in %(0.000001 ... 100%)
    uint256 private _ratioThreshold;

    function initialize(address operator) public initializer {
        __Ownable_init();
        _isOperator[operator] = true;
    }

    function updateRatioBatch(
        address[] calldata addresses,
        uint256[] calldata ratios
    ) public override onlyOperator {
        require(addresses.length == ratios.length, "corrupted ratio data");
        for (uint256 i = 0; i < addresses.length; i++) {
            HistoricalRatios storage hisRatio = historicalRatios[addresses[i]];

            require(
                _ratioRules(
                    hisRatio.lastUpdate,
                    ratios[i],
                    _ratios[addresses[i]]
                ),
                "new ratio is impossible"
            );

            // let's compare with a new ratio
            _ratios[addresses[i]] = ratios[i];

            if (block.timestamp - hisRatio.lastUpdate > 1 days - 1 minutes) {
                uint64 latestOffset = hisRatio.historicalRatios[0];
                hisRatio.historicalRatios[
                    ((latestOffset + 1) % 8) + 1
                ] = uint64(ratios[i]);
                hisRatio.historicalRatios[0] = latestOffset + 1;
                hisRatio.lastUpdate = uint40(block.timestamp);
            }
        }
    }

    function _ratioRules(
        uint40 lastUpdated,
        uint256 newRatio,
        uint256 oldRatio
    ) internal view returns (bool) {
        require(_ratioThreshold > 0, "ratio threshold is not set");
        require(
            block.timestamp - lastUpdated >= 12 hours,
            "ratio was updated less than 12 hours ago"
        );
        // initialization of the first ratio -> skip checkings
        if (oldRatio == 0) {
            return true;
        }
        // new ratio should be not greater than a previous one
        if (newRatio > oldRatio) {
            return false;
        }
        // new ratio should be in the range (oldRatio - threshold , oldRatio]
        uint256 threshold = (oldRatio * _ratioThreshold) / MAX_THRESHOLD;
        if (newRatio > oldRatio - threshold) {
            return true;
        }

        return false;
    }

    function averagePercentageRate(
        address addr,
        uint256 day
    ) external view returns (uint256) {
        require(day > 0 && day < 8, "day should be from 1 to 7");

        HistoricalRatios storage hisRatio = historicalRatios[addr];
        uint64 latestOffset = hisRatio.historicalRatios[0];

        uint256 oldestRatio = hisRatio.historicalRatios[
            ((latestOffset - day) % 8) + 1
        ];
        uint256 newestRatio = hisRatio.historicalRatios[
            ((latestOffset) % 8) + 1
        ];

        if (oldestRatio < newestRatio) {
            return 0;
        }

        return
            ((oldestRatio - newestRatio) * 10 ** 20 * 365) /
            (oldestRatio * (day));
    }

    function repairRatioFor(address token, uint256 ratio) public onlyOwner {
        require(ratio != 0, "ratio is zero");
        _ratios[token] = ratio;
    }

    function getRatioFor(address token) public view override returns (uint256) {
        return _ratios[token];
    }

    function addOperator(address operator) public onlyOwner {
        require(operator != address(0x0), "operator must be non-zero");
        require(!_isOperator[operator], "already operator");
        _isOperator[operator] = true;
        emit OperatorAdded(operator);
    }

    function removeOperator(address operator) public onlyOwner {
        require(_isOperator[operator], "not an operator");
        delete _isOperator[operator];
        emit OperatorRemoved(operator);
    }

    function setRatioThreshold(uint256 newValue) public onlyOwner {
        require(
            newValue < MAX_THRESHOLD && newValue > 0,
            "wrong value for ratio threshold"
        );
        uint256 oldValue = _ratioThreshold;
        _ratioThreshold = newValue;
        emit RatioThresholdChanged(oldValue, newValue);
    }

    modifier onlyOperator() {
        require(
            msg.sender == owner() || _isOperator[msg.sender],
            "Operator: not allowed"
        );
        _;
    }
}