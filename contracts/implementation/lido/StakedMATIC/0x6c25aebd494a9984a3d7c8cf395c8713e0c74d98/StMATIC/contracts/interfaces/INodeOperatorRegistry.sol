// SPDX-FileCopyrightText: 2021 ShardLabs
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

/// @title INodeOperatorRegistry
/// @author 2021 ShardLabs
/// @notice Node operator registry interface
interface INodeOperatorRegistry {
    /// @notice Node Operator Registry Statuses
    /// StakeManager statuses: https://github.com/maticnetwork/contracts/blob/v0.3.0-backport/contracts/staking/stakeManager/StakeManagerStorage.sol#L13
    /// ACTIVE: (validator.status == status.Active && validator.deactivationEpoch == 0)
    /// JAILED: (validator.status == status.Locked && validator.deactivationEpoch == 0)
    /// EJECTED: ((validator.status == status.Active || validator.status == status.Locked) && validator.deactivationEpoch != 0)
    /// UNSTAKED: (validator.status == status.Unstaked)
    enum NodeOperatorRegistryStatus {
        INACTIVE,
        ACTIVE,
        JAILED,
        EJECTED,
        UNSTAKED
    }

    /// @notice The full node operator struct.
    /// @param validatorId the validator id on stakeManager.
    /// @param commissionRate rate of each operator
    /// @param validatorShare the validator share address of the validator.
    /// @param rewardAddress the reward address.
    /// @param delegation delegation.
    /// @param status the status of the node operator in the stake manager.
    struct FullNodeOperatorRegistry {
        uint256 validatorId;
        uint256 commissionRate;
        address validatorShare;
        address rewardAddress;
        bool delegation;
        NodeOperatorRegistryStatus status;
    }

    /// @notice The node operator struct
    /// @param validatorShare the validator share address of the validator.
    /// @param rewardAddress the reward address.
    struct ValidatorData {
        address validatorShare;
        address rewardAddress;
    }

    /// @notice Add a new node operator to the system.
    /// ONLY DAO can execute this function.
    /// @param validatorId the validator id on stakeManager.
    /// @param rewardAddress the reward address.
    function addNodeOperator(uint256 validatorId, address rewardAddress)
        external;

    /// @notice Exit the node operator registry
    /// ONLY the owner of the node operator can call this function
    function exitNodeOperatorRegistry() external;

    /// @notice Remove a node operator from the system and withdraw total delegated tokens to it.
    /// ONLY DAO can execute this function.
    /// withdraw delegated tokens from it.
    /// @param validatorId the validator id on stakeManager.
    function removeNodeOperator(uint256 validatorId) external;

    /// @notice Remove a node operator from the system if it fails to meet certain conditions.
    /// 1. If the commission of the Node Operator is less than the standard commission.
    /// 2. If the Node Operator is either Unstaked or Ejected.
    /// @param validatorId the validator id on stakeManager.
    function removeInvalidNodeOperator(uint256 validatorId) external;

    /// @notice Set StMatic address.
    /// ONLY DAO can call this function
    /// @param newStMatic new stMatic address.
    function setStMaticAddress(address newStMatic) external;

    /// @notice Update reward address of a Node Operator.
    /// ONLY Operator owner can call this function
    /// @param newRewardAddress the new reward address.
    function setRewardAddress(address newRewardAddress) external;

    /// @notice set DISTANCETHRESHOLD
    /// ONLY DAO can call this function
    /// @param distanceThreshold the min rebalance threshold to include
    /// a validator in the delegation process.
    function setDistanceThreshold(uint256 distanceThreshold) external;

    /// @notice set MINREQUESTWITHDRAWRANGE
    /// ONLY DAO can call this function
    /// @param minRequestWithdrawRange the min request withdraw range.
    function setMinRequestWithdrawRange(uint8 minRequestWithdrawRange) external;

    /// @notice set MAXWITHDRAWPERCENTAGEPERREBALANCE
    /// ONLY DAO can call this function
    /// @param maxWithdrawPercentagePerRebalance the max withdraw percentage to
    /// withdraw from a validator per rebalance.
    function setMaxWithdrawPercentagePerRebalance(
        uint256 maxWithdrawPercentagePerRebalance
    ) external;

