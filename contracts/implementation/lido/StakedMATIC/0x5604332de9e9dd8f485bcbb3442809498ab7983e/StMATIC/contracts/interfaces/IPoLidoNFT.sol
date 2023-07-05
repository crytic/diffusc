// SPDX-FileCopyrightText: 2021 ShardLabs
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

import "../@openzeppelin/contracts-upgradeable/token/ERC721/IERC721Upgradeable.sol";

/// @title PoLidoNFT interface.
/// @author 2021 ShardLabs
interface IPoLidoNFT is IERC721Upgradeable {
    
    /// @notice Mint a new Lido NFT for a _to address.
    /// @param _to owner of the NFT.
    /// @return tokenId returns the token id.
    function mint(address _to) external returns (uint256);

    /// @notice Burn a Lido NFT for a _to address.
    /// @param _tokenId the token id.
    function burn(uint256 _tokenId) external;

    /// @notice Check if the spender is the owner of the NFT or it was approved to it.
    /// @param _spender the spender address.
    /// @param _tokenId the token id.
    /// @return result return if the token is owned or approved to/by the spender.
    function isApprovedOrOwner(address _spender, uint256 _tokenId)
        external
        view
        returns (bool);

    /// @notice Set stMatic address.
    /// @param _stMATIC new stMatic address.
    function setStMATIC(address _stMATIC) external;

    /// @notice List all the tokens owned by an address.
    /// @param _owner the owner address.
    /// @return result return a list of token ids.
    function getOwnedTokens(address _owner) external view returns (uint256[] memory);

    /// @notice toggle pause/unpause the contract
    function togglePause() external;

    /// @notice Allows to set new version.
    /// @param _newVersion new contract version.
    function setVersion(string calldata _newVersion) external;
}
