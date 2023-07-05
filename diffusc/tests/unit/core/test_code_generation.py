import os
import json
import sys
from random import random
from time import sleep
from pathlib import Path

from solc_select import solc_select
from slither import Slither
from diffusc.core.code_generation import CodeGenerator
from diffusc.utils.classes import ContractData, SlotInfo
from diffusc.utils.helpers import do_diff
from diffusc.utils.from_address import get_contract_data_from_address
from diffusc.utils.from_path import get_contract_data_from_path
from diffusc.utils.slither_provider import FileSlitherProvider, NetworkSlitherProvider
from diffusc.utils.network_info_provider import NetworkInfoProvider


TEST_DATA_DIR = Path(__file__).resolve().parent.parent.parent / "test_data"
TEST_CONTRACTS = {"CodeGeneration.sol": "0.8.4", "TransparentUpgradeableProxy.sol": "0.8.0"}


def test_interface_from_file(update: bool = False) -> None:
    for test, version in TEST_CONTRACTS.items():
        solc_select.switch_global_version(version, always_install=True)
        file_path = os.path.join(TEST_DATA_DIR, test)
        sl = Slither(file_path)
        contract = sl.get_contract_from_name(test.replace(".sol", ""))[0]
        contract_data = ContractData(
            contract_object=contract,
            slither=sl,
            path=contract.file_scope.filename.absolute,
            valid_data=True,
            is_proxy=False,
            is_erc20=False,
            suffix="",
        )  # type: ignore[typeddict-item]
        contract_data = CodeGenerator.get_contract_interface(contract_data)
        expected_file = os.path.join(TEST_DATA_DIR, f"I{test}")
        if update:  # pragma: no cover
            with open(expected_file, "w", encoding="utf-8") as file:
                file.write(contract_data["interface"])
        with open(expected_file, "r", encoding="utf-8") as file:
            expected = file.read()
        assert contract_data["interface"] == expected


def test_contract_data_from_slither(update: bool = False) -> None:
    for test, version in TEST_CONTRACTS.items():
        solc_select.switch_global_version(version, always_install=True)
        file_path = os.path.join(TEST_DATA_DIR, test)
        sl = Slither(file_path)
        contract = sl.get_contract_from_name(test.replace(".sol", ""))[0]
        contract_data = CodeGenerator.get_contract_data(contract)
        assert contract_data["valid_data"]
        assert isinstance(contract_data["slither"], Slither)
        assert contract_data["slither"].crytic_compile == sl.crytic_compile
        assert contract_data["path"] == os.path.relpath(file_path)
        assert contract_data["name"] == test.replace(".sol", "")
        assert contract_data["interface_name"] == "I" + test.replace(".sol", "")
        assert contract_data["solc_version"] == version
        expected_file = os.path.join(TEST_DATA_DIR, f"I{test}")
        if update:  # pragma: no cover
            with open(expected_file, "w", encoding="utf-8") as file:
                assert contract_data["interface"] is not None
                file.write(contract_data["interface"])
        with open(expected_file, "r", encoding="utf-8") as file:
            expected_interface = file.read()
        assert contract_data["interface"] == expected_interface
        if contract.is_upgradeable_proxy:
            assert contract_data["is_proxy"]
            assert isinstance(contract_data["implementation_slot"], SlotInfo)


def test_args_and_returns(update: bool = False) -> None:
    solc_select.switch_global_version("0.8.4", always_install=True)
    file_path = os.path.join(TEST_DATA_DIR, "CodeGeneration.sol")
    sl = Slither(file_path)
    contract = sl.get_contract_from_name("CodeGeneration")[0]
    results = {}
    for func in contract.functions_entry_points:
        results[func.canonical_name] = {
            "args": CodeGenerator.get_solidity_function_parameters(func.parameters),
            "rets": CodeGenerator.get_solidity_function_returns(func.return_type),
        }
    expected_path = os.path.join(TEST_DATA_DIR, "expected", "test_args_and_returns.json")
    if update:  # pragma: no cover
        with open(expected_path, "w", encoding="utf-8") as expected_file:
            expected_file.write(json.dumps(results, indent=4))
    with open(expected_path, "r", encoding="utf-8") as file:
        expected_results = json.load(file)
    assert results == expected_results