    /// @notice Allows to set new version.
    /// @param _newVersion new contract version.
    function setVersion(string memory _newVersion) external;

    /// @notice List all the ACTIVE operators on the stakeManager.
    /// @return activeNodeOperators a list of ACTIVE node operator.
    function listDelegatedNodeOperators()
        external
        view
        returns (ValidatorData[] memory);

    /// @notice List all the operators on the stakeManager that can be withdrawn from this includes ACTIVE, JAILED, and
    /// @notice UNSTAKED operators.
    /// @return nodeOperators a list of ACTIVE, JAILED or UNSTAKED node operator.
    function listWithdrawNodeOperators()
        external
        view
        returns (ValidatorData[] memory);

    /// @notice  Calculate how total buffered should be delegated between the active validators,
    /// depending on if the system is balanced or not. If validators are in EJECTED or UNSTAKED
    /// status the function will revert.
    /// @param amountToDelegate The total that can be delegated.
    /// @return validators all active node operators.
    /// @return operatorRatiosToDelegate a list of operator's ratio used to calculate the amount to delegate per node.
    /// @return totalRatio the total ratio. If ZERO that means the system is balanced.
    ///  It will be calculated if the system is not balanced.
    function getValidatorsDelegationAmount(uint256 amountToDelegate)
        external
        view
        returns (
            ValidatorData[] memory validators,
            uint256[] memory operatorRatiosToDelegate,
            uint256 totalRatio
        );

    /// @notice  Calculate how the system could be rebalanced depending on the current
    /// buffered tokens. If validators are in EJECTED or UNSTAKED status the function will revert.
    /// If the system is balanced the function will revert.
    /// @notice Calculate the operator ratios to rebalance the system.
    /// @param totalBuffered The total amount buffered in stMatic.
    /// @return validators all active node operators.
    /// @return operatorRatiosToRebalance a list of operator's ratio used to calculate the amount to withdraw per node.
    /// @return totalRatio the total ratio. If ZERO that means the system is balanced.
    /// @return totalToWithdraw the total amount to withdraw.
    function getValidatorsRebalanceAmount(uint256 totalBuffered)
        external
        view
        returns (
            ValidatorData[] memory validators,
            uint256[] memory operatorRatiosToRebalance,
            uint256 totalRatio,
            uint256 totalToWithdraw
        );

    /// @notice Calculate the validators to request withdrawal from depending if the system is balalnced or not.
    /// @param _withdrawAmount The amount to withdraw.
    /// @return validators all node operators.
    /// @return totalDelegated total amount delegated.
    /// @return bigNodeOperatorIds stores the ids of node operators that amount delegated to it is greater than the average delegation.
    /// @return smallNodeOperatorIds stores the ids of node operators that amount delegated to it is less than the average delegation.
    /// @return operatorAmountCanBeRequested amount that can be requested from a spécific validator when the system is not balanced.
    /// @return totalValidatorToWithdrawFrom the number of validator to withdraw from when the system is balanced.
    function getValidatorsRequestWithdraw(uint256 _withdrawAmount)
        external
        view
        returns (
            ValidatorData[] memory validators,
            uint256 totalDelegated,
            uint256[] memory bigNodeOperatorIds,
            uint256[] memory smallNodeOperatorIds,
            uint256[] memory operatorAmountCanBeRequested,
            uint256 totalValidatorToWithdrawFrom
        );

    /// @notice Returns a node operator.
    /// @param validatorId the validator id on stakeManager.
    /// @return operatorStatus a node operator.
    function getNodeOperator(uint256 validatorId)
        external
        view
        returns (FullNodeOperatorRegistry memory operatorStatus);

    /// @notice Returns a node operator.
    /// @param rewardAddress the reward address.
    /// @return operatorStatus a node operator.
    function getNodeOperator(address rewardAddress)
        external
        view
        returns (FullNodeOperatorRegistry memory operatorStatus);

