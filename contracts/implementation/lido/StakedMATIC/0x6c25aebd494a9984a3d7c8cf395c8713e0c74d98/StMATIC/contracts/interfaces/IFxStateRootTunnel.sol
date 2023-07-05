// SPDX-FileCopyrightText: 2021 ShardLabs
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

interface IFxStateRootTunnel {

    /// @notice send message to child
    /// @param _message message
    function sendMessageToChild(bytes memory _message) external;

    /// @notice Set stMatic address.
    /// @param _newStMATIC the new stMatic address.
    function setStMATIC(address _newStMATIC) external;
}
