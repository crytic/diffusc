#!/usr/bin/env python3

"""Main module"""

import argparse
import logging
import os
import sys
from typing import Sequence, Optional

from solc_select.solc_select import switch_global_version
from eth_utils import is_address
from diffusc.core.path_mode import PathMode
from diffusc.core.fork_mode import ForkMode
from diffusc.core.hybrid_mode import HybridMode
from diffusc.core.analysis_mode import AnalysisMode
from diffusc.core.code_generation import CodeGenerator
from diffusc.core.report_generation import ReportGenerator
from diffusc.utils.helpers import write_to_file
from diffusc.utils.crytic_print import CryticPrint
from diffusc.core.echidna import create_echidna_process, run_timed_campaign, run_echidna_campaign
import diffusc.utils.network_vars as net_vars


# pylint: disable=too-many-statements,too-many-branches,too-many-locals
def main(_args: Optional[Sequence[str]] = None) -> int:
    """Main method, parses arguments and calls path_mode or fork_mode."""
    # Read command line arguments

    parser = argparse.ArgumentParser(
        prog="diff-fuzz-upgrades",
        description="Generate differential fuzz testing contract for comparing two upgradeable contract versions.",
    )

    parser.add_argument("v1", help="The original version of the contract.")
    parser.add_argument("v2", help="The upgraded version of the contract.")
    parser.add_argument("-p", "--proxy", dest="proxy", help="Specifies the proxy contract to use.")
    parser.add_argument(
        "-t",
        "--targets",
        dest="targets",
        help="Specifies the additional contracts to target.",
    )
    parser.add_argument(
        "-d",
        "--output-dir",
        dest="output_dir",
        help="Specifies the directory where the generated test contract and config file are saved.",
    )
    parser.add_argument(
        "-A",
        "--contract-addr",
        dest="contract_addr",
        help="Specifies the address to which to deploy the test contract.",
    )
    parser.add_argument(
        "-V",
        "--solc-version",
        dest="version",
        help="Specifies the solc version to use in the test contract (default is 0.8.0).",
    )
    parser.add_argument(
        "-u",
        "--fuzz-upgrade",
        dest="fuzz_upgrade",
        action="store_true",
        help="Specifies whether to upgrade the proxy to the V2 during fuzzing (default is False). Requires a proxy.",
    )
    parser.add_argument(
        "-L",
        "--campaign-length",
        dest="campaign_len",
        help="Specifies the campaign length to use with Echidna. Default is 1000000000000.",
    )
    parser.add_argument(
        "-l",
        "--seq-length",
        dest="seq_len",
        help="Specifies the sequence length to use with Echidna. Default is 100.",
    )
    parser.add_argument(
        "-n",
        "--network",
        dest="network",
        help="Specifies the network where the contracts are deployed. Valid values: "
        + ", ".join(net_vars.SUPPORTED_NETWORKS),
    )
    parser.add_argument(
        "-b",
        "--block",
        dest="block",
        help="Specifies the block number to fetch the contracts from. If not specified and RPC is available, latest block will be used.",
    )
    parser.add_argument(
        "-R",
        "--rpc",
        dest="network_rpc",
        help="Specifies network RPC endpoint for reading operations.",
    )
    parser.add_argument(
        "-T",
        "--token-holders",
        dest="holders",
        action="store_true",
        help="Specifies whether to automatically detect token holders to send transactions from when fuzzing "
        "(default false).",
    )
    parser.add_argument(
        "--token-holder",
        dest="holder",
        help="Manually specifies a token holder address to use when sending transactions in Echidna.",
    )
    parser.add_argument(
        "--min-token-balance",
        dest="min_tokens",
        help="Specifies the minimum token balance required when searching for holders (default 10000).",
    )
    parser.add_argument(
        "--max-token-holders",
        dest="max_holders",
        help="Specifies the maximum number of holders to find per token (default 5).",
    )
    parser.add_argument(
        "-P",
        "--protected",
        dest="include_protected",
        action="store_true",
        help="Specifies whether to include wrappers for protected functions (default false).",
    )
    parser.add_argument(
        "-K",
        "--etherscan-key",
        dest="etherscan_key",
        help="Specifies the API key to use with Etherscan.",
    )
    parser.add_argument(
        "-r",
        "--run",
        dest="run_duration",
        nargs="?",
        const=60,
        type=int,
        help="Specifies whether to run Echidna on the generated test contract (default false). Accepts an optional "
        "arg specifying the fuzzing campaign duration in minutes (default 60 if flag is present without args).",
    )
    parser.add_argument(
        "--run-custom",
        dest="run_custom",
        nargs=2,
        help="Runs Echidna on the given contract (i.e., one which inherits the generated test contract). Takes two args"
        ": the file path followed by the contract name, e.g., `--run-custom ./DiffFuzzCustom.sol DiffFuzzCustom`. "
        "Use with `-r <MINUTES>` to specify a campaign duration.",
    )
    parser.add_argument(
        "-W",
        "--workers",
        dest="workers",
        type=int,
        default=1,
        help="Specifies how many workers Echidna should use in run mode (default 1).",
    )
    parser.add_argument(
        "-x",
        "--external-taint",
        dest="external_taint",
        action="store_true",
        help="Specifies whether to analyze external calls to find tainted external contracts (default false).",
    )
    parser.add_argument(
        "--ignore-diff",
        dest="ignore_diff",
        action="store_true",
        help="Specifies whether to ignore the diff and include wrappers for all functions, not just those affected by "
        "the change (default false). Mostly useful for tool evaluation.",
    )
    parser.add_argument(
        "--senders",
        dest="senders",
        help="Specifies one or more addresses for the fuzzer to send transactions from, separated by commas (default: "
        "0x1000,0x2000,0x3000).",
    )
    parser.add_argument(
        "--first-failure",
        action="store_true",
        help="Specifies whether to end the fuzzing campaign (in run mode) as soon as an invariant is broken, rather "
        "than running a timed campaign. Included primarily for continuous integration testing.",
    )

    args = parser.parse_args(_args)

    CryticPrint.initialize()
    CryticPrint.print_message("\nWelcome to diff-fuzz-upgrades, enjoy your stay!")
    CryticPrint.print_message("===============================================\n")

    # Silence Slither Read Storage
    logging.getLogger("Slither-read-storage").setLevel(logging.CRITICAL)

    output_dir = "./"
    if args.output_dir is not None:
        output_dir = args.output_dir
        if not str(output_dir).endswith(os.path.sep):
            output_dir += os.path.sep

    seq_len = 100
    if args.seq_len:
        if str(args.seq_len).isnumeric():
            seq_len = int(args.seq_len)
        else:  # pragma: no cover
            CryticPrint.print_error(
                "\n* Sequence length provided is not numeric. Defaulting to 100.",
            )

    test_len = 1000000000000
    if args.campaign_len:
        if str(args.campaign_len).isnumeric():
            test_len = int(args.campaign_len)
        else:  # pragma: no cover
            CryticPrint.print_error(
                "\n* Campaign length provided is not numeric. Defaulting to 100.",
            )

    contract_addr = ""
    if args.contract_addr and is_address(args.contract_addr):
        contract_addr = args.contract_addr
        CryticPrint.print_information(
            "\n* Exploit contract address specified via command line parameter: "
            f"{contract_addr}",
        )

    senders = []
    if args.senders:
        for sender in str(args.senders).split(","):
            if is_address(sender):
                senders.append(sender)
            else:
                CryticPrint.print_error(
                    f"\n* Provided sender {sender} is not an address, skipping...",
                )

    # Start the analysis
    analysis: AnalysisMode
    CryticPrint.print_information("* Inspecting V1 and V2 contracts:")
    if is_address(args.v1) and is_address(args.v2):
        CryticPrint.print_information("* Using 'fork mode':")
        try:
            analysis = ForkMode(args)
            contract = analysis.write_test_contract()
        except (ValueError, AssertionError) as err:
            CryticPrint.print_error(f"* Error: fork mode failed ({err})")
            return 1
    elif is_address(args.v1) and os.path.exists(args.v2):
        CryticPrint.print_information("* Using 'hybrid mode':")
        try:
            analysis = HybridMode(args)
            contract = analysis.write_test_contract()
        except (ValueError, AssertionError) as err:
            CryticPrint.print_error(f"* Error: hybrid mode failed ({err})")
            return 1
    elif os.path.exists(args.v1) and os.path.exists(args.v2):
        CryticPrint.print_information("* Using 'path mode' (no fork):")
        analysis = PathMode(args)
        contract = analysis.write_test_contract()
    elif not os.path.exists(args.v1):  # pragma: no cover
        CryticPrint.print_error(f"\nFile not found: {args.v1}")
        raise FileNotFoundError(args.v1)
    else:  # pragma: no cover
        CryticPrint.print_error(f"\nFile not found: {args.v2}")
        raise FileNotFoundError(args.v2)

    write_to_file(f"{output_dir}DiffFuzzUpgrades.sol", contract)
    CryticPrint.print_success(
        f"  * Fuzzing contract generated and written to {output_dir}DiffFuzzUpgrades.sol.",
    )

    if isinstance(analysis, (ForkMode, HybridMode)):
        if analysis.token_holders is not None:
            senders += analysis.token_holders
        config_file = CodeGenerator.generate_config_file(
            f"{output_dir}corpus",
            test_len,
            contract_addr,
            seq_len,
            block=analysis.block_number,
            rpc_url=analysis.network_rpc,
            senders=senders,
            output_dir=output_dir,
        )
    else:
        config_file = CodeGenerator.generate_config_file(
            f"{output_dir}corpus",
            test_len,
            contract_addr,
            seq_len,
            senders=senders,
            output_dir=output_dir,
        )
    if isinstance(analysis, HybridMode):
        config_file += (
            "deployContracts: [['0x0102030405060708091011121314151617181920', "
            f"'{analysis.v2_contract_name}']]\n"
        )
    write_to_file(f"{output_dir}CryticConfig.yaml", config_file)
    CryticPrint.print_success(
        f"  * Echidna configuration file generated and written to {output_dir}CryticConfig.yaml.",
    )

    if args.run_duration or args.run_custom:
        run_duration = 60
        if args.run_duration:
            run_duration = args.run_duration
        workers = args.workers
        if isinstance(analysis, ForkMode):
            # In fork mode, there are no dependency files to worry about, so run Echidna from output dir
            prefix = output_dir
            config = "CryticConfig.yaml"
            contract_file = "DiffFuzzUpgrades.sol"
        elif isinstance(analysis, HybridMode):
            contract_file = (
                args.run_custom[0] if args.run_custom else f"{output_dir}DiffFuzzUpgrades.sol"
            )
            output_dir = os.path.relpath(output_dir, os.path.curdir)
            prefix = os.path.commonpath([output_dir, args.v2])
            prefix = os.path.abspath(prefix)
            config = os.path.relpath(os.path.join(output_dir, "CryticConfig.yaml"), prefix)
            contract_file = os.path.relpath(contract_file, prefix)
        else:
            # In path mode, we need to run Echidna from a dir with access to dependencies as well as test contract
            contract_file = (
                args.run_custom[0] if args.run_custom else f"{output_dir}DiffFuzzUpgrades.sol"
            )
            output_dir = os.path.relpath(output_dir, os.path.curdir)
            prefix = os.path.commonpath([output_dir, analysis.dependencies_common_path()])
            prefix = os.path.abspath(prefix)
            config = os.path.relpath(os.path.join(output_dir, "CryticConfig.yaml"), prefix)
            contract_file = os.path.relpath(contract_file, prefix)
        CryticPrint.print_information(
            f"* Run mode enabled. Starting Echidna with {run_duration} minute time limit..."
        )
        if analysis.version:
            switch_global_version(analysis.version, always_install=True)
        proc = create_echidna_process(
            prefix,
            contract_file,
            args.run_custom[1] if args.run_custom else "DiffFuzzUpgrades",
            config,
            ["--format", "json", "--workers", str(workers)],
        )
        if args.first_failure:
            max_value, fuzzes, results = run_echidna_campaign(proc)
        else:
            max_value, fuzzes, results = run_timed_campaign(proc, run_duration)
        if max_value <= 0:
            CryticPrint.print_error(
                f"* Echidna failed to find a difference after {fuzzes} rounds of fuzzing"
            )
            return 1
        if results is not None and analysis.code_generator is not None:
            new_funcs = analysis.code_generator.new_func_wrappers
            ReportGenerator.report_from_json_results(results, new_funcs)

    CryticPrint.print_message(
        "\n-----------------------------------------------------------",
    )
    CryticPrint.print_message(
        "My work here is done. Thanks for using me, have a nice day!",
    )
    CryticPrint.print_message(
        "-----------------------------------------------------------",
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
