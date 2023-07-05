// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.16;

import "../@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "../@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "../interface/ICertToken.sol";
import "../interface/ITokenHub.sol";
import "../interface/IBondToken_R1.sol";
import "../interface/IBinancePool_R4.sol";

contract BinancePool_R9 is
    PausableUpgradeable,
    ReentrancyGuardUpgradeable,
    OwnableUpgradeable,
    IBinancePool_R4
{
    /**
     * Variables
     */

    uint256 private _minimumStake;
    uint256 private _expireTime;
    uint256 private _pendingGap;

    address private _operator;
    address private _intermediary;
    address private _bondContract;

    address[] private _pendingClaimers;
    mapping(address => uint256) public pendingClaimerUnstakes;

    ITokenHub private _tokenHub;

    uint256 public stashedForManualDistributes;
    mapping(uint256 => bool) public markedForManualDistribute;

    address private _certContract;

    mapping(address => bool) private _claimersForManualDistribute;

    uint256 private _DISTRIBUTE_GAS_LEFT;

    uint256 public failedStakesAmount;

    modifier onlyOperator() {
        require(msg.sender == _operator, "sender is not an operator");
        _;
    }

    modifier badClaimer() {
        require(
            !_claimersForManualDistribute[msg.sender],
            "the address has a request for manual distribution"
        );
        _;
    }

    function initialize(
        address operator,
        address bcOperator,
        address tokenHubAddress,
        uint64 expireTime
    ) public initializer {
        __Pausable_init();
        __ReentrancyGuard_init();
        __Ownable_init();
        _operator = operator;
        _intermediary = bcOperator;
        _expireTime = expireTime;
        _minimumStake = 1e18;
        _tokenHub = ITokenHub(tokenHubAddress);
    }

    function stake() external payable override nonReentrant {
        _stake();
        emit isRebasing(true);
    }

    function stakeAndClaimBonds() external payable override nonReentrant {
        _stake();
        emit isRebasing(true);
    }

    function stakeAndClaimBondsWithCode(uint256 code)
        external
        payable
        override
        nonReentrant
    {
        _stake();
        emit ReferralCode(code);
        emit isRebasing(true);
    }

    function stakeAndClaimCerts() external payable override nonReentrant {
        uint256 realAmount = _stake();
        IBondToken_R1(_bondContract).unlockSharesFor(msg.sender, realAmount);
        emit isRebasing(false);
    }

    function stakeAndClaimCertsWithCode(uint256 code)
        external
        payable
        override
        nonReentrant
    {
        uint256 realAmount = _stake();
        IBondToken_R1(_bondContract).unlockSharesFor(msg.sender, realAmount);
        emit ReferralCode(code);
        emit isRebasing(false);
    }

    function _stake() private returns (uint256) {
        uint256 relayerFee = _tokenHub.getMiniRelayFee();
        require(
            msg.value - relayerFee >= _minimumStake,
            "value must be greater than min stake amount"
        );
        uint256 realAmount = msg.value - relayerFee;
        uint64 expireTime = uint64(block.timestamp + _expireTime);
        // executes transferOut of TokenHub
        require(
            _tokenHub.transferOut{value: msg.value}(
                address(0x0),
                _intermediary,
                realAmount,
                expireTime
            ),
            "could not transferOut"
        );
        /* mint Internet Bonds for user */
        IBondToken_R1(_bondContract).mintBonds(msg.sender, realAmount);
        emit Staked(msg.sender, _intermediary, realAmount);
        return realAmount;
    }

    function unstake(uint256 amount) external override badClaimer nonReentrant {
        require(
            amount >= _minimumStake,
            "value must be greater than min unstake amount"
        );
        require(
            ICertToken(_bondContract).balanceOf(msg.sender) >= amount,
            "cannot unstake more than have on address"
        );
        if (pendingClaimerUnstakes[msg.sender] == 0) {
            _pendingClaimers.push(msg.sender);
        }
        pendingClaimerUnstakes[msg.sender] += amount;
        IBondToken_R1(_bondContract).burnAndSetPending(msg.sender, amount);
        emit UnstakePending(msg.sender, amount);
        emit isRebasing(true);
    }

    function unstakeBonds(uint256 amount)
        external
        override
        badClaimer
        nonReentrant
    {
        require(
            amount >= _minimumStake,
            "value must be greater than min unstake amount"
        );
        require(
            ICertToken(_bondContract).balanceOf(msg.sender) >= amount,
            "cannot unstake more than have on address"
        );
        if (pendingClaimerUnstakes[msg.sender] == 0) {
            _pendingClaimers.push(msg.sender);
        }
        pendingClaimerUnstakes[msg.sender] += amount;
        IBondToken_R1(_bondContract).burnAndSetPending(msg.sender, amount);
        emit UnstakePending(msg.sender, amount);
        emit isRebasing(true);
    }

    function unstakeBondsFor(address recipient, uint256 amount)
        external
        override
        badClaimer
        nonReentrant
    {
        require(
            !_claimersForManualDistribute[recipient],
            "recipient has a request for manual distribution"
        );
        require(
            amount >= _minimumStake,
            "value must be greater than min unstake amount"
        );
        require(
            ICertToken(_bondContract).balanceOf(msg.sender) >= amount,
            "cannot unstake more than have on address"
        );
        if (pendingClaimerUnstakes[recipient] == 0) {
            _pendingClaimers.push(recipient);
        }
        pendingClaimerUnstakes[recipient] += amount;
        IBondToken_R1(_bondContract).burnAndSetPendingFor(
            msg.sender,
            recipient,
            amount
        );
        emit UnstakePending(recipient, amount);
        emit isRebasing(true);
    }

    function unstakeCerts(uint256 shares)
        external
        override
        badClaimer
        nonReentrant
    {
        uint256 amount = IBondToken_R1(_bondContract).sharesToBonds(shares);
        require(
            amount >= _minimumStake,
            "value must be greater than min unstake amount"
        );
        require(
            ICertToken(_certContract).balanceWithRewardsOf(msg.sender) >=
                amount,
            "cannot unstake more than have on address"
        );
        if (pendingClaimerUnstakes[msg.sender] == 0) {
            _pendingClaimers.push(msg.sender);
        }
        pendingClaimerUnstakes[msg.sender] += amount;
        IBondToken_R1(_bondContract).transferAndLockShares(msg.sender, shares);
        IBondToken_R1(_bondContract).burnAndSetPending(msg.sender, amount);
        emit UnstakePending(msg.sender, amount);
        emit isRebasing(false);
    }

    function unstakeCertsFor(address recipient, uint256 shares)
        external
        override
        badClaimer
        nonReentrant
    {
        require(
            !_claimersForManualDistribute[recipient],
            "recipient has a request for manual distribution"
        );
        uint256 amount = IBondToken_R1(_bondContract).sharesToBonds(shares);
        require(
            amount >= _minimumStake,
            "value must be greater than min unstake amount"
        );
        require(
            ICertToken(_certContract).balanceWithRewardsOf(msg.sender) >=
                amount,
            "cannot unstake more than have on address"
        );
        if (pendingClaimerUnstakes[recipient] == 0) {
            _pendingClaimers.push(recipient);
        }
        pendingClaimerUnstakes[recipient] += amount;
        IBondToken_R1(_bondContract).transferAndLockShares(msg.sender, shares);
        IBondToken_R1(_bondContract).burnAndSetPendingFor(
            msg.sender,
            recipient,
            amount
        );
        emit UnstakePending(recipient, amount);
        emit isRebasing(false);
    }

    function distributeRewards() external payable override nonReentrant {
        uint256 poolBalance = address(this).balance -
            stashedForManualDistributes;
        require(
            poolBalance >= _minimumStake,
            "must be greater than min unstake amount"
        );
        address[] memory claimers = new address[](
            _pendingClaimers.length - _pendingGap
        );
        uint256[] memory amounts = new uint256[](
            _pendingClaimers.length - _pendingGap
        );
        uint256 j = 0;
        uint256 gaps = 0;
        uint256 i = _pendingGap;
        while (
            i < _pendingClaimers.length &&
            poolBalance > 0 &&
            gasleft() > _DISTRIBUTE_GAS_LEFT
        ) {
            address claimer = _pendingClaimers[i];
            if (_claimersForManualDistribute[claimer]) {
                i++;
                continue;
            }
            uint256 toDistribute = pendingClaimerUnstakes[claimer];
            /* we might have gaps lets just skip them (we shrink them on full claim) */
            if (claimer == address(0) || toDistribute == 0) {
                i++;
                gaps++;
                continue;
            }
            if (poolBalance < toDistribute) {
                toDistribute = poolBalance;
            }
            address payable wallet = payable(address(claimer));
            bool success;
            assembly {
                success := call(10000, wallet, toDistribute, 0, 0, 0, 0)
            }
            /* when we delete items from array we generate new gap, lets remember how many gaps we did to skip them in next claim */
            if (!success) {
                gaps++;
                markedForManualDistribute[i] = true;
                _claimersForManualDistribute[claimer] = true;
                toDistribute = pendingClaimerUnstakes[claimer];
                stashedForManualDistributes += toDistribute;
                emit ManualDistributeExpected(claimer, toDistribute, i);
                i++;
                continue;
            }
            claimers[j] = claimer;
            amounts[j] = toDistribute;
            IBondToken_R1(_bondContract).updatePendingBurning(
                claimer,
                toDistribute
            );
            poolBalance -= toDistribute;
            pendingClaimerUnstakes[claimer] -= toDistribute;
            j++;
            if (pendingClaimerUnstakes[claimer] != 0) {
                break;
            }
            delete _pendingClaimers[i];
            i++;
            gaps++;
        }
        _pendingGap += gaps;
        /* decrease arrays */
        uint256 removeCells = claimers.length - j;
        if (removeCells > 0) {
            assembly {
                mstore(claimers, j)
            }
            assembly {
                mstore(amounts, j)
            }
        }
        emit RewardsDistributed(claimers, amounts, 0);
    }

    function distributeManual(uint256 id) external override nonReentrant {
        require(
            markedForManualDistribute[id],
            "not marked for manual distributing"
        );
        address[] memory claimers = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        address claimer = _pendingClaimers[id];
        address payable wallet = payable(claimer);
        uint256 amount = pendingClaimerUnstakes[claimer];

        require(
            address(this).balance >= stashedForManualDistributes,
            "insufficient pool balance"
        );

        markedForManualDistribute[id] = false;
        _claimersForManualDistribute[claimer] = false;
        stashedForManualDistributes -= amount;

        claimers[0] = claimer;
        amounts[0] = amount;
        IBondToken_R1(_bondContract).updatePendingBurning(claimer, amount);
        pendingClaimerUnstakes[claimer] = 0;

        (bool result, ) = wallet.call{value: amount}("");
        require(result, "failed to send rewards to claimer");
        delete _pendingClaimers[id];

        emit RewardsDistributed(claimers, amounts, 0);
    }

    function pendingUnstakesOf(address claimer)
        external
        view
        override
        returns (uint256)
    {
        return pendingClaimerUnstakes[claimer];
    }

    function pendingGap() public view returns (uint256) {
        return _pendingGap;
    }

    function calcPendingGap() external onlyOwner {
        uint256 gaps = 0;
        for (uint256 i = 0; i < _pendingClaimers.length; i++) {
            address claimer = _pendingClaimers[i];
            if (
                claimer != address(0) && !_claimersForManualDistribute[claimer]
            ) {
                break;
            }
            gaps++;
        }
        _pendingGap = gaps;
    }

    function getMinimumStake() external view override returns (uint256) {
        return _minimumStake;
    }

    function resetPendingGap() external onlyOwner {
        _pendingGap = 0;
        emit PendingGapReseted();
    }

    function setMinimumStake(uint256 minStake) external onlyOperator {
        _minimumStake = minStake;
        emit MinimalStakeChanged(minStake);
    }

    function setDistributeGasLeft(uint256 gasLeft) external onlyOwner {
        _DISTRIBUTE_GAS_LEFT = gasLeft;
        emit DistributeGasLeftChanged(gasLeft);
    }

    function getRelayerFee() external view override returns (uint256) {
        return _tokenHub.getMiniRelayFee();
    }

    function changeIntermediary(address intermediary) external onlyOwner {
        require(intermediary != address(0), "zero address");
        _intermediary = intermediary;
        emit IntermediaryChanged(intermediary);
    }

    function changeBondContract(address bondContract) external onlyOwner {
        require(bondContract != address(0), "zero address");
        require(
            AddressUpgradeable.isContract(bondContract),
            "non-contract address"
        );
        _bondContract = bondContract;
        emit BondContractChanged(bondContract);
    }

    function changeCertContract(address certToken) external onlyOwner {
        require(certToken != address(0), "zero address");
        require(
            AddressUpgradeable.isContract(certToken),
            "non-contract address"
        );
        _certContract = certToken;
        emit CertContractChanged(certToken);
    }

    function changeTokenHub(address tokenHub) external onlyOwner {
        require(tokenHub != address(0), "zero address");
        require(
            AddressUpgradeable.isContract(tokenHub),
            "non-contract address"
        );
        _tokenHub = ITokenHub(tokenHub);
        emit TokenHubChanged(tokenHub);
    }

    receive() external payable {
        if (msg.sender == address(_tokenHub)) {
            failedStakesAmount += msg.value;
        }
        emit Received(msg.sender, msg.value);
    }

    function withdrawFailedStakes() external nonReentrant onlyOperator {
        uint256 amount = failedStakesAmount;
        require(amount > 0, "nothing to withdraw");

        address payable wallet = payable(address(_operator));
        (bool result, ) = wallet.call{value: amount}("");
        require(result, "failed to send failed stakes amount");

        failedStakesAmount = 0;

        emit FailedStakesWithdrawn(amount);
    }
}
