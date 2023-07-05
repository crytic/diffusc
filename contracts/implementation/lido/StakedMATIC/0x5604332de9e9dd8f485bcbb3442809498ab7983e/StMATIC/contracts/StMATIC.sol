// SPDX-FileCopyrightText: 2021 ShardLabs
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

import "./@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";

import "./interfaces/IValidatorShare.sol";
import "./interfaces/INodeOperatorRegistry.sol";
import "./interfaces/IStakeManager.sol";
import "./interfaces/IPoLidoNFT.sol";
import "./interfaces/IFxStateRootTunnel.sol";
import "./interfaces/IStMATIC.sol";

/// @title StMATIC
/// @author 2021 ShardLabs.
contract StMATIC is
    IStMATIC,
    ERC20Upgradeable,
    AccessControlUpgradeable,
    PausableUpgradeable
{
    using SafeERC20Upgradeable for IERC20Upgradeable;

    /// @notice node operator registry interface.
    INodeOperatorRegistry public override nodeOperatorRegistry;

    /// @notice The fee distribution.
    FeeDistribution public override entityFees;

    /// @notice StakeManager interface.
    IStakeManager public override stakeManager;

    /// @notice LidoNFT interface.
    IPoLidoNFT public override poLidoNFT;

    /// @notice fxStateRootTunnel interface.
    IFxStateRootTunnel public override fxStateRootTunnel;

    /// @notice contract version.
    string public override version;

    /// @notice dao address.
    address public override dao;

    /// @notice insurance address.
    address public override insurance;

    /// @notice Matic ERC20 token.
    address public override token;

    /// @notice Matic ERC20 token address NOT USED IN V2.
    uint256 public override lastWithdrawnValidatorId;

    /// @notice total buffered Matic in the contract.
    uint256 public override totalBuffered;

    /// @notice delegation lower bound.
    uint256 public override delegationLowerBound;

    /// @notice reward distribution lower bound.
    uint256 public override rewardDistributionLowerBound;

    /// @notice reserved funds in Matic.
    uint256 public override reservedFunds;

    /// @notice submit threshold NOT USED in V2.
    uint256 public override submitThreshold;

    /// @notice submit handler NOT USED in V2.
    bool public override submitHandler;

    /// @notice token to WithdrawRequest mapping one-to-one.
    mapping(uint256 => RequestWithdraw) public override token2WithdrawRequest;

    /// @notice DAO Role.
    bytes32 public constant override DAO = keccak256("DAO");
    bytes32 public constant override PAUSE_ROLE =
        keccak256("LIDO_PAUSE_OPERATOR");
    bytes32 public constant override UNPAUSE_ROLE =
        keccak256("LIDO_UNPAUSE_OPERATOR");

    /// @notice When an operator quit the system StMATIC contract withdraw the total delegated
    /// to it. The request is stored inside this array.
    RequestWithdraw[] public stMaticWithdrawRequest;

    /// @notice token to Array WithdrawRequest mapping one-to-many.
    mapping(uint256 => RequestWithdraw[]) public token2WithdrawRequests;

    /// @notice protocol fee.
    uint8 public override protocolFee;

    // @notice these state variable are used to mark entrance and exit form a contract function
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;
    uint256 private _status;

    // @notice used to execute the recovery 1 time
    bool private recovered;

    /// @notice Prevents a contract from calling itself, directly or indirectly.
    modifier nonReentrant() {
        _nonReentrant();
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }

    /// @param _nodeOperatorRegistry - Address of the node operator registry
    /// @param _token - Address of MATIC token on Ethereum Mainnet
    /// @param _dao - Address of the DAO
    /// @param _insurance - Address of the insurance
    /// @param _stakeManager - Address of the stake manager
    /// @param _poLidoNFT - Address of the stMATIC NFT
    /// @param _fxStateRootTunnel - Address of the FxStateRootTunnel
    function initialize(
        address _nodeOperatorRegistry,
        address _token,
        address _dao,
        address _insurance,
        address _stakeManager,
        address _poLidoNFT,
        address _fxStateRootTunnel
    ) external override initializer {
        __AccessControl_init_unchained();
        __Pausable_init_unchained();
        __ERC20_init_unchained("Staked MATIC", "stMATIC");

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(DAO, _dao);
        _grantRole(PAUSE_ROLE, msg.sender);
        _grantRole(UNPAUSE_ROLE, _dao);

        nodeOperatorRegistry = INodeOperatorRegistry(_nodeOperatorRegistry);
        stakeManager = IStakeManager(_stakeManager);
        poLidoNFT = IPoLidoNFT(_poLidoNFT);
        fxStateRootTunnel = IFxStateRootTunnel(_fxStateRootTunnel);
        dao = _dao;
        token = _token;
        insurance = _insurance;

        entityFees = FeeDistribution(25, 50, 25);
    }

    /// @notice Send funds to StMATIC contract and mints StMATIC to msg.sender
    /// @notice Requires that msg.sender has approved _amount of MATIC to this contract
    /// @param _amount - Amount of MATIC sent from msg.sender to this contract
    /// @param _referral - referral address.
    /// @return Amount of StMATIC shares generated
    function submit(uint256 _amount, address _referral)
        external
        override
        whenNotPaused
        nonReentrant
        returns (uint256)
    {
        _require(_amount > 0, "Invalid amount");

        IERC20Upgradeable(token).safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );

        (
            uint256 amountToMint,
            uint256 totalShares,
            uint256 totalPooledMatic
        ) = convertMaticToStMatic(_amount);

        _require(amountToMint > 0, "Mint ZERO");

        _mint(msg.sender, amountToMint);

        totalBuffered += _amount;

        fxStateRootTunnel.sendMessageToChild(
            abi.encode(totalShares + amountToMint, totalPooledMatic + _amount)
        );

        emit SubmitEvent(msg.sender, _amount, _referral);

        return amountToMint;
    }

    /// @notice Stores users request to withdraw into a RequestWithdraw struct
    /// @param _amount - Amount of StMATIC that is requested to withdraw
    /// @param _referral - referral address.
    /// @return NFT token id.
    function requestWithdraw(uint256 _amount, address _referral)
        external
        override
        whenNotPaused
        nonReentrant
        returns (uint256)
    {
        _require(
            _amount > 0 && balanceOf(msg.sender) >= _amount,
            "Invalid amount"
        );
        uint256 tokenId;

        {
            uint256 totalPooledMatic = _getTotalPooledMatic(getTotalStakeAcrossAllValidators());
            uint256 totalAmount2WithdrawInMatic = _convertStMaticToMatic(
                _amount,
                totalPooledMatic
            );
            _require(totalAmount2WithdrawInMatic > 0, "Withdraw ZERO Matic");

            (
                INodeOperatorRegistry.ValidatorData[] memory activeNodeOperators,
                uint256 totalDelegated,
                uint256 bigNodeOperatorLength,
                uint256[] memory bigNodeOperatorIds,
                uint256 smallNodeOperatorLength,
                uint256[] memory smallNodeOperatorIds,
                uint256[] memory allowedAmountToRequestFromOperators,
                uint256 totalValidatorsToWithdrawFrom
            ) = nodeOperatorRegistry.getValidatorsRequestWithdraw(totalAmount2WithdrawInMatic);

            {
                uint256 localActiveBalance = totalBuffered > reservedFunds
                    ? totalBuffered - reservedFunds
                    : 0;
                uint256 liquidity = totalDelegated + localActiveBalance;
                _require(
                    liquidity >= totalAmount2WithdrawInMatic,
                    "Too much to withdraw"
                );
            }
            // Added a scoop here to fix stack too deep error
            {
                uint256 currentAmount2WithdrawInMatic = totalAmount2WithdrawInMatic;
                tokenId = poLidoNFT.mint(msg.sender);

                if (totalDelegated != 0) {
                    if (totalValidatorsToWithdrawFrom != 0) {
                        currentAmount2WithdrawInMatic = _requestWithdrawBalanced(
                            tokenId,
                            activeNodeOperators,
                            totalAmount2WithdrawInMatic,
                            totalValidatorsToWithdrawFrom,
                            totalDelegated,
                            currentAmount2WithdrawInMatic
                        );
                    } else {
                        // request withdraw from big delegated validators
                        currentAmount2WithdrawInMatic = _requestWithdrawUnbalanced(
                            tokenId,
                            activeNodeOperators,
                            bigNodeOperatorLength,
                            bigNodeOperatorIds,
                            allowedAmountToRequestFromOperators,
                            currentAmount2WithdrawInMatic
                        );

                        // request withdraw from small delegated validators
                        if (currentAmount2WithdrawInMatic != 0) {
                            currentAmount2WithdrawInMatic = _requestWithdrawUnbalanced(
                                tokenId,
                                activeNodeOperators,
                                smallNodeOperatorLength,
                                smallNodeOperatorIds,
                                allowedAmountToRequestFromOperators,
                                currentAmount2WithdrawInMatic
                            );
                        }
                    }
                }

                if (totalAmount2WithdrawInMatic > totalDelegated) {
                    token2WithdrawRequests[tokenId].push(
                        RequestWithdraw(
                            currentAmount2WithdrawInMatic,
                            0,
                            stakeManager.epoch() + stakeManager.withdrawalDelay(),
                            address(0)
                        )
                    );
                    reservedFunds += currentAmount2WithdrawInMatic;
                    currentAmount2WithdrawInMatic = 0;
                }
            }

            _burn(msg.sender, _amount);

            fxStateRootTunnel.sendMessageToChild(
                abi.encode(
                    totalSupply(),
                    totalPooledMatic - totalAmount2WithdrawInMatic
                )
            );
        }

        emit RequestWithdrawEvent(msg.sender, _amount, _referral);
        return tokenId;
    }

    /// @notice Request withdraw when system is balanced
    function _requestWithdrawBalanced(
        uint256 tokenId,
        INodeOperatorRegistry.ValidatorData[] memory activeNodeOperators,
        uint256 totalAmount2WithdrawInMatic,
        uint256 totalValidatorsToWithdrawFrom,
        uint256 totalDelegated,
        uint256 currentAmount2WithdrawInMatic
    ) private returns (uint256) {
        uint256 totalAmount = totalDelegated > totalAmount2WithdrawInMatic
            ? totalAmount2WithdrawInMatic
            : totalDelegated;
        uint256 amount2WithdrawFromValidator = totalAmount /
            totalValidatorsToWithdrawFrom;

        for (uint256 idx = 0; idx < totalValidatorsToWithdrawFrom; idx++) {
            address validatorShare = activeNodeOperators[idx].validatorShare;

            _require(
                _calculateValidatorShares(
                    validatorShare,
                    amount2WithdrawFromValidator
                ) > 0,
                "ZERO shares to withdraw"
            );

            currentAmount2WithdrawInMatic = _requestWithdraw(
                tokenId,
                validatorShare,
                amount2WithdrawFromValidator,
                currentAmount2WithdrawInMatic
            );
        }
        return currentAmount2WithdrawInMatic;
    }

    /// @notice Request withdraw when system is unbalanced
    function _requestWithdrawUnbalanced(
        uint256 tokenId,
        INodeOperatorRegistry.ValidatorData[] memory activeNodeOperators,
        uint256 nodeOperatorLength,
        uint256[] memory nodeOperatorIds,
        uint256[] memory allowedAmountToRequestFromOperators,
        uint256 currentAmount2WithdrawInMatic
    ) private returns (uint256) {
        for (uint256 idx = 0; idx < nodeOperatorLength; idx++) {
            uint256 id = nodeOperatorIds[idx];
            uint256 amountCanBeRequested = allowedAmountToRequestFromOperators[
                id
            ];
            if (amountCanBeRequested == 0) continue;

            uint256 amount2WithdrawFromValidator = amountCanBeRequested >
                currentAmount2WithdrawInMatic
                ? currentAmount2WithdrawInMatic
                : allowedAmountToRequestFromOperators[id];

            address validatorShare = activeNodeOperators[id].validatorShare;

            _require(
                _calculateValidatorShares(
                    validatorShare,
                    amount2WithdrawFromValidator
                ) > 0,
                "ZERO shares to withdraw"
            );

            currentAmount2WithdrawInMatic = _requestWithdraw(
                tokenId,
                validatorShare,
                amount2WithdrawFromValidator,
                currentAmount2WithdrawInMatic
            );
            if (currentAmount2WithdrawInMatic == 0) break;
        }
        return currentAmount2WithdrawInMatic;
    }

    function _requestWithdraw(
        uint256 tokenId,
        address validatorShare,
        uint256 amount2WithdrawFromValidator,
        uint256 currentAmount2WithdrawInMatic
    ) private returns (uint256) {
        sellVoucher_new(
            validatorShare,
            amount2WithdrawFromValidator,
            type(uint256).max
        );

        token2WithdrawRequests[tokenId].push(
            RequestWithdraw(
                0,
                IValidatorShare(validatorShare).unbondNonces(address(this)),
                stakeManager.epoch() + stakeManager.withdrawalDelay(),
                validatorShare
            )
        );
        currentAmount2WithdrawInMatic -= amount2WithdrawFromValidator;
        return currentAmount2WithdrawInMatic;
    }

    /// @notice This will be included in the cron job
    /// @notice Delegates tokens to validator share contract
    function delegate() external override whenNotPaused nonReentrant {
        uint256 ltotalBuffered = totalBuffered;
        uint256 lreservedFunds = reservedFunds;
        _require(
            ltotalBuffered > delegationLowerBound + lreservedFunds,
            "Amount to delegate lower than minimum"
        );

        uint256 amountToDelegate = ltotalBuffered - lreservedFunds;

        (
            INodeOperatorRegistry.ValidatorData[]
                memory delegatableNodeOperators,
            uint256 totalDelegatableNodeOperators,
            uint256[] memory operatorRatios,
            uint256 totalRatio
        ) = nodeOperatorRegistry.getValidatorsDelegationAmount(
                amountToDelegate
            );

        uint256 remainder;
        uint256 amountDelegated;

        IERC20Upgradeable(token).safeApprove(address(stakeManager), 0);
        IERC20Upgradeable(token).safeApprove(
            address(stakeManager),
            amountToDelegate
        );

        for (uint256 i = 0; i < totalDelegatableNodeOperators; i++) {
            uint256 amountToDelegatePerOperator;

            // If the total Ratio is equal to ZERO that means the system is balanced so we
            // distribute the buffered tokens equally between the validators
            if (totalRatio == 0) {
                amountToDelegatePerOperator =
                    amountToDelegate /
                    totalDelegatableNodeOperators;
            } else {
                if (operatorRatios[i] == 0) continue;
                amountToDelegatePerOperator =
                    (operatorRatios[i] * amountToDelegate) /
                    totalRatio;
            }
            address _validatorAddress = delegatableNodeOperators[i]
                .validatorShare;

            uint256 shares = _calculateValidatorShares(
                _validatorAddress,
                amountToDelegatePerOperator
            );
            if (shares == 0) continue;

            buyVoucher(_validatorAddress, amountToDelegatePerOperator, 0);

            amountDelegated += amountToDelegatePerOperator;
        }

        remainder = amountToDelegate - amountDelegated;
        totalBuffered = remainder + lreservedFunds;

        emit DelegateEvent(amountDelegated, remainder);
    }

    /// @notice Claims tokens from validator share and sends them to the
    /// user if his request is in the userToWithdrawRequest
    /// @param _tokenId - Id of the token that wants to be claimed
    function claimTokens(uint256 _tokenId) external override whenNotPaused {
        _require(
            poLidoNFT.isApprovedOrOwner(msg.sender, _tokenId),
            "Not owner"
        );

        if (token2WithdrawRequest[_tokenId].requestEpoch != 0) {
            _claimTokensV1(_tokenId);
        } else if (token2WithdrawRequests[_tokenId].length != 0) {
            _claimTokensV2(_tokenId);
        } else {
            revert("Invalid claim token");
        }
    }

    /// @notice Claims tokens v2
    function _claimTokensV2(uint256 _tokenId) private {
        RequestWithdraw[] memory usersRequest = token2WithdrawRequests[
            _tokenId
        ];
        _require(
            stakeManager.epoch() >= usersRequest[0].requestEpoch,
            "Not able to claim yet"
        );

        poLidoNFT.burn(_tokenId);
        uint256 length = usersRequest.length;
        uint256 amountToClaim;

        uint256 balanceBeforeClaim = IERC20Upgradeable(token).balanceOf(
            address(this)
        );

        for (uint256 idx = 0; idx < length; idx++) {
            if (usersRequest[idx].validatorAddress != address(0)) {
                unstakeClaimTokens_new(
                    usersRequest[idx].validatorAddress,
                    usersRequest[idx].validatorNonce
                );
            } else {
                uint256 _amountToClaim = usersRequest[idx]
                    .amount2WithdrawFromStMATIC;
                reservedFunds -= _amountToClaim;
                totalBuffered -= _amountToClaim;
                amountToClaim += _amountToClaim;
            }
        }

        amountToClaim +=
            IERC20Upgradeable(token).balanceOf(address(this)) -
            balanceBeforeClaim;

        IERC20Upgradeable(token).safeTransfer(msg.sender, amountToClaim);

        emit ClaimTokensEvent(msg.sender, _tokenId, amountToClaim, 0);
    }

    /// @notice Claims tokens v1
    function _claimTokensV1(uint256 _tokenId) private {
        RequestWithdraw storage usersRequest = token2WithdrawRequest[_tokenId];

        _require(
            stakeManager.epoch() >= usersRequest.requestEpoch,
            "Not able to claim yet"
        );

        poLidoNFT.burn(_tokenId);

        uint256 amountToClaim;

        if (usersRequest.validatorAddress != address(0)) {
            uint256 balanceBeforeClaim = IERC20Upgradeable(token).balanceOf(
                address(this)
            );

            unstakeClaimTokens_new(
                usersRequest.validatorAddress,
                usersRequest.validatorNonce
            );

            amountToClaim =
                IERC20Upgradeable(token).balanceOf(address(this)) -
                balanceBeforeClaim;
        } else {
            amountToClaim = usersRequest.amount2WithdrawFromStMATIC;

            reservedFunds -= amountToClaim;
            totalBuffered -= amountToClaim;
        }

        IERC20Upgradeable(token).safeTransfer(msg.sender, amountToClaim);

        emit ClaimTokensEvent(msg.sender, _tokenId, amountToClaim, 0);
    }

    /// @notice Distributes rewards claimed from validator shares based on fees defined
    /// in entityFee.
    function distributeRewards() external override whenNotPaused nonReentrant {
        (
            INodeOperatorRegistry.ValidatorData[] memory operatorInfos,
            uint256 totalActiveOperatorInfos
        ) = nodeOperatorRegistry.listDelegatedNodeOperators();

        for (uint256 i = 0; i < totalActiveOperatorInfos; i++) {
            IValidatorShare validatorShare = IValidatorShare(
                operatorInfos[i].validatorShare
            );
            uint256 stMaticReward = validatorShare.getLiquidRewards(
                address(this)
            );
            uint256 rewardThreshold = validatorShare.minAmount();
            if (stMaticReward > rewardThreshold) {
                validatorShare.withdrawRewards();
            }
        }

        uint256 totalRewards = IERC20Upgradeable(token).balanceOf(
            address(this)
        ) - totalBuffered;

        uint256 protocolRewards = totalRewards * protocolFee / 100;

        _require(
            protocolRewards > rewardDistributionLowerBound,
            "Amount to distribute lower than minimum"
        );

        uint256 balanceBeforeDistribution = IERC20Upgradeable(token).balanceOf(
            address(this)
        );

        uint256 daoRewards = (protocolRewards * entityFees.dao) / 100;
        uint256 insuranceRewards = (protocolRewards * entityFees.insurance) / 100;
        uint256 operatorsRewards = (protocolRewards * entityFees.operators) / 100;
        uint256 operatorReward = operatorsRewards / totalActiveOperatorInfos;

        IERC20Upgradeable(token).safeTransfer(dao, daoRewards);
        IERC20Upgradeable(token).safeTransfer(insurance, insuranceRewards);

        for (uint256 i = 0; i < totalActiveOperatorInfos; i++) {
            IERC20Upgradeable(token).safeTransfer(
                operatorInfos[i].rewardAddress,
                operatorReward
            );
        }

        uint256 currentBalance = IERC20Upgradeable(token).balanceOf(
            address(this)
        );

        uint256 totalDistributed = balanceBeforeDistribution - currentBalance;

        // Add the remainder to totalBuffered
        totalBuffered = currentBalance;

        emit DistributeRewardsEvent(totalDistributed);
    }

    /// @notice Only NodeOperatorRegistry can call this function
    /// @notice Withdraws funds from stopped validator.
    /// @param _validatorShare - Address of the validator share that will be withdrawn
    function withdrawTotalDelegated(address _validatorShare)
        external
        override
        nonReentrant
    {
        _require(
            msg.sender == address(nodeOperatorRegistry),
            "Not a node operator"
        );

        (uint256 stakedAmount, ) = getTotalStake(
            IValidatorShare(_validatorShare)
        );

        // Check if the validator has enough shares.
        uint256 shares = _calculateValidatorShares(
            _validatorShare,
            stakedAmount
        );
        if (shares == 0) {
            return;
        }

        _createWithdrawRequest(_validatorShare, stakedAmount);
        emit WithdrawTotalDelegatedEvent(_validatorShare, stakedAmount);
    }

    /// @notice Rebalane the system by request withdraw from the validators that contains
    /// more token delegated to them.
    function rebalanceDelegatedTokens() external override onlyRole(DAO) {
        uint256 amountToReDelegate = totalBuffered -
            reservedFunds +
            calculatePendingBufferedTokens();
        (
            INodeOperatorRegistry.ValidatorData[] memory nodeOperators,
            uint256 totalActiveNodeOperator,
            uint256[] memory operatorRatios,
            uint256 totalRatio,
            uint256 totalToWithdraw
        ) = nodeOperatorRegistry.getValidatorsRebalanceAmount(
                amountToReDelegate
            );

        uint256 amountToWithdraw;
        address _validatorAddress;
        for (uint256 i = 0; i < totalActiveNodeOperator; i++) {
            if (operatorRatios[i] == 0) continue;

            amountToWithdraw =
                (operatorRatios[i] * totalToWithdraw) /
                totalRatio;
            if (amountToWithdraw == 0) continue;

            _validatorAddress = nodeOperators[i].validatorShare;
            uint256 shares = _calculateValidatorShares(
                _validatorAddress,
                amountToWithdraw
            );
            if (shares == 0) continue;

            _createWithdrawRequest(
                nodeOperators[i].validatorShare,
                amountToWithdraw
            );
        }
    }

    function _createWithdrawRequest(address _validatorShare, uint256 amount)
        private
    {
        sellVoucher_new(_validatorShare, amount, type(uint256).max);
        stMaticWithdrawRequest.push(
            RequestWithdraw(
                0,
                IValidatorShare(_validatorShare).unbondNonces(address(this)),
                stakeManager.epoch() + stakeManager.withdrawalDelay(),
                _validatorShare
            )
        );
    }

    /// @notice calculate the total amount stored in stMaticWithdrawRequest array.
    /// @return pendingBufferedTokens the total pending amount for stMatic.
    function calculatePendingBufferedTokens()
        public
        view
        override
        returns (uint256 pendingBufferedTokens)
    {
        uint256 pendingWithdrawalLength = stMaticWithdrawRequest.length;

        for (uint256 i = 0; i < pendingWithdrawalLength; i++) {
            pendingBufferedTokens += _getMaticFromRequestData(
                stMaticWithdrawRequest[i]
            );
        }
        return pendingBufferedTokens;
    }

    /// @notice Claims tokens from validator share and sends them to the StMATIC contract.
    function claimTokensFromValidatorToContract(uint256 _index)
        external
        override
        whenNotPaused
        nonReentrant
    {
        uint256 length = stMaticWithdrawRequest.length;
        _require(_index < length, "invalid index");
        RequestWithdraw memory lidoRequest = stMaticWithdrawRequest[_index];

        _require(
            stakeManager.epoch() >= lidoRequest.requestEpoch,
            "Not able to claim yet"
        );

        uint256 balanceBeforeClaim = IERC20Upgradeable(token).balanceOf(
            address(this)
        );

        unstakeClaimTokens_new(
            lidoRequest.validatorAddress,
            lidoRequest.validatorNonce
        );

        uint256 claimedAmount = IERC20Upgradeable(token).balanceOf(
            address(this)
        ) - balanceBeforeClaim;

        totalBuffered += claimedAmount;

        if (_index != length - 1 && length != 1) {
            stMaticWithdrawRequest[_index] = stMaticWithdrawRequest[length - 1];
        }
        stMaticWithdrawRequest.pop();

        fxStateRootTunnel.sendMessageToChild(
            abi.encode(totalSupply(), getTotalPooledMatic())
        );

        emit ClaimTotalDelegatedEvent(
            lidoRequest.validatorAddress,
            claimedAmount
        );
    }

    /// @notice Pauses the contract
    function pause() external onlyRole(PAUSE_ROLE) {
        _pause();
    }

    /// @notice Unpauses the contract
    function unpause() external onlyRole(UNPAUSE_ROLE) {
        _unpause();
    }

    ////////////////////////////////////////////////////////////
    /////                                                    ///
    /////             ***ValidatorShare API***               ///
    /////                                                    ///
    ////////////////////////////////////////////////////////////

    /// @notice Returns the stMaticWithdrawRequest list
    function getTotalWithdrawRequest()
        public
        view
        returns (RequestWithdraw[] memory)
    {
        return stMaticWithdrawRequest;
    }

    /// @notice API for delegated buying vouchers from validatorShare
    /// @param _validatorShare - Address of validatorShare contract
    /// @param _amount - Amount of MATIC to use for buying vouchers
    /// @param _minSharesToMint - Minimum of shares that is bought with _amount of MATIC
    /// @return Actual amount of MATIC used to buy voucher, might differ from _amount because of _minSharesToMint
    function buyVoucher(
        address _validatorShare,
        uint256 _amount,
        uint256 _minSharesToMint
    ) private returns (uint256) {
        uint256 amountSpent = IValidatorShare(_validatorShare).buyVoucher(
            _amount,
            _minSharesToMint
        );

        return amountSpent;
    }

    /// @notice API for delegated unstaking and claiming tokens from validatorShare
    /// @param _validatorShare - Address of validatorShare contract
    /// @param _unbondNonce - Unbond nonce
    function unstakeClaimTokens_new(
        address _validatorShare,
        uint256 _unbondNonce
    ) private {
        IValidatorShare(_validatorShare).unstakeClaimTokens_new(_unbondNonce);
    }

    /// @notice API for delegated selling vouchers from validatorShare
    /// @param _validatorShare - Address of validatorShare contract
    /// @param _claimAmount - Amount of MATIC to claim
    /// @param _maximumSharesToBurn - Maximum amount of shares to burn
    function sellVoucher_new(
        address _validatorShare,
        uint256 _claimAmount,
        uint256 _maximumSharesToBurn
    ) private {
        IValidatorShare(_validatorShare).sellVoucher_new(
            _claimAmount,
            _maximumSharesToBurn
        );
    }

    /// @notice API for getting total stake of this contract from validatorShare
    /// @param _validatorShare - Address of validatorShare contract
    /// @return Total stake of this contract and MATIC -> share exchange rate
    function getTotalStake(IValidatorShare _validatorShare)
        public
        view
        override
        returns (uint256, uint256)
    {
        return _validatorShare.getTotalStake(address(this));
    }

    /// @notice API for liquid rewards of this contract from validatorShare
    /// @param _validatorShare - Address of validatorShare contract
    /// @return Liquid rewards of this contract
    function getLiquidRewards(IValidatorShare _validatorShare)
        external
        view
        override
        returns (uint256)
    {
        return _validatorShare.getLiquidRewards(address(this));
    }

    ////////////////////////////////////////////////////////////
    /////                                                    ///
    /////            ***Helpers & Utilities***               ///
    /////                                                    ///
    ////////////////////////////////////////////////////////////

    /// @notice Helper function for that returns total pooled MATIC
    /// @return Total pooled MATIC
    function getTotalStakeAcrossAllValidators()
        public
        view
        override
        returns (uint256)
    {
        uint256 totalStake;
        (
            INodeOperatorRegistry.ValidatorData[] memory nodeOperators,
            uint256 operatorsLength
        ) = nodeOperatorRegistry.listWithdrawNodeOperators();

        for (uint256 i = 0; i < operatorsLength; i++) {
            (uint256 currValidatorShare, ) = getTotalStake(
                IValidatorShare(nodeOperators[i].validatorShare)
            );

            totalStake += currValidatorShare;
        }

        return totalStake;
    }

    /// @notice Function that calculates total pooled Matic
    /// @return Total pooled Matic
    function getTotalPooledMatic() public view override returns (uint256) {
        uint256 totalStaked = getTotalStakeAcrossAllValidators();
        return _getTotalPooledMatic(totalStaked);
    }

    function _getTotalPooledMatic(uint256 _totalStaked)
        private
        view
        returns (uint256)
    {
        return
            _totalStaked +
            totalBuffered +
            calculatePendingBufferedTokens() -
            reservedFunds;
    }

    /// @notice Function that converts arbitrary stMATIC to Matic
    /// @param _amountInStMatic - Amount of stMATIC to convert to Matic
    /// @return amountInMatic - Amount of Matic after conversion,
    /// @return totalStMaticAmount - Total StMatic in the contract,
    /// @return totalPooledMatic - Total Matic in the staking pool
    function convertStMaticToMatic(uint256 _amountInStMatic)
        external
        view
        override
        returns (
            uint256 amountInMatic,
            uint256 totalStMaticAmount,
            uint256 totalPooledMatic
        )
    {
        totalStMaticAmount = totalSupply();
        uint256 totalPooledMATIC = getTotalPooledMatic();
        return (
            _convertStMaticToMatic(_amountInStMatic, totalPooledMATIC),
            totalStMaticAmount,
            totalPooledMATIC
        );
    }

    /// @notice Function that converts arbitrary amount of stMatic to Matic
    /// @param _stMaticAmount - amount of stMatic to convert to Matic
    /// @return amountInMatic, totalStMaticAmount and totalPooledMatic
    function _convertStMaticToMatic(
        uint256 _stMaticAmount,
        uint256 _totalPooledMatic
    ) private view returns (uint256) {
        uint256 totalStMaticSupply = totalSupply();
        totalStMaticSupply = totalStMaticSupply == 0 ? 1 : totalStMaticSupply;
        _totalPooledMatic = _totalPooledMatic == 0 ? 1 : _totalPooledMatic;
        uint256 amountInMatic = (_stMaticAmount * _totalPooledMatic) /
            totalStMaticSupply;
        return amountInMatic;
    }

    /// @notice Function that converts arbitrary Matic to stMATIC
    /// @param _amountInMatic - Amount of Matic to convert to stMatic
    /// @return amountInStMatic - Amount of Matic to converted to stMatic
    /// @return totalStMaticSupply - Total amount of StMatic in the contract
    /// @return totalPooledMatic - Total amount of Matic in the staking pool
    function convertMaticToStMatic(uint256 _amountInMatic)
        public
        view
        override
        returns (
            uint256 amountInStMatic,
            uint256 totalStMaticSupply,
            uint256 totalPooledMatic
        )
    {
        totalStMaticSupply = totalSupply();
        totalPooledMatic = getTotalPooledMatic();
        return (
            _convertMaticToStMatic(_amountInMatic, totalPooledMatic),
            totalStMaticSupply,
            totalPooledMatic
        );
    }

    function getToken2WithdrawRequests(uint256 _tokenId)
        external
        view
        returns (RequestWithdraw[] memory)
    {
        return token2WithdrawRequests[_tokenId];
    }

    /// @notice Function that converts arbitrary amount of Matic to stMatic
    /// @param _maticAmount - Amount in Matic to convert to stMatic
    /// @return amountInStMatic , totalStMaticAmount and totalPooledMatic
    function _convertMaticToStMatic(
        uint256 _maticAmount,
        uint256 _totalPooledMatic
    ) private view returns (uint256) {
        uint256 totalStMaticSupply = totalSupply();
        totalStMaticSupply = totalStMaticSupply == 0 ? 1 : totalStMaticSupply;
        _totalPooledMatic = _totalPooledMatic == 0 ? 1 : _totalPooledMatic;
        uint256 amountInStMatic = (_maticAmount * totalStMaticSupply) /
            _totalPooledMatic;
        return amountInStMatic;
    }

    ////////////////////////////////////////////////////////////
    /////                                                    ///
    /////                 ***Setters***                      ///
    /////                                                    ///
    ////////////////////////////////////////////////////////////

    /// @notice Function that sets entity fees
    /// @notice Callable only by dao
    /// @param _daoFee - DAO fee in %
    /// @param _operatorsFee - Operator fees in %
    /// @param _insuranceFee - Insurance fee in %
    function setFees(
        uint8 _daoFee,
        uint8 _operatorsFee,
        uint8 _insuranceFee
    ) external override onlyRole(DAO) {
        _require(
            _daoFee + _operatorsFee + _insuranceFee == 100,
            "sum(fee)!=100"
        );
        entityFees.dao = _daoFee;
        entityFees.operators = _operatorsFee;
        entityFees.insurance = _insuranceFee;

        emit SetFees(_daoFee, _operatorsFee, _insuranceFee);
    }

    /// @notice Function that sets protocol fee
    /// @param _newProtocolFee new protocol fee
    function setProtocolFee(uint8 _newProtocolFee)
        external
        override
        onlyRole(DAO)
    {
        _require(
            _newProtocolFee > 0 && _newProtocolFee <= 100,
            "Invalid protcol fee"
        );
        uint8 oldProtocolFee = protocolFee;
        protocolFee = _newProtocolFee;

        emit SetProtocolFee(oldProtocolFee, _newProtocolFee);
    }

    /// @notice Function that sets new dao address
    /// @notice Callable only by dao
    /// @param _newDAO - New dao address
    function setDaoAddress(address _newDAO) external override onlyRole(DAO) {
        address oldDAO = dao;
        dao = _newDAO;
        emit SetDaoAddress(oldDAO, _newDAO);
    }

    /// @notice Function that sets new insurance address
    /// @notice Callable only by dao
    /// @param _address - New insurance address
    function setInsuranceAddress(address _address)
        external
        override
        onlyRole(DAO)
    {
        insurance = _address;
        emit SetInsuranceAddress(_address);
    }

    /// @notice Function that sets new node operator address
    /// @notice Only callable by dao
    /// @param _address - New node operator address
    function setNodeOperatorRegistryAddress(address _address)
        external
        override
        onlyRole(DAO)
    {
        nodeOperatorRegistry = INodeOperatorRegistry(_address);
        emit SetNodeOperatorRegistryAddress(_address);
    }

    /// @notice Function that sets new lower bound for delegation
    /// @notice Only callable by dao
    /// @param _delegationLowerBound - New lower bound for delegation
    function setDelegationLowerBound(uint256 _delegationLowerBound)
        external
        override
        onlyRole(DAO)
    {
        delegationLowerBound = _delegationLowerBound;
        emit SetDelegationLowerBound(_delegationLowerBound);
    }

    /// @notice Function that sets new lower bound for rewards distribution
    /// @notice Only callable by dao
    /// @param _newRewardDistributionLowerBound - New lower bound for rewards distribution
    function setRewardDistributionLowerBound(
        uint256 _newRewardDistributionLowerBound
    ) external override onlyRole(DAO) {
        uint256 oldRewardDistributionLowerBound = rewardDistributionLowerBound;
        rewardDistributionLowerBound = _newRewardDistributionLowerBound;

        emit SetRewardDistributionLowerBound(
            oldRewardDistributionLowerBound,
            _newRewardDistributionLowerBound
        );
    }

    // /// @notice Function that sets the poLidoNFT address
    // /// @param _newLidoNFT new poLidoNFT address
    // function setPoLidoNFT(address _newLidoNFT) external override onlyRole(DAO) {
    //     address oldPoLidoNFT = address(poLidoNFT);
    //     poLidoNFT = IPoLidoNFT(_newLidoNFT);
    //     emit SetLidoNFT(oldPoLidoNFT, _newLidoNFT);
    // }

    /// @notice Function that sets the fxStateRootTunnel address
    /// @param _newFxStateRootTunnel address of fxStateRootTunnel
    function setFxStateRootTunnel(address _newFxStateRootTunnel)
        external
        override
        onlyRole(DAO)
    {
        address oldFxStateRootTunnel = address(fxStateRootTunnel);
        fxStateRootTunnel = IFxStateRootTunnel(_newFxStateRootTunnel);

        emit SetFxStateRootTunnel(oldFxStateRootTunnel, _newFxStateRootTunnel);
    }

    // /// @notice Function that sets the new version
    // /// @param _newVersion - New version that will be set
    // function setVersion(string calldata _newVersion)
    //     external
    //     override
    //     onlyRole(DAO)
    // {
    //     emit Version(version, _newVersion);
    //     version = _newVersion;
    // }

    /// @notice Function that retrieves the amount of matic that will be claimed from the NFT token
    /// @param _tokenId - Id of the PolidoNFT
    function getMaticFromTokenId(uint256 _tokenId)
        external
        view
        override
        returns (uint256)
    {
        if (token2WithdrawRequest[_tokenId].requestEpoch != 0) {
            return _getMaticFromRequestData(token2WithdrawRequest[_tokenId]);
        } else if (token2WithdrawRequests[_tokenId].length != 0) {
            RequestWithdraw[] memory requestsData = token2WithdrawRequests[
                _tokenId
            ];
            uint256 totalMatic;
            for (uint256 idx = 0; idx < requestsData.length; idx++) {
                totalMatic += _getMaticFromRequestData(requestsData[idx]);
            }
            return totalMatic;
        }
        return 0;
    }

    function _getMaticFromRequestData(RequestWithdraw memory requestData)
        private
        view
        returns (uint256)
    {
        if (requestData.validatorAddress == address(0)) {
            return requestData.amount2WithdrawFromStMATIC;
        }
        IValidatorShare validatorShare = IValidatorShare(
            requestData.validatorAddress
        );
        uint256 exchangeRatePrecision = _getExchangeRatePrecision(
            validatorShare.validatorId()
        );
        uint256 withdrawExchangeRate = validatorShare.withdrawExchangeRate();
        IValidatorShare.DelegatorUnbond memory unbond = validatorShare
            .unbonds_new(address(this), requestData.validatorNonce);

        return (withdrawExchangeRate * unbond.shares) / exchangeRatePrecision;
    }

    function _nonReentrant() private view {
        _require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
    }

    function _require(bool _condition, string memory _message) private pure {
        require(_condition, _message);
    }

    /// @dev get the exchange rate precision per validator.
    /// More details: https://github.com/maticnetwork/contracts/blob/v0.3.0-backport/contracts/staking/validatorShare/ValidatorShare.sol#L21
    /// https://github.com/maticnetwork/contracts/blob/v0.3.0-backport/contracts/staking/validatorShare/ValidatorShare.sol#L87
    function _getExchangeRatePrecision(uint256 _validatorId)
        private
        pure
        returns (uint256)
    {
        return _validatorId < 8 ? 100 : 10**29;
    }

    /// @dev calculate the number of shares to get when delegate an amount of Matic
    function _calculateValidatorShares(
        address _validatorAddress,
        uint256 _amountInMatic
    ) private view returns (uint256) {
        IValidatorShare validatorShare = IValidatorShare(_validatorAddress);
        uint256 exchangeRatePrecision = _getExchangeRatePrecision(
            validatorShare.validatorId()
        );
        uint256 rate = validatorShare.exchangeRate();
        return (_amountInMatic * exchangeRatePrecision) / rate;
    }

    // @notice delete after execution
    function recover(
        address[] memory _usersAddress,
        uint256[] memory _amountOfStMaticToIncreaseForEachUser,
        address _compensatedAddress,
        uint256 _compensatedAmount
    ) external onlyRole(DAO) {
        _require(!recovered, "The protocol was recovered");
        _require(_usersAddress.length > 0 && _usersAddress.length == _amountOfStMaticToIncreaseForEachUser.length, "Invalid array length");
        // transfer the compensated amount to the affected user. 
        IERC20Upgradeable(token).safeTransfer(_compensatedAddress, _compensatedAmount);
        totalBuffered -= _compensatedAmount;

        // Increse users stMatic balances
        for (uint256 idx = 0; idx < _usersAddress.length; idx++) {
            _mint(_usersAddress[idx], _amountOfStMaticToIncreaseForEachUser[idx]);
        }
        recovered = true;
    }
}