# pylint: disable=too-many-statements
def test_generate_contract_path_mode(update: bool = False) -> None:
    provider = FileSlitherProvider()
    output_dir = os.path.join(TEST_DATA_DIR, "expected")
    v1_data = get_contract_data_from_path(
        os.path.join(TEST_DATA_DIR, "ContractV1.sol"), output_dir, provider, "V1"
    )
    v2_data = get_contract_data_from_path(
        os.path.join(TEST_DATA_DIR, "ContractV2.sol"), output_dir, provider, "V2"
    )
    proxy_data = get_contract_data_from_path(
        os.path.join(TEST_DATA_DIR, "TransparentUpgradeableProxy.sol"), output_dir, provider
    )
    market_data = get_contract_data_from_path(
        os.path.join(TEST_DATA_DIR, "token", "MarketToken.sol"), output_dir, provider
    )
    oracle_data = get_contract_data_from_path(
        os.path.join(TEST_DATA_DIR, "SimplePriceOracle.sol"), output_dir, provider
    )

    assert v1_data["valid_data"] and v2_data["valid_data"]
    diff = do_diff(v1_data, v2_data)

    # Test code generation w/o proxy, additional targets, upgrade function or protected functions
    generator = CodeGenerator(v1_data, v2_data, "path", "0.8.2", False, False)
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_0.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_0.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ proxy and upgrade function, w/o additional targets or protected functions
    generator = CodeGenerator(v1_data, v2_data, "path", "0.8.2", True, False)
    assert proxy_data["valid_data"]
    generator.proxy = proxy_data
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_1.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_1.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ additional targets, w/o proxy, upgrade function, protected functions
    generator = CodeGenerator(v1_data, v2_data, "path", "0.8.2", False, False)
    assert market_data["valid_data"] and oracle_data["valid_data"]
    generator.targets = [market_data, oracle_data]
    diff = do_diff(v1_data, v2_data, [market_data, oracle_data])
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_2.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_2.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ additional targets, external taint and protected functions, w/o proxy, upgrade function
    generator = CodeGenerator(v1_data, v2_data, "path", "0.8.2", False, True)
    generator.targets = [market_data, oracle_data]
    diff = do_diff(v1_data, v2_data, [market_data, oracle_data], include_external=True)
    code = generator.generate_test_contract(diff, output_dir)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_3.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_3.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ proxy, additional targets, external taint, protected functions and upgrade function
    generator = CodeGenerator(v1_data, v2_data, "path", "0.8.2", True, True)
    generator.targets = [market_data, oracle_data]
    generator.proxy = proxy_data
    code = generator.generate_test_contract(diff, output_dir)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_4.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_PathMode_4.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code


