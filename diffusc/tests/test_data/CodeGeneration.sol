pragma solidity ^0.8.4;
interface I {
  enum SomeEnum { ONE, TWO, THREE }
  error ErrorWithEnum(SomeEnum e);
}

contract CodeGeneration is I {
    uint public stateA;
    uint private stateB;
    address public immutable owner = msg.sender;
    mapping(address => mapping(uint => St)) public structs;

    event NoParams();
    event Anonymous() anonymous;
    event OneParam(address addr);
    event OneParamIndexed(address indexed addr);

    error ErrorSimple();
    error ErrorWithArgs(uint, uint);
    error ErrorWithStruct(St s);

    struct St{
        uint v;
    }

    function err0() public {
        revert ErrorSimple();
    }
    function err1() public {
        St memory s;
        revert ErrorWithStruct(s);
    }
    function err2(uint a, uint b) public {
        revert ErrorWithArgs(a, b);
        revert ErrorWithArgs(uint(SomeEnum.ONE), uint(SomeEnum.ONE));
    }
    function err3() internal {
        revert('test');
    }
    function err4() private {
        revert ErrorWithEnum(SomeEnum.ONE);
    }

    function newSt(uint x) public returns (St memory) {
        St memory st;
        st.v = x;
        structs[msg.sender][x] = st;
        return st;
    }
    function getSt(uint x) public view returns (St memory) {
        return structs[msg.sender][x];
    }
    function removeSt(St memory st) public {
        delete structs[msg.sender][st.v];
    }

    function complexTypes(I addr, uint256[] memory ints) public view returns (St[] memory, SomeEnum) {
        uint len = ints.length;
        St[] memory sts = new St[](len);
        for(uint i = 0; i < len; i++) {
            uint j = ints[i];
            sts[i] = structs[address(addr)][j];
        }
        SomeEnum e = SomeEnum.ONE;
        return (sts, e);
    }
}