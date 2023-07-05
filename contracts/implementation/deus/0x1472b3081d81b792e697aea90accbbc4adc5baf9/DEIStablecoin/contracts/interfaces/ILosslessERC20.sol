// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILERC20 {
    function name() external view returns (string memory);

    function admin() external view returns (address);

    function getAdmin() external view returns (address);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address _account) external view returns (uint256);

    function transfer(address _recipient, uint256 _amount)
        external
        returns (bool);

    function allowance(address _owner, address _spender)
        external
        view
        returns (uint256);

    function approve(address _spender, uint256 _amount) external returns (bool);

    function transferFrom(
        address _sender,
        address _recipient,
        uint256 _amount
    ) external returns (bool);

    function increaseAllowance(address _spender, uint256 _addedValue)
        external
        returns (bool);

    function decreaseAllowance(address _spender, uint256 _subtractedValue)
        external
        returns (bool);

    function transferOutBlacklistedFunds(address[] calldata _from) external;

    function setLosslessAdmin(address _newAdmin) external;

    function transferRecoveryAdminOwnership(
        address _candidate,
        bytes32 _keyHash
    ) external;

    function acceptRecoveryAdminOwnership(bytes memory _key) external;

    function proposeLosslessTurnOff() external;

    function executeLosslessTurnOff() external;

    function executeLosslessTurnOn() external;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
    event NewAdmin(address indexed _newAdmin);
    event NewRecoveryAdminProposal(address indexed _candidate);
    event NewRecoveryAdmin(address indexed _newAdmin);
    event LosslessTurnOffProposal(uint256 _turnOffDate);
    event LosslessOff();
    event LosslessOn();
    event NewTimelockPeriod(uint256 _newTimelockPeriod);
}