# pylint: disable=too-many-statements
def test_generate_contract_fork_mode(update: bool = False) -> None:
    api_key = os.getenv("BSC_API_KEY") or ""
    rpc_url = os.getenv("BSC_RPC_URL") or ""
    provider = NetworkSlitherProvider("bsc:", api_key)
    net_info = NetworkInfoProvider(rpc_url, 26857408, is_poa=True)

    v1_data = get_contract_data_from_address(
        "0x0296201bfdfb410c29ef30bcae1b395537aeeb31", "", provider, net_info, "V1"
    )
    sleep(random() * 3)
    v2_data = get_contract_data_from_address(
        "0xEb11a0a0beF1AC028B8C2d4CD64138DD5938cA7A", "", provider, net_info, "V2"
    )
    sleep(random() * 3)
    proxy_data = get_contract_data_from_address(
        "0x42981d0bfbAf196529376EE702F2a9Eb9092fcB5", "", provider, net_info
    )
    sleep(random() * 3)
    swap_router_data = get_contract_data_from_address(
        "0x6ac68913d8fccd52d196b09e6bc0205735a4be5f",
        "0xaa62468f41d9f1076920feb60b561a84ce62e9c3",
        provider,
        net_info,
    )
    sleep(random() * 3)
    trade_router_data = get_contract_data_from_address(
        "0x524bc73fcb4fb70e2e84dc08efe255252a3b026e",
        "0x8d63502B5E50f8F100C407B34ef16bF808DFA278",
        provider,
        net_info,
    )

    assert v1_data["valid_data"] and v2_data["valid_data"]
    diff = do_diff(v1_data, v2_data)

    # Test code generation w/o proxy, additional targets, upgrade function or protected functions
    generator = CodeGenerator(v1_data, v2_data, "fork", "0.8.11", False, False, net_info)
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_0.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_0.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ proxy and upgrade function, w/o additional targets or protected functions
    generator = CodeGenerator(v1_data, v2_data, "fork", "0.8.11", True, False, net_info)
    assert proxy_data["valid_data"]
    generator.proxy = proxy_data
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_1.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_1.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ additional targets, w/o proxy, upgrade function, protected functions
    generator = CodeGenerator(v1_data, v2_data, "fork", "0.8.11", False, False, net_info)
    assert swap_router_data["valid_data"] and trade_router_data["valid_data"]
    generator.targets = [swap_router_data, trade_router_data]
    diff = do_diff(v1_data, v2_data, [swap_router_data, trade_router_data])
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_2.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_2.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ additional targets, external taint and protected functions, w/o proxy, upgrade function
    generator = CodeGenerator(v1_data, v2_data, "fork", "0.8.11", False, True, net_info)
    generator.targets = [swap_router_data, trade_router_data]
    diff = do_diff(v1_data, v2_data, [swap_router_data, trade_router_data], include_external=True)
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_3.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_3.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code

    # Test code generation w/ proxy, additional targets, external taint, protected functions and upgrade function
    generator = CodeGenerator(v1_data, v2_data, "fork", "0.8.11", True, True, net_info)
    generator.targets = [swap_router_data, trade_router_data]
    generator.proxy = proxy_data
    code = generator.generate_test_contract(diff)
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_4.sol"),
            "w",
            encoding="utf-8",
        ) as expected:
            expected.write(code)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "Expected_ForkMode_4.sol"), "r", encoding="utf-8"
    ) as expected:
        expected_code = expected.read()
    assert code == expected_code


def test_generate_config(update: bool = False) -> None:
    config = CodeGenerator.generate_config_file(
        corpus_dir="",
        campaign_length=123456,
        contract_addr="0x999999",
        seq_len=999999,
        block=12345678,
        rpc_url="https://mainnet.infura.io/v3/1234567891011121314151617181920",
        senders=["0x0123", "0x4567", "0x8910"],
    )
    if update:  # pragma: no cover
        with open(
            os.path.join(TEST_DATA_DIR, "expected", "ExpectedConfig.yaml"), "w", encoding="utf-8"
        ) as expected:
            expected.write(config)
    with open(
        os.path.join(TEST_DATA_DIR, "expected", "ExpectedConfig.yaml"), "r", encoding="utf-8"
    ) as file:
        expected = file.read()  # type: ignore[assignment]
    assert config == expected


def run_all_tests(update: bool = False) -> None:  # pragma: no cover
    test_generate_config(update)
    test_generate_contract_fork_mode(update)
    test_generate_contract_path_mode(update)
    test_args_and_returns(update)
    test_contract_data_from_slither(update)
    test_interface_from_file(update)


if __name__ == "__main__":  # pragma: no cover
    if len(sys.argv) != 2 or sys.argv[1] not in ["--overwrite"]:
        print(
            "To re-generate all the expected artifacts run\n\tpython tests/unit/core/test_code_generation --overwrite"
        )
    elif sys.argv[1] == "--overwrite":
        run_all_tests(update=True)
