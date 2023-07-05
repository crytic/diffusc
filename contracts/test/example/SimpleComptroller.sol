pragma solidity ^0.5.16;

contract Token {
    uint256 public totalSupply;
    mapping (address => uint256) internal balances;
/*-----------------------------------snip-------------------------------------*/
    function balanceOf(address account) external view returns (uint) { return balances[account]; }
    function transfer(address dst, uint amount) external { _transfer(msg.sender, dst, amount); }
    function _transfer(address src, address dst, uint amount) internal {
        if(balances[src] >= amount) {
            balances[src] -= amount;
            balances[dst] += amount;
        }
    }
}

contract SimpleComptroller {
    struct CompMarketState {
        uint compAccruedPerUnit;
        uint block;
    }
    Token constant COMP = Token(0xc00e94Cb662C3520282E6f5717214004A7f26888);
    uint224 public constant compInitialAccruedPerUnit = 1e36;
    mapping(address => CompMarketState) public compSupplyState;
    mapping(address => mapping(address => uint)) public compSupplierAccruedPerUnit;
    mapping(address => uint) public compAccrued;
    mapping(address => uint) public compSpeeds;
/*-----------------------------------snip-------------------------------------*/
    function distributeSupplierComp(address cToken, address supplier) internal {
        uint supplyAccruedPerUnit = compSupplyState[cToken].compAccruedPerUnit;
        uint supplierAccruedPerUnit = compSupplierAccruedPerUnit[cToken][supplier];

        compSupplierAccruedPerUnit[cToken][supplier] = supplyAccruedPerUnit;

        if (supplierAccruedPerUnit == 0 && supplyAccruedPerUnit > compInitialAccruedPerUnit) {
            // Covers case where users supplied tokens before the market's supply state compAccruedPerUnit was set.
            // Rewards user with COMP accrued from when supplier rewards were first set for the market.
            supplierAccruedPerUnit = compInitialAccruedPerUnit;
        }
        uint delta = supplyAccruedPerUnit - supplierAccruedPerUnit;
        uint supplierTokens = Token(cToken).balanceOf(supplier);
        uint supplierDelta = supplierTokens * delta;
        compAccrued[supplier] = compAccrued[supplier] + supplierDelta;
    }
/*-----------------------------------snip-------------------------------------*/
    function updateCompSupplyAccrued(address cToken) internal {
        CompMarketState storage supplyState = compSupplyState[cToken];
        uint deltaBlocks = block.number - uint(supplyState.block);
        uint accrued = deltaBlocks * compSpeeds[cToken];
        uint ratio = accrued / Token(cToken).totalSupply();
        uint index = supplyState.compAccruedPerUnit + ratio;
        compSupplyState[cToken] = CompMarketState({ compAccruedPerUnit: index, block: block.number });
    }
/*-----------------------------------snip-------------------------------------*/
    function claimComp(Token[] memory cTokens) public {
        for (uint i = 0; i < cTokens.length; i++) {
            Token cToken = cTokens[i];
            updateCompSupplyAccrued(address(cToken));
            distributeSupplierComp(address(cToken), msg.sender);
        }
        if (compAccrued[msg.sender] > 0 && compAccrued[msg.sender] <= COMP.balanceOf(address(this))) {
            COMP.transfer(msg.sender, compAccrued[msg.sender]);
            compAccrued[msg.sender] = 0;
        }
    }
/*-----------------------------------snip-------------------------------------*/
/*---------------------------------new code-----------------------------------*/
    function _initializeMarket(address cToken) internal {
        CompMarketState storage supplyState = compSupplyState[cToken];
        if (supplyState.compAccruedPerUnit == 0) {
            // Initialize supply state compAccruedPerUnit with default value
            supplyState.compAccruedPerUnit = compInitialAccruedPerUnit;
        }
        supplyState.block = uint32(block.number);
    }
}
