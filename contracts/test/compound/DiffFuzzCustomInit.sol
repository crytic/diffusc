// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.10;

import "./DiffFuzzUpgrades.sol";
import "../../implementation/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../../implementation/@openzeppelin/contracts/token/ERC20/presets/ERC20PresetFixedSupply.sol";
import "../../implementation/compound/master-contracts/WhitePaperInterestRateModel.sol";


contract DiffFuzzCustomInit is DiffFuzzUpgrades {

    constructor() DiffFuzzUpgrades() public {
        // Below is custom, not auto-generated
        ICompHarness(address(compHarnessV1)).initialize(address(unitrollerV1));
        ICompHarness(address(compHarnessV2)).initialize(address(unitrollerV2));
        IComptrollerHarnessV1(address(unitrollerV1)).setCompAddress(address(compHarnessV1));
        IComptrollerHarnessV2(address(unitrollerV2)).setCompAddress(address(compHarnessV2));

        ERC20PresetFixedSupply underlyingV1 = new ERC20PresetFixedSupply("UnderlyingV1", "UV1", 10e18, address(msg.sender));
        ERC20PresetFixedSupply underlyingV2 = new ERC20PresetFixedSupply("UnderlyingV2", "UV2", 10e18, address(msg.sender));
        InterestRateModel interestModel = new WhitePaperInterestRateModel(0, 5e16);

        hevm.prank(cErc20V1.admin());
        cErc20V1.initialize(
            address(underlyingV1),
            address(unitrollerV1),
            address(interestModel),
            0.02e28,
            "cTokenV1",
            "CV1",
            8
        );
        hevm.prank(cErc20V1.admin());
        cErc20V1._setReserveFactor(0.15e18);
        hevm.prank(cErc20V2.admin());
        cErc20V2.initialize(
            address(underlyingV2),
            address(unitrollerV2),
            address(interestModel),
            0.02e28,
            "cTokenV2",
            "CV2",
            8
        );
        hevm.prank(cErc20V2.admin());
        cErc20V2._setReserveFactor(0.15e18);
        // Allowances
        hevm.prank(msg.sender);
        underlyingV1.approve(
            address(cErc20V1),
            type(uint256).max
        );
        hevm.prank(msg.sender);
        underlyingV2.approve(
            address(cErc20V2),
            type(uint256).max
        );
        // Support markets
        IComptrollerHarnessV1(address(unitrollerV1))._supportMarket(address(cErc20V1));
        IComptrollerHarnessV2(address(unitrollerV2))._supportMarket(address(cErc20V2));
        // Enter markets
        address[] memory marketsV1 = new address[](1);
        marketsV1[0] = address(cErc20V1);
        hevm.prank(msg.sender);
        IComptrollerHarnessV1(address(unitrollerV1)).enterMarkets(marketsV1);
        address[] memory marketsV2 = new address[](1);
        marketsV2[0] = address(cErc20V2);
        hevm.prank(msg.sender);
        IComptrollerHarnessV2(address(unitrollerV2)).enterMarkets(marketsV2);
    }

    function CErc20_approve_underlying() public {
        ERC20 underlyingV1 = ERC20(cErc20V1.underlying());
        ERC20 underlyingV2 = ERC20(cErc20V2.underlying());
        require(underlyingV1.balanceOf(msg.sender) > 0 && underlyingV2.balanceOf(msg.sender) > 0);
        // Allowances
        hevm.prank(msg.sender);
        underlyingV1.approve(
            address(cErc20V1),
            type(uint256).max
        );
        hevm.prank(msg.sender);
        underlyingV2.approve(
            address(cErc20V2),
            type(uint256).max
        );
    }

    function upgradeV2() external override {
        unitrollerV2._setPendingImplementation(address(comptrollerHarnessV2));
        comptrollerHarnessV2._become(address(unitrollerV2));
        IComptrollerHarnessV2(address(unitrollerV2)).setCompAddress(address(compHarnessV2));
    }

    function ComptrollerHarness__supportMarket(address a) public override {
        bool listedV1 = IComptrollerHarnessV1(address(unitrollerV1)).isListed(a);
        bool listedV2 = IComptrollerHarnessV2(address(unitrollerV2)).isListed(a);
        require(!listedV1 && !listedV2);
        super.ComptrollerHarness__supportMarket(a);
    }

    function ComptrollerHarness_enterMarkets(address[] memory a) public override {
        require(a.length <= IComptrollerHarnessV1(address(unitrollerV1)).getAllMarkets().length);
        address[] memory a1 = new address[](a.length);
        address[] memory a2 = new address[](a.length);
        for(uint i = 0; i < a.length; i++) {
            a1[i] = IComptrollerHarnessV1(address(unitrollerV1)).allMarkets(i);
            a2[i] = IComptrollerHarnessV2(address(unitrollerV2)).allMarkets(i);
        }
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'enterMarkets(address[])', a1
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'enterMarkets(address[])', a2
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_exitMarket(address a) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'exitMarket(address)', a1
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'exitMarket(address)', a2
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_mintAllowed(address a, address b, uint256 c) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'mintAllowed(address,address,uint256)', a1, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'mintAllowed(address,address,uint256)', a2, b, c
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_redeemAllowed(address a, address b, uint256 c) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'redeemAllowed(address,address,uint256)', a1, b, c
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'redeemAllowed(address,address,uint256)', a2, b, c
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_borrowAllowed(address a, address b, uint256 c) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'borrowAllowed(address,address,uint256)', a1, b, c
            )
        );
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'borrowAllowed(address,address,uint256)', a2, b, c
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_repayBorrowAllowed(address a, address b, address c, uint256 d) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'repayBorrowAllowed(address,address,address,uint256)', a1, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'repayBorrowAllowed(address,address,address,uint256)', a2, b, c, d
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_liquidateBorrowAllowed(address a, address b, address c, address d, uint256 e) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        (address b1, address b2) = getTokenPair(b);
        require(b1 != address(0) && b2 != address(0));
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'liquidateBorrowAllowed(address,address,address,address,uint256)', a1, b1, c, d, e
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'liquidateBorrowAllowed(address,address,address,address,uint256)', a2, b2, c, d, e
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_seizeAllowed(address a, address b, address c, address d, uint256 e) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        (address b1, address b2) = getTokenPair(b);
        require(b1 != address(0) && b2 != address(0));
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'seizeAllowed(address,address,address,address,uint256)', a1, b1, c, d, e
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'seizeAllowed(address,address,address,address,uint256)', a2, b2, c, d, e
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_transferAllowed(address a, address b, address c, uint256 d) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'transferAllowed(address,address,address,uint256)', a1, b, c, d
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'transferAllowed(address,address,address,uint256)', a2, b, c, d
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_isListed(address a) public override {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        hevm.prank(msg.sender);
        (bool successV1, bytes memory outputV1) = address(unitrollerV1).call(
            abi.encodeWithSignature(
                'isListed(address)', a1
            )
        );
        hevm.prank(msg.sender);
        (bool successV2, bytes memory outputV2) = address(unitrollerV2).call(
            abi.encodeWithSignature(
                'isListed(address)', a2
            )
        );
        assert(successV1 == successV2);
        if(successV1 && successV2) {
            assert(keccak256(outputV1) == keccak256(outputV2));
        }
    }

    function ComptrollerHarness_getCompAddress() public override {}

    function ComptrollerHarness_getAllMarkets() public override {}
    
    function ComptrollerHarness_allMarkets(uint i) public override returns (address) {
        return address(0);
    }
    
    function ComptrollerHarness_compSpeeds(address a) public override returns (uint256) {
        (address a1, address a2) = getTokenPair(a);
        require(a1 != address(0) && a2 != address(0));
        assert(IComptrollerHarnessV1(address(unitrollerV1)).compSpeeds(a1) == IComptrollerHarnessV2(address(unitrollerV2)).compSpeeds(a2));
        return IComptrollerHarnessV1(address(unitrollerV1)).compSpeeds(a1);
    }

    function ComptrollerHarness_claimComp() public {
        address[] memory marketsV1 = IComptrollerHarnessV1(address(unitrollerV1)).getAssetsIn(msg.sender);
        address[] memory marketsV2 = IComptrollerHarnessV2(address(unitrollerV2)).getAssetsIn(msg.sender);
        require(marketsV1.length > 0 && marketsV2.length > 0);
        super.ComptrollerHarness_claimComp(msg.sender);
    }

    function ComptrollerHarness__setCompSpeeds(uint8 a, uint32 b) public {
        require(b > 0);
        address _a1 = address(cErc20V1);
        address _a2 = address(cErc20V2);
        address[] memory a2 = new address[](1);
        a2[0] = _a2;
        uint256[] memory b2 = new uint256[](1);
        uint256[] memory c2 = new uint256[](1);
        b2[0] = c2[0] = b;

        bool success2;
        bytes memory output2;
        if(unitrollerV2.comptrollerImplementation() == address(comptrollerHarnessV2)) {
            (success2, output2) = address(unitrollerV2).call(
                abi.encodeWithSelector(
                    comptrollerHarnessV2._setCompSpeeds.selector, a2, b2, c2
                )
            );
        } else {
            (success2, output2) = address(unitrollerV2).call(
            abi.encodeWithSelector(
                comptrollerHarnessV1._setCompSpeed.selector, _a2, b
            )
        );
        }
        (bool success1, bytes memory output1) = address(unitrollerV1).call(
            abi.encodeWithSelector(
                comptrollerHarnessV1._setCompSpeed.selector, _a1, b
            )
        );
        assert(success1 == success2);
        assert((!success1 && !success2) || keccak256(output1) == keccak256(output2));
    }

    function ComptrollerHarness_setCompAddress(address a) public override {}

    function CErc20_mint(uint256 a) public override {
        require(a > 0);
        ERC20 underlyingV1 = ERC20(cErc20V1.underlying());
        ERC20 underlyingV2 = ERC20(cErc20V2.underlying());
        require(underlyingV1.balanceOf(msg.sender) > 0 && underlyingV2.balanceOf(msg.sender) > 0);
        super.CErc20_mint(a);
    }

    function CompHarness_balanceOf(address a) public override {
        require(a != address(unitrollerV1) && a != address(unitrollerV2));
        super.CompHarness_balanceOf(a);
    }

    function getTokenPair(address a) internal returns (address a1, address a2) {
        a1 = address(0);
        a2 = address(0);
        uint marketsLen = IComptrollerHarnessV1(address(unitrollerV1)).getAllMarkets().length;
        for(uint i = 0; i < marketsLen; i++) {
            address m1 = IComptrollerHarnessV1(address(unitrollerV1)).allMarkets(i);
            address m2 = IComptrollerHarnessV2(address(unitrollerV2)).allMarkets(i);
            if (m1 == a || m2 == a) {
                a1 = m1;
                a2 = m2;
                break;
            }
        }
    }
}
