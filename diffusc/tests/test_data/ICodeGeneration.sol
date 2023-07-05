interface ICodeGeneration {
    enum SomeEnum { ONE, TWO, THREE }
    struct St {
        uint256 v;
    }
    function stateA() external returns (uint256);
    function owner() external returns (address);
    function structs(address,uint256) external returns (St memory);
    function err0() external;
    function err1() external;
    function err2(uint256,uint256) external;
    function newSt(uint256) external returns (St memory);
    function getSt(uint256) external view returns (St memory);
    function removeSt(St memory) external;
    function complexTypes(address,uint256[] memory) external view returns (St[] memory,SomeEnum);
}

