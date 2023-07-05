// SPDX-FileCopyrightText: 2021 ShardLabs
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

import "../@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";

import "./IValidatorShare.sol";
import "./INodeOperatorRegistry.sol";
import "./IStakeManager.sol";
import "./IPoLidoNFT.sol";
import "./IFxStateRootTunnel.sol";

/// @title StMATIC interface.
/// @author 2021 ShardLabs
interface IStMATIC is IERC20Upgradeable {
    /// @notice The request withdraw struct.
    /// @param amount2WithdrawFromStMATIC amount in Matic.
    /// @param validatorNonce validator nonce.
    /// @param requestEpoch request epoch.
    /// @param validatorAddress validator share address.
    struct RequestWithdraw {
        uint256 amount2WithdrawFromStMATIC;
        uint256 validatorNonce;
        uint256 requestEpoch;
        address validatorAddress;
    }

    /// @notice The fee distribution struct.
    /// @param dao dao fee.
    /// @param operators operators fee.
    /// @param insurance insurance fee.
    struct FeeDistribution {
        uint8 dao;
        uint8 operators;
        uint8 insurance;
    }

    /// @notice node operator registry interface.
    function nodeOperatorRegistry()
        external
        view
        returns (INodeOperatorRegistry);

    /// @notice The fee distribution.
    /// @return dao dao fee.
    /// @return operators operators fee.
    /// @return insurance insurance fee.
    function entityFees()
        external
        view
        returns (
            uint8,
            uint8,
            uint8
        );

    /// @notice StakeManager interface.
    function stakeManager() external view returns (IStakeManager);

    /// @notice LidoNFT interface.
    function poLidoNFT() external view returns (IPoLidoNFT);

    /// @notice fxStateRootTunnel interface.
    function fxStateRootTunnel() external view returns (IFxStateRootTunnel);

    /// @notice contract version.
    function version() external view returns (string memory);

    /// @notice dao address.
    function dao() external view returns (address);

    /// @notice insurance address.
    function insurance() external view returns (address);

    /// @notice Matic ERC20 token.
    function token() external view returns (address);

    /// @notice Matic ERC20 token address NOT USED IN V2.
    function lastWithdrawnValidatorId() external view returns (uint256);

    /// @notice total buffered Matic in the contract.
    function totalBuffered() external view returns (uint256);

    /// @notice delegation lower bound.
    function delegationLowerBound() external view returns (uint256);

    /// @notice reward distribution lower bound.
    function rewardDistributionLowerBound() external view returns (uint256);

    /// @notice reserved funds in Matic.
    function reservedFunds() external view returns (uint256);

    /// @notice submit threshold NOT USED in V2.
    function submitThreshold() external view returns (uint256);

    /// @notice submit handler NOT USED in V2.
    function submitHandler() external view returns (bool);

    /// @notice token to WithdrawRequest mapping.
    function token2WithdrawRequest(uint256 _requestId)
        external
        view
        returns (
            uint256,
            uint256,
            uint256,
            address
        );

    /// @notice DAO Role.
    function DAO() external view returns (bytes32);

    /// @notice PAUSE_ROLE Role.
    function PAUSE_ROLE() external view returns (bytes32);

    /// @notice UNPAUSE_ROLE Role.
    function UNPAUSE_ROLE() external view returns (bytes32);

