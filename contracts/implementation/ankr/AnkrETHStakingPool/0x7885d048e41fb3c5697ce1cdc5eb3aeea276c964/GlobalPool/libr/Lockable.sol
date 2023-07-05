pragma solidity ^0.6.11;

abstract contract Lockable {
    mapping(address => bool) private _locks;

    modifier unlocked(address addr) {
        require(!_locks[addr], "Reentrancy protection");
        _locks[addr] = true;
        _;
        _locks[addr] = false;
    }

    uint256[50] private __gap;
}
