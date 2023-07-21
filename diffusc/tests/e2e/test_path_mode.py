import os
import sys
from shutil import rmtree
from pathlib import Path

import pytest
from diffusc.diffusc import main


TEST_DATA_DIR = Path(__file__).resolve().parent.parent / "test_data"


def test_diffusc_path_mode() -> None:
    output_dir = os.path.join(TEST_DATA_DIR, "output")
    expected_dir = os.path.join(TEST_DATA_DIR, "expected")
    os.makedirs(output_dir, exist_ok=True)

    # Test w/o proxy, additional targets, upgrade function or protected functions
    args = [
        os.path.join(TEST_DATA_DIR, "ContractV1.sol"),
        os.path.join(TEST_DATA_DIR, "ContractV2.sol"),
        "-d",
        output_dir,
        "-V",
        "0.8.2",
    ]
    assert main(args) == 0
    with open(os.path.join(expected_dir, "Expected_PathMode_0.sol"), "r", encoding="utf-8") as file:
        expected = file.read()
    with open(os.path.join(output_dir, "DiffFuzzUpgrades.sol"), "r", encoding="utf-8") as file:
        actual = file.read()
    assert actual == expected

    # Test w/ proxy and upgrade function, w/o additional targets or protected functions
    args.extend(
        [
            "-p",
            os.path.join(TEST_DATA_DIR, "TransparentUpgradeableProxy.sol"),
            "-u",
        ]
    )
    assert main(args) == 0
    with open(os.path.join(expected_dir, "Expected_PathMode_1.sol"), "r", encoding="utf-8") as file:
        expected = file.read()
    with open(os.path.join(output_dir, "DiffFuzzUpgrades.sol"), "r", encoding="utf-8") as file:
        actual = file.read()
    assert actual == expected

    # Test w/ additional targets, w/o proxy, upgrade function, protected functions
    args[6] = "-t"
    args[7] = ",".join(
        [
            os.path.join(TEST_DATA_DIR, "token", "MarketToken.sol"),
            os.path.join(TEST_DATA_DIR, "SimplePriceOracle.sol"),
        ]
    )
    assert main(args) == 0
    with open(os.path.join(expected_dir, "Expected_PathMode_2.sol"), "r", encoding="utf-8") as file:
        expected = file.read()
    with open(os.path.join(output_dir, "DiffFuzzUpgrades.sol"), "r", encoding="utf-8") as file:
        actual = file.read()
    assert actual == expected

    # Test w/ additional targets, external taint and protected functions, w/o proxy, upgrade function
    args.extend(
        [
            "-x",
            "-P",
        ]
    )
    assert main(args) == 0
    with open(os.path.join(expected_dir, "Expected_PathMode_3.sol"), "r", encoding="utf-8") as file:
        expected = file.read()
    with open(os.path.join(output_dir, "DiffFuzzUpgrades.sol"), "r", encoding="utf-8") as file:
        actual = file.read()
    assert actual == expected

    # Test w/ proxy, additional targets, external taint, protected functions and upgrade function
    args.extend(
        [
            "-p",
            os.path.join(TEST_DATA_DIR, "TransparentUpgradeableProxy.sol"),
            "-L",
            "999999999",
            "-l",
            "99",
        ]
    )
    assert main(args) == 0
    with open(os.path.join(expected_dir, "Expected_PathMode_4.sol"), "r", encoding="utf-8") as file:
        expected = file.read()
    with open(os.path.join(output_dir, "DiffFuzzUpgrades.sol"), "r", encoding="utf-8") as file:
        actual = file.read()
    assert actual == expected
    # Check the config file too
    with open(
        os.path.join(expected_dir, "ExpectedConfig_PathMode_4.yaml"), "r", encoding="utf-8"
    ) as file:
        expected_lines = file.readlines()
    with open(os.path.join(output_dir, "CryticConfig.yaml"), "r", encoding="utf-8") as file:
        actual_lines = file.readlines()
    for idx, line in enumerate(expected_lines):
        if not (line.startswith("sender") or line.startswith("corpusDir")):
            assert actual_lines[idx] == line


@pytest.mark.skipif(sys.platform.startswith("win"), reason="Run Echidna on Linux only")
def test_diffusc_path_run_mode() -> None:
    output_dir = os.path.join(TEST_DATA_DIR, "output")
    safemoon_dir = os.path.join(TEST_DATA_DIR, "safemoon")
    os.makedirs(output_dir, exist_ok=True)

    # Remove the crytic-export directory if it exists
    parent_dirs = Path(__file__).resolve().parents
    for parent in parent_dirs:
        export_dir = os.path.join(parent, "crytic-export")
        if os.path.exists(export_dir):
            rmtree(export_dir)

    args = [
        os.path.join(safemoon_dir, "SafemoonV2.sol"),
        os.path.join(safemoon_dir, "SafemoonV3.sol"),
        "-p",
        os.path.join(safemoon_dir, "TransparentProxyTestHarness.sol"),
        "-V",
        "0.8.11",
        "-d",
        output_dir,
        "--run-custom",
        os.path.join(safemoon_dir, "DiffFuzzCustomInit.sol"),
        "DiffFuzzInit",
        "-r",
        "10",
    ]
    assert main(args) == 0
