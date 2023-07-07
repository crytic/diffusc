from typing import List

from diffusc.utils.crytic_print import CryticPrint, PrintMode


TRANSFER_SIGS = {
    "Transfer": "Transfer",
    "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef": "Transfer(address,address,uint256)",
    "0x138dbc8474f748db86063dcef24cef1495bc73385a946f8d691128085e5ebec2": "Transfer(address,uint256,address)",
    "0x0a429aba3d89849a2db0153e4534d95c46a1d83c8109d73893f55ebc44010ff4": "Transfer(uint256,address,address)",
}


class ReportGenerator:
    """
    Expects results from Echidna JSON output in the following format (using ../../bin/echidna):

    Campaign = {
      "success"      : bool,
      "error"        : string?,
      "tests"        : [Test],
      "seed"         : number,
      "coverage"     : Coverage,
      "gas_info"     : [GasInfo]
    }
    Test = {
      "contract"     : string,
      "name"         : string,
      "status"       : string,
      "error"        : string?,
      "events"       : [string],
      "testType"     : string,
      "transactions" : [Transaction]?
    }
    Transaction = {
      "contract"     : string,
      "function"     : string,
      "arguments"    : [string]?,
      "gas"          : number,
      "gasprice"     : number
    }
    """

    @staticmethod
    def report_from_json_results(results: dict, new_funcs: List[str] = None) -> None:
        if new_funcs is None:
            new_funcs = []
        assert "tests" in results
        for test in results["tests"]:
            assert isinstance(test, dict)
            if test["status"] in ["solved", "shrinking"]:
                events: List[str] = test["events"]
                txs: List[dict] = test["transactions"]
                name = txs[len(txs) - 1]["function"]
                if any(sig in event for event in events for sig in TRANSFER_SIGS):
                    print_mode = PrintMode.ERROR
                    CryticPrint.print_error(
                        f"* Found different behavior in {name}!\n"
                        f"  * This test involves a token transfer event (impact: HIGH)\n"
                        f"  * Test status: {test['status']}\n"
                        f"  * Tx sequence:"
                    )
                elif any(tx["function"] in new_funcs for tx in txs):
                    print_mode = PrintMode.INFORMATION
                    CryticPrint.print_information(
                        f"* Found different behavior in {name}!\n"
                        f"  * This test involves a call to a new state-modifying function, and may be expected\n"
                        f"  * Test status: {test['status']}\n"
                        f"  * Tx sequence:"
                    )
                else:
                    print_mode = PrintMode.WARNING
                    CryticPrint.print_warning(
                        f"* Found different behavior in {name}!\n"
                        f"  * No token transfers found, please review to determine impact\n"
                        f"  * Test status: {test['status']}\n"
                        f"  * Tx sequence:"
                    )
                for tx in txs:
                    try:
                        CryticPrint.print(
                            print_mode, f"    {tx['function']}({','.join(tx['arguments'])})"
                        )
                    except TypeError:
                        CryticPrint.print(print_mode, f"    {tx['function']}()")
                CryticPrint.print(print_mode, "  * Event sequence:")
                for event in events:
                    if event in TRANSFER_SIGS:
                        event += f" ({TRANSFER_SIGS[event]})"
                    CryticPrint.print(print_mode, f"    {event}")
