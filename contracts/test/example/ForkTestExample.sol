// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.0;

interface IHevm {
    function warp(uint256 newTimestamp) external;
    function roll(uint256 newNumber) external;
    function load(address where, bytes32 slot) external returns (bytes32);
    function store(address where, bytes32 slot, bytes32 value) external;
    function sign(uint256 privateKey, bytes32 digest) external returns (uint8 r, bytes32 v, bytes32 s);
    function addr(uint256 privateKey) external returns (address add);
    function ffi(string[] calldata inputs) external returns (bytes memory result);
    function prank(address newSender) external;
    function createFork() external returns (uint256 forkId);
    function selectFork(uint256 forkId) external;
}

/// @dev This contract's state should depend on which fork we are on
contract TestState {
    uint256 public state;

    function setState(uint256 _state) external {
        state = _state;
    }
}

/// @dev This contract's state should be persistent across forks, because it's the contract Echidna deploys
contract ForkTest {
    IHevm hevm = IHevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    address stateContract;
    uint256 forkId1;
    uint256 forkId2;
    uint256 persistentState;

    constructor() {
        stateContract = address(new TestState());
        forkId1 = hevm.createFork();    // If the default fork's id is 0, then this would be 1
        forkId2 = hevm.createFork();    // and this would be 2
        persistentState = 0;
    }

    function testForkedState() external {
        persistentState = 1;                            // Make sure this contract maintains its own state across forks

        hevm.selectFork(forkId1);                       // Fork 1
        assert(TestState(stateContract).state() == 0);  //      Check initial external state
        assert(persistentState == 1);                   //      Check persistent state
        persistentState = 2;                            //      Set persistent state
        TestState(stateContract).setState(1);           //      Set unique external state
        hevm.roll(12345678);                            //      Set unique block number

        hevm.selectFork(forkId2);                       // Fork 2
        assert(TestState(stateContract).state() == 0);  //      Check initial external state
        assert(persistentState == 2);                   //      Check persistent state
        persistentState = 3;                            //      Set persistent state
        TestState(stateContract).setState(2);           //      Set unique external state
        hevm.roll(23456789);                            //      Set unique block number

        hevm.selectFork(forkId1);                       // Fork 1
        assert(block.number == 12345678);               //      Check unique block number
        assert(TestState(stateContract).state() == 1);  //      Check unique external state
        assert(persistentState == 3);                   //      Check persistent state
        persistentState = 4;                            //      Set persistent state
        TestState(stateContract).setState(0);           //      Set initial external state

        hevm.selectFork(forkId2);                       // Fork 2
        assert(block.number == 23456789);               //      Check unique block number
        assert(TestState(stateContract).state() == 2);  //      Check unique external state
        assert(persistentState == 4);                   //      Check persistent state
        persistentState = 5;                            //      Set persistent state
        TestState(stateContract).setState(0);           //      Set initial external state

        hevm.selectFork(0);                             // Default fork
        assert(persistentState == 5);                   //      Check persistent state
    }
}