    /// @notice Protocol Fee.
    function protocolFee() external view returns (uint8);

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
    ) external;

    /// @notice Send funds to StMATIC contract and mints StMATIC to msg.sender
    /// @notice Requires that msg.sender has approved _amount of MATIC to this contract
    /// @param _amount - Amount of MATIC sent from msg.sender to this contract
    /// @param _referral - referral address.
    /// @return Amount of StMATIC shares generated
    function submit(uint256 _amount, address _referral) external returns (uint256);

    /// @notice Stores users request to withdraw into a RequestWithdraw struct
    /// @param _amount - Amount of StMATIC that is requested to withdraw
    /// @param _referral - referral address.
    /// @return NFT token id.
    function requestWithdraw(uint256 _amount, address _referral) external returns (uint256);

    /// @notice This will be included in the cron job
    /// @notice Delegates tokens to validator share contract
    function delegate() external;

    /// @notice Claims tokens from validator share and sends them to the
    /// StMATIC contract
    /// @param _tokenId - Id of the token that is supposed to be claimed
    function claimTokens(uint256 _tokenId) external;

    /// @notice Distributes rewards claimed from validator shares based on fees defined
    /// in entityFee.
    function distributeRewards() external;

    /// @notice withdraw total delegated
    /// @param _validatorShare validator share address.
    function withdrawTotalDelegated(address _validatorShare) external;

    /// @notice Claims tokens from validator share and sends them to the
    /// StMATIC contract
    /// @param _tokenId - Id of the token that is supposed to be claimed
    function claimTokensFromValidatorToContract(uint256 _tokenId) external;

    /// @notice Rebalane the system by request withdraw from the validators that contains
    /// more token delegated to them.
    function rebalanceDelegatedTokens() external;

    /// @notice Helper function for that returns total pooled MATIC
    /// @return Total pooled MATIC
    function getTotalStake(IValidatorShare _validatorShare)
        external
        view
        returns (uint256, uint256);

    /// @notice API for liquid rewards of this contract from validatorShare
    /// @param _validatorShare - Address of validatorShare contract
    /// @return Liquid rewards of this contract
    function getLiquidRewards(IValidatorShare _validatorShare)
        external
        view
        returns (uint256);

    /// @notice Helper function for that returns total pooled MATIC
    /// @return Total pooled MATIC
    function getTotalStakeAcrossAllValidators() external view returns (uint256);

    /// @notice Function that calculates total pooled Matic
    /// @return Total pooled Matic
    function getTotalPooledMatic() external view returns (uint256);

    /// @notice get Matic from token id.
    /// @param _tokenId NFT token id.
    /// @return total the amount in Matic.
    function getMaticFromTokenId(uint256 _tokenId)
        external
        view
        returns (uint256);

    /// @notice calculate the total amount stored in all the NFTs owned by
    /// stMatic contract.
    /// @return pendingBufferedTokens the total pending amount for stMatic.
    function calculatePendingBufferedTokens() external view returns(uint256);

    /// @notice Function that converts arbitrary stMATIC to Matic
    /// @param _amountInStMatic - Amount of stMATIC to convert to Matic
    /// @return amountInMatic - Amount of Matic after conversion,
    /// @return totalStMaticAmount - Total StMatic in the contract,
    /// @return totalPooledMatic - Total Matic in the staking pool
    function convertStMaticToMatic(uint256 _amountInStMatic)
        external
        view
        returns (
            uint256 amountInMatic,
            uint256 totalStMaticAmount,
            uint256 totalPooledMatic
        );

    /// @notice Function that converts arbitrary Matic to stMATIC
    /// @param _amountInMatic - Amount of Matic to convert to stMatic
    /// @return amountInStMatic - Amount of Matic to converted to stMatic
    /// @return totalStMaticSupply - Total amount of StMatic in the contract
    /// @return totalPooledMatic - Total amount of Matic in the staking pool
    function convertMaticToStMatic(uint256 _amountInMatic)
        external
        view
        returns (
            uint256 amountInStMatic,
            uint256 totalStMaticSupply,
            uint256 totalPooledMatic
        );

    /// @notice Allows to set fees.
    /// @param _daoFee the new daoFee
    /// @param _operatorsFee the new operatorsFee
    /// @param _insuranceFee the new insuranceFee
    function setFees(
        uint8 _daoFee,
        uint8 _operatorsFee,
        uint8 _insuranceFee
    ) external;

    /// @notice Function that sets protocol fee
    /// @param _newProtocolFee - Insurance fee in %
    function setProtocolFee(uint8 _newProtocolFee) external;

    /// @notice Allows to set DaoAddress.
    /// @param _newDaoAddress new DaoAddress.
    function setDaoAddress(address _newDaoAddress) external;

    /// @notice Allows to set InsuranceAddress.
    /// @param _newInsuranceAddress new InsuranceAddress.
    function setInsuranceAddress(address _newInsuranceAddress) external;

    /// @notice Allows to set NodeOperatorRegistryAddress.
    /// @param _newNodeOperatorRegistry new NodeOperatorRegistryAddress.
    function setNodeOperatorRegistryAddress(address _newNodeOperatorRegistry)
        external;

    /// @notice Allows to set delegationLowerBound.
    /// @param _delegationLowerBound new delegationLowerBound.
    function setDelegationLowerBound(uint256 _delegationLowerBound) external;

    /// @notice Allows to set setRewardDistributionLowerBound.
    /// @param _rewardDistributionLowerBound new setRewardDistributionLowerBound.
    function setRewardDistributionLowerBound(
        uint256 _rewardDistributionLowerBound
    ) external;

    /// @notice Allows to set LidoNFT.
    /// @param _poLidoNFT new LidoNFT.
    function setPoLidoNFT(address _poLidoNFT) external;

    /// @notice Allows to set fxStateRootTunnel.
    /// @param _fxStateRootTunnel new fxStateRootTunnel.
    function setFxStateRootTunnel(address _fxStateRootTunnel) external;

    /// @notice Allows to set new version.
    /// @param _newVersion new contract version.
    function setVersion(string calldata _newVersion) external;

    ////////////////////////////////////////////////////////////
    /////                                                    ///
    /////                 ***EVENTS***                       ///
    /////                                                    ///
    ////////////////////////////////////////////////////////////

    /// @notice Emit when submit.
    /// @param _from msg.sender.
    /// @param _amount amount.
    /// @param _referral - referral address.
    event SubmitEvent(address indexed _from, uint256 _amount, address indexed _referral);

    /// @notice Emit when request withdraw.
    /// @param _from msg.sender.
    /// @param _amount amount.
    /// @param _referral - referral address.
    event RequestWithdrawEvent(address indexed _from, uint256 _amount, address indexed _referral);

    /// @notice Emit when distribute rewards.
    /// @param _amount amount.
    event DistributeRewardsEvent(uint256 indexed _amount);

    /// @notice Emit when withdraw total delegated.
    /// @param _from msg.sender.
    /// @param _amount amount.
    event WithdrawTotalDelegatedEvent(
        address indexed _from,
        uint256 indexed _amount
    );

    /// @notice Emit when delegate.
    /// @param _amountDelegated amount to delegate.
    /// @param _remainder remainder.
    event DelegateEvent(
        uint256 indexed _amountDelegated,
        uint256 indexed _remainder
    );

    /// @notice Emit when ClaimTokens.
    /// @param _from msg.sender.
    /// @param _id token id.
    /// @param _amountClaimed amount Claimed.
    /// @param _amountBurned amount Burned.
    event ClaimTokensEvent(
        address indexed _from,
        uint256 indexed _id,
        uint256 indexed _amountClaimed,
        uint256 _amountBurned
    );

    /// @notice Emit when set new InsuranceAddress.
    /// @param _newInsuranceAddress the new InsuranceAddress.
    event SetInsuranceAddress(address indexed _newInsuranceAddress);

    /// @notice Emit when set new NodeOperatorRegistryAddress.
    /// @param _newNodeOperatorRegistryAddress the new NodeOperatorRegistryAddress.
    event SetNodeOperatorRegistryAddress(
        address indexed _newNodeOperatorRegistryAddress
    );

    /// @notice Emit when set new SetDelegationLowerBound.
    /// @param _delegationLowerBound the old DelegationLowerBound.
    event SetDelegationLowerBound(uint256 indexed _delegationLowerBound);

    /// @notice Emit when set new RewardDistributionLowerBound.
    /// @param oldRewardDistributionLowerBound the old RewardDistributionLowerBound.
    /// @param newRewardDistributionLowerBound the new RewardDistributionLowerBound.
    event SetRewardDistributionLowerBound(
        uint256 oldRewardDistributionLowerBound,
        uint256 newRewardDistributionLowerBound
    );

    /// @notice Emit when set new LidoNFT.
    /// @param oldLidoNFT the old oldLidoNFT.
    /// @param newLidoNFT the new newLidoNFT.
    event SetLidoNFT(address oldLidoNFT, address newLidoNFT);

    /// @notice Emit when set new FxStateRootTunnel.
    /// @param oldFxStateRootTunnel the old FxStateRootTunnel.
    /// @param newFxStateRootTunnel the new FxStateRootTunnel.
    event SetFxStateRootTunnel(
        address oldFxStateRootTunnel,
        address newFxStateRootTunnel
    );

    /// @notice Emit when set new DAO.
    /// @param oldDaoAddress the old DAO.
    /// @param newDaoAddress the new DAO.
    event SetDaoAddress(address oldDaoAddress, address newDaoAddress);

    /// @notice Emit when set fees.
    /// @param daoFee the new daoFee
    /// @param operatorsFee the new operatorsFee
    /// @param insuranceFee the new insuranceFee
    event SetFees(uint256 daoFee, uint256 operatorsFee, uint256 insuranceFee);

    /// @notice Emit when set ProtocolFee.
    /// @param oldProtocolFee the new ProtocolFee
    /// @param newProtocolFee the new ProtocolFee
    event SetProtocolFee(uint8 oldProtocolFee, uint8 newProtocolFee);

    /// @notice Emit when set ProtocolFee.
    /// @param validatorShare vaidatorshare address.
    /// @param amountClaimed amount claimed.
    event ClaimTotalDelegatedEvent(
        address indexed validatorShare,
        uint256 indexed amountClaimed
    );

    /// @notice Emit when set version.
    /// @param oldVersion old.
    /// @param newVersion new.
    event Version(
        string oldVersion,
        string indexed newVersion
    );
}
