pragma solidity 0.6.11;
import "../upgrades/@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";

contract Pausable is  OwnableUpgradeSafe {
    mapping (bytes32 => bool) internal _paused;

    modifier whenNotPaused(bytes32 action) {
        require(!_paused[action], "This action currently paused");
        _;
    }

    function togglePause(bytes32 action) public onlyOwner {
        _paused[action] = !_paused[action];
    }

    function isPaused(bytes32 action) public view returns(bool) {
        return _paused[action];
    }

    uint256[50] private __gap;
}
