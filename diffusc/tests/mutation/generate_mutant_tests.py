import os
import sys
from pathlib import Path

from diffusc.diffusc import main


TEST_DATA_DIR = Path(__file__).resolve().parent


def generate_standard_test(
    test_path: str, mutant_path: str, original_path: str, proxy_path: str
) -> None:
    args = [original_path, mutant_path, "-p", proxy_path, "-d", test_path, "-v", "0.8.11", "-P"]
    assert main(args) == 0


def generate_fork_test(
    test_path: str, mutant_path: str, original_address: str, proxy_address: str
) -> None:
    api_key = os.getenv("ETHERSCAN_API_KEY") or ""
    rpc_url = os.getenv("ECHIDNA_RPC_URL") or ""
    args = [
        original_address,
        mutant_path,
        "-p",
        proxy_address,
        "-d",
        test_path,
        "-v",
        "0.8.11",
        "-n",
        "bsc",
        "-b",
        "28720396",
        "-R",
        rpc_url,
        "-K",
        api_key,
        "-P",
        "-T",
    ]
    assert main(args) == 0


def generate_all_tests(update: bool = False) -> None:
    for d_name in os.listdir(TEST_DATA_DIR):
        # Iterate over project directories, i.e., safemoon
        dir_path = os.path.join(TEST_DATA_DIR, d_name)
        mutants_path = os.path.join(dir_path, "mutants")
        if os.path.isdir(dir_path) and os.path.isdir(mutants_path):
            tests_dir = os.path.join(dir_path, "tests")
            for f_name in os.listdir(mutants_path):
                # Iterate over mutants
                mutant_path = os.path.join(mutants_path, f_name)
                test_dir = os.path.join(tests_dir, f_name.replace(".sol", ""))
                os.makedirs(test_dir, exist_ok=True)
                original_path = os.path.join(dir_path, f_name.rsplit("_", maxsplit=1)[0] + ".sol")
                proxy_path = os.path.join(dir_path, "TransparentProxyTestHarness.sol")
                standard_path = os.path.join(test_dir, "standard")
                fork_path = os.path.join(test_dir, "fork")
                if update or not os.path.exists(
                    os.path.join(standard_path, "DiffFuzzUpgrades.sol")
                ):
                    generate_standard_test(standard_path, mutant_path, original_path, proxy_path)
                if update or not os.path.exists(os.path.join(fork_path, "DiffFuzzUpgrades.sol")):
                    generate_fork_test(
                        fork_path,
                        mutant_path,
                        "0x00790bf8b7Fad21cE3A101CB39Ba6Fb89578a146",
                        "0x42981d0bfbAf196529376EE702F2a9Eb9092fcB5",
                    )


if __name__ == "__main__":  # pragma: no cover
    if len(sys.argv) != 2 or sys.argv[1] not in ["--overwrite", "--generate"]:
        print(
            "To re-generate all the expected artifacts run\n\tpython tests/unit/core/test_code_generation --overwrite"
        )
    elif sys.argv[1] == "--overwrite":
        generate_all_tests(update=True)
    elif sys.argv[1] == "--generate":
        generate_all_tests(update=False)
