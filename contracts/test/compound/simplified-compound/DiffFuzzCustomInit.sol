// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.10;

import "./DiffFuzzUpgrades.sol";
import "./ComptrollerInterface.sol";
import {SimplePriceOracle} from "./SimplePriceOracle.sol";
import {SimplePriceOracleV2} from "./SimplePriceOracleV2.sol";
import "./@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./@openzeppelin/contracts/token/ERC20/presets/ERC20PresetFixedSupply.sol";
import "./WhitePaperInterestRateModel.sol";


contract DiffFuzzInit is DiffFuzzUpgrades {

    constructor() DiffFuzzUpgrades() public {
        // Below is custom, not auto-generated
        simpleCompV1 = ISimpleComp(address(new SimpleComp(address(simpleUnitrollerV1))));
        simpleCompV2 = ISimpleComp(address(new SimpleComp(address(simpleUnitrollerV2))));
        ISimpleComptrollerV1(address(simpleUnitrollerV1)).setCompAddress(address(simpleCompV1));
        ISimpleComptrollerV2(address(simpleUnitrollerV2)).setCompAddress(address(simpleCompV2));
        
        priceOracleV1 = IPriceOracle(address(new SimplePriceOracle()));
        priceOracleV2 = IPriceOracle(address(new SimplePriceOracleV2()));
        ISimpleComptrollerV1(address(simpleUnitrollerV1))._setPriceOracle(address(priceOracleV1));
        ISimpleComptrollerV2(address(simpleUnitrollerV2))._setPriceOracle(address(priceOracleV1));
        InterestRateModel interestModel = new WhitePaperInterestRateModel(0, 5e16);

        simpleCEtherV1 = ISimpleCEther(address(new SimpleCEther(
            ComptrollerInterface(address(simpleUnitrollerV1)),
            interestModel,
            0.02e28,
            "cEtherV1",
            "cETH",
            8,
            payable(address(this))
        )));
        simpleCEtherV2 = ISimpleCEther(address(new SimpleCEther(
            ComptrollerInterface(address(simpleUnitrollerV2)),
            interestModel,
            0.02e28,
            "cEtherV2",
            "cETH",
            8,
            payable(address(this))
        )));

        ERC20PresetFixedSupply underlyingV1 = new ERC20PresetFixedSupply("UnderlyingV1", "UV1", 10e18, address(msg.sender));
        ERC20PresetFixedSupply underlyingV2 = new ERC20PresetFixedSupply("UnderlyingV2", "UV2", 10e18, address(msg.sender));

        hevm.prank(simpleCErc20V1.admin());
        simpleCErc20V1.initialize(
            address(underlyingV1),
            address(simpleUnitrollerV1),
            address(interestModel),
            0.02e28,
            "cTokenV1",
            "CV1",
            8
        );
        hevm.prank(simpleCErc20V1.admin());
        simpleCErc20V1._setReserveFactor(0.15e18);
        hevm.prank(simpleCErc20V2.admin());
        simpleCErc20V2.initialize(
            address(underlyingV2),
            address(simpleUnitrollerV2),
            address(interestModel),
            0.02e28,
            "cTokenV2",
            "CV2",
            8
        );
        hevm.prank(simpleCErc20V2.admin());
        simpleCErc20V2._setReserveFactor(0.15e18);
        // Allowances
        hevm.prank(msg.sender);
        underlyingV1.approve(
            address(simpleCErc20V1),
            type(uint256).max
        );
        hevm.prank(msg.sender);
        underlyingV2.approve(
            address(simpleCErc20V2),
            type(uint256).max
        );
        // Support markets
        ISimpleComptrollerV1(address(simpleUnitrollerV1))._supportMarket(address(simpleCErc20V1));
        ISimpleComptrollerV2(address(simpleUnitrollerV2))._supportMarket(address(simpleCErc20V2));
        ISimpleComptrollerV1(address(simpleUnitrollerV1))._supportMarket(address(simpleCEtherV1));
        ISimpleComptrollerV2(address(simpleUnitrollerV2))._supportMarket(address(simpleCEtherV2));
        // Enter markets
        address[] memory marketsV1 = new address[](1);
        marketsV1[0] = address(simpleCErc20V1);
        hevm.prank(msg.sender);
        ISimpleComptrollerV1(address(simpleUnitrollerV1)).enterMarkets(marketsV1);
        address[] memory marketsV2 = new address[](1);
        marketsV2[0] = address(simpleCErc20V2);
        hevm.prank(msg.sender);
        ISimpleComptrollerV2(address(simpleUnitrollerV2)).enterMarkets(marketsV2);
    }

    function simpleCErc20_approve_underlying() public {
        ERC20 underlyingV1 = ERC20(simpleCErc20V1.underlying());
        ERC20 underlyingV2 = ERC20(simpleCErc20V2.underlying());
        require(underlyingV1.balanceOf(msg.sender) > 0 && underlyingV2.balanceOf(msg.sender) > 0);
        // Allowances
        hevm.prank(msg.sender);
        underlyingV1.approve(
            address(simpleCErc20V1),
            type(uint256).max
        );
        hevm.prank(msg.sender);
        underlyingV2.approve(
            address(simpleCErc20V2),
            type(uint256).max
        );
    }

    function upgradeV2() external override {
        simpleUnitrollerV2._setPendingImplementation(address(simpleComptrollerV2));
        simpleComptrollerV2._become(address(simpleUnitrollerV2));
        ISimpleComptrollerV2(address(simpleUnitrollerV2)).setCompAddress(address(simpleCompV2));
    }

    function upgradeV2Oracle() external {
        ISimpleComptrollerV2(address(simpleUnitrollerV2))._setPriceOracle(address(priceOracleV2));
    }

    // function upgradeV2Oracle() external {
        
    // }

    function SimpleComptrollerV2__supportMarket(address a) public override {
        bool listedV1 = ISimpleComptrollerV1(address(simpleUnitrollerV1)).markets(a).isListed;
        bool listedV2 = ISimpleComptrollerV2(address(simpleUnitrollerV2)).markets(a).isListed;
        require(!listedV1 && !listedV2);
        super.SimpleComptrollerV2__supportMarket(a);
    }

    function SimpleComptrollerV2_claimComp() public override {
        address[] memory marketsV1 = ISimpleComptrollerV1(address(simpleUnitrollerV1)).getAssetsIn(msg.sender);
        address[] memory marketsV2 = ISimpleComptrollerV2(address(simpleUnitrollerV2)).getAssetsIn(msg.sender);
        require(marketsV1.length > 0 && marketsV2.length > 0);
        super.SimpleComptrollerV2_claimComp();
    }

    function SimpleComptrollerV2__setCompSpeed(uint8 a, uint256 b) public virtual {
        uint marketIndex = a % 2;
        address a1 = ISimpleComptrollerV1(address(simpleUnitrollerV1)).allMarkets(marketIndex);
        address a2 = ISimpleComptrollerV2(address(simpleUnitrollerV2)).allMarkets(marketIndex);
        (bool successV2, bytes memory outputV2) = address(simpleUnitrollerV2).call(
            abi.encodeWithSelector(
                simpleComptrollerV2._setCompSpeed.selector, a2, b
            )
        );
        (bool successV1, bytes memory outputV1) = address(simpleUnitrollerV1).call(
            abi.encodeWithSelector(
                simpleComptrollerV1._setCompSpeed.selector, a1, b
            )
        );
        assert(successV1 == successV2); 
        assert((!successV1 && !successV2) || keccak256(outputV1) == keccak256(outputV2));
    }

    function SimpleCErc20_mint(uint256 a) public override {
        require(a > 0);
        ERC20 underlyingV1 = ERC20(simpleCErc20V1.underlying());
        ERC20 underlyingV2 = ERC20(simpleCErc20V2.underlying());
        require(underlyingV1.balanceOf(msg.sender) > 0 && underlyingV2.balanceOf(msg.sender) > 0);
        super.SimpleCErc20_mint(a);
    }

    function SimpleComp_balanceOf(address a) public override {
        require(a != address(simpleUnitrollerV1) && a != address(simpleUnitrollerV2));
        super.SimpleComp_balanceOf(a);
    }
}
