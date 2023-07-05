pragma solidity ^0.6.11;

interface IConfig {
    function getConfig(bytes32 config) external view returns (uint256);

    function setConfig(bytes32 config, uint256 value) external;
}