    /// @notice Returns a node operator status.
    /// @param  validatorId is the id of the node operator.
    /// @return operatorStatus Returns a node operator status.
    function getNodeOperatorStatus(uint256 validatorId)
        external
        view
        returns (NodeOperatorRegistryStatus operatorStatus);

    /// @notice Return a list of all validator ids in the system.
    function getValidatorIds() external view returns (uint256[] memory);

    /// @notice Explain to an end user what this does
    /// @return isBalanced if the system is balanced or not.
    /// @return distanceThreshold the distance threshold
    /// @return minAmount min amount delegated to a validator.
    /// @return maxAmount max amount delegated to a validator.
    function getProtocolStats()
        external
        view
        returns (
            bool isBalanced,
            uint256 distanceThreshold,
            uint256 minAmount,
            uint256 maxAmount
        );

    /// @notice List all the node operator statuses in the system.
    /// @return inactiveNodeOperator the number of inactive operators.
    /// @return activeNodeOperator the number of active operators.
    /// @return jailedNodeOperator the number of jailed operators.
    /// @return ejectedNodeOperator the number of ejected operators.
    /// @return unstakedNodeOperator the number of unstaked operators.
    function getStats()
        external
        view
        returns (
            uint256 inactiveNodeOperator,
            uint256 activeNodeOperator,
            uint256 jailedNodeOperator,
            uint256 ejectedNodeOperator,
            uint256 unstakedNodeOperator
        );

    ////////////////////////////////////////////////////////////
    /////                                                    ///
    /////                 ***EVENTS***                       ///
    /////                                                    ///
    ////////////////////////////////////////////////////////////

    /// @notice Add Node Operator event
    /// @param validatorId validator id.
    /// @param rewardAddress reward address.
    event AddNodeOperator(uint256 validatorId, address rewardAddress);

    /// @notice Remove Node Operator event.
    /// @param validatorId validator id.
    /// @param rewardAddress reward address.
    event RemoveNodeOperator(uint256 validatorId, address rewardAddress);

    /// @notice Remove Invalid Node Operator event.
    /// @param validatorId validator id.
    /// @param rewardAddress reward address.
    event RemoveInvalidNodeOperator(uint256 validatorId, address rewardAddress);

    /// @notice Set StMatic address event.
    /// @param oldStMatic old stMatic address.
    /// @param newStMatic new stMatic address.
    event SetStMaticAddress(address oldStMatic, address newStMatic);

    /// @notice Set reward address event.
    /// @param validatorId the validator id.
    /// @param oldRewardAddress old reward address.
    /// @param newRewardAddress new reward address.
    event SetRewardAddress(
        uint256 validatorId,
        address oldRewardAddress,
        address newRewardAddress
    );

    /// @notice Emit when the distance threshold is changed.
    /// @param oldDistanceThreshold the old distance threshold.
    /// @param newDistanceThreshold the new distance threshold.
    event SetDistanceThreshold(
        uint256 oldDistanceThreshold,
        uint256 newDistanceThreshold
    );

    /// @notice Emit when the min request withdraw range is changed.
    /// @param oldMinRequestWithdrawRange the old min request withdraw range.
    /// @param newMinRequestWithdrawRange the new min request withdraw range.
    event SetMinRequestWithdrawRange(
        uint8 oldMinRequestWithdrawRange,
        uint8 newMinRequestWithdrawRange
    );

    /// @notice Emit when the max withdraw percentage per rebalance is changed.
    /// @param oldMaxWithdrawPercentagePerRebalance the old max withdraw percentage per rebalance.
    /// @param newMaxWithdrawPercentagePerRebalance the new max withdraw percentage per rebalance.
    event SetMaxWithdrawPercentagePerRebalance(
        uint256 oldMaxWithdrawPercentagePerRebalance,
        uint256 newMaxWithdrawPercentagePerRebalance
    );

    /// @notice Emit when set new version.
    /// @param oldVersion the old version.
    /// @param newVersion the new version.
    event SetVersion(string oldVersion, string newVersion);

    /// @notice Emit when the node operator exits the registry
    /// @param validatorId node operator id
    /// @param rewardAddress node operator reward address
    event ExitNodeOperator(uint256 validatorId, address rewardAddress);
}
