pragma solidity ^0.5.16;

import "./Comptroller.sol";
import "./PriceOracle.sol";

contract ComptrollerHarness is Comptroller {
    address compAddress;
    uint public blockNumber;

    constructor() Comptroller() public {}

    function setPauseGuardian(address harnessedPauseGuardian) public {
        pauseGuardian = harnessedPauseGuardian;
    }

    function setCompSupplyState(address cToken, uint224 index, uint32 blockNumber_) public {
        compSupplyState[cToken].index = index;
        compSupplyState[cToken].block = blockNumber_;
    }

    function setCompBorrowState(address cToken, uint224 index, uint32 blockNumber_) public {
        compBorrowState[cToken].index = index;
        compBorrowState[cToken].block = blockNumber_;
    }

    function setCompAccrued(address user, uint userAccrued) public {
        compAccrued[user] = userAccrued;
    }

    function setCompAddress(address compAddress_) public {
        compAddress = compAddress_;
    }

    function getCompAddress() public view returns (address) {
        return compAddress;
    }

    /**
     * @notice Set the amount of COMP distributed per block
     * @param compRate_ The amount of COMP wei per block to distribute
     */
    function harnessSetCompRate(uint compRate_) public {
        compRate = compRate_;
    }

    /**
     * @notice Recalculate and update COMP speeds for all COMP markets
     */
    function harnessRefreshCompSpeeds() public {
        CToken[] memory allMarkets_ = allMarkets;

        for (uint i = 0; i < allMarkets_.length; i++) {
            CToken cToken = allMarkets_[i];
            Exp memory borrowIndex = Exp({mantissa: cToken.borrowIndex()});
            updateCompSupplyIndex(address(cToken));
            updateCompBorrowIndex(address(cToken), borrowIndex);
        }

        Exp memory totalUtility = Exp({mantissa: 0});
        Exp[] memory utilities = new Exp[](allMarkets_.length);
        for (uint i = 0; i < allMarkets_.length; i++) {
            CToken cToken = allMarkets_[i];
            if (compSupplySpeeds[address(cToken)] > 0 || compBorrowSpeeds[address(cToken)] > 0) {
                Exp memory assetPrice = Exp({mantissa: oracle.getUnderlyingPrice(cToken)});
                Exp memory utility = mul_(assetPrice, cToken.totalBorrows());
                utilities[i] = utility;
                totalUtility = add_(totalUtility, utility);
            }
        }

        for (uint i = 0; i < allMarkets_.length; i++) {
            CToken cToken = allMarkets[i];
            uint newSpeed = totalUtility.mantissa > 0 ? mul_(compRate, div_(utilities[i], totalUtility)) : 0;
            setCompSpeedInternal(cToken, newSpeed, newSpeed);
        }
    }

    function setCompBorrowerIndex(address cToken, address borrower, uint index) public {
        compBorrowerIndex[cToken][borrower] = index;
    }

    function setCompSupplierIndex(address cToken, address supplier, uint index) public {
        compSupplierIndex[cToken][supplier] = index;
    }

    function harnessDistributeAllBorrowerComp(address cToken, address borrower, uint marketBorrowIndexMantissa) public {
        distributeBorrowerComp(cToken, borrower, Exp({mantissa: marketBorrowIndexMantissa}));
        compAccrued[borrower] = grantCompInternal(borrower, compAccrued[borrower]);
    }

    function harnessDistributeAllSupplierComp(address cToken, address supplier) public {
        distributeSupplierComp(cToken, supplier);
        compAccrued[supplier] = grantCompInternal(supplier, compAccrued[supplier]);
    }

    function harnessUpdateCompBorrowIndex(address cToken, uint marketBorrowIndexMantissa) public {
        updateCompBorrowIndex(cToken, Exp({mantissa: marketBorrowIndexMantissa}));
    }

    function harnessUpdateCompSupplyIndex(address cToken) public {
        updateCompSupplyIndex(cToken);
    }

    function harnessDistributeBorrowerComp(address cToken, address borrower, uint marketBorrowIndexMantissa) public {
        distributeBorrowerComp(cToken, borrower, Exp({mantissa: marketBorrowIndexMantissa}));
    }

    function harnessDistributeSupplierComp(address cToken, address supplier) public {
        distributeSupplierComp(cToken, supplier);
    }

    function harnessTransferComp(address user, uint userAccrued, uint threshold) public returns (uint) {
        if (userAccrued > 0 && userAccrued >= threshold) {
            return grantCompInternal(user, userAccrued);
        }
        return userAccrued;
    }

    function harnessAddCompMarkets(address[] memory cTokens) public {
        for (uint i = 0; i < cTokens.length; i++) {
            // temporarily set compSpeed to 1 (will be fixed by `harnessRefreshCompSpeeds`)
            setCompSpeedInternal(CToken(cTokens[i]), 1, 1);
        }
    }

    function harnessFastForward(uint blocks) public returns (uint) {
        blockNumber += blocks;
        return blockNumber;
    }

    function setBlockNumber(uint number) public {
        blockNumber = number;
    }

    function getBlockNumber() public view returns (uint) {
        return blockNumber;
    }

    function getCompMarkets() public view returns (address[] memory) {
        uint m = allMarkets.length;
        uint n = 0;
        for (uint i = 0; i < m; i++) {
            if (compSupplySpeeds[address(allMarkets[i])] > 0 || compBorrowSpeeds[address(allMarkets[i])] > 0) {
                n++;
            }
        }

        address[] memory compMarkets = new address[](n);
        uint k = 0;
        for (uint i = 0; i < m; i++) {
            if (compSupplySpeeds[address(allMarkets[i])] > 0 || compBorrowSpeeds[address(allMarkets[i])] > 0) {
                compMarkets[k++] = address(allMarkets[i]);
            }
        }
        return compMarkets;
    }
}