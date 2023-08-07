import os.path
import time
import json
import shutil
from pathlib import Path
from io import UnsupportedOperation
from os import mkdir
from subprocess import Popen, PIPE
from typing import List, Tuple

from diffusc.utils.crytic_print import CryticPrint


ECHIDNA_BIN_PATH = Path(__file__).resolve().parent.parent.parent / "bin" / "echidna"


def create_echidna_process(
    prefix: str, filename: str, contract: str, config: str, extra_args: List[str]
) -> Popen:
    try:
        mkdir(prefix)
    except OSError:
        pass

    call = ["echidna-diffusc"]
    call.extend([filename])
    call.extend(["--config", config])
    call.extend(["--contract", contract])
    call.extend(extra_args)
    if os.path.exists(os.path.join(prefix, "crytic-export", "etherscan-contracts")):
        shutil.rmtree(os.path.join(prefix, "crytic-export", "etherscan-contracts"))
    CryticPrint.print_information(f"* Calling echidna from {prefix} using {' '.join(call)}")
    return Popen(call, stderr=PIPE, stdout=PIPE, bufsize=0, cwd=prefix, universal_newlines=True)


def print_stderr(proc: Popen) -> None:
    try:
        assert proc.stderr is not None
        line = proc.stderr.readline()
        print(line.strip())
    except UnsupportedOperation:
        line = ""
    while line != "":
        try:
            assert proc.stderr is not None
            line = proc.stderr.readline()
            print(line.strip())
        except UnsupportedOperation:
            line = ""


def get_results_json(proc: Popen) -> dict:
    line = ""
    while not line.startswith("{"):
        try:
            assert proc.stdout is not None
            line = proc.stdout.readline()
        except UnsupportedOperation:
            line = ""
    if "Fetching Solidity" in line:
        line = line.split("Fetching")[0]
    return json.loads(line)


def run_timed_campaign(proc: Popen, minutes: int = 60) -> Tuple[int, int, dict | None]:
    tests = -1
    fuzzes = -1
    max_value = -1
    results = None
    start_time = time.time()
    while time.time() - start_time < minutes * 60:
        line = ""
        try:
            assert proc.stdout is not None
            line = proc.stdout.readline()
            print(line.strip())
        except UnsupportedOperation:
            pass
        if line == "" and proc.poll() is not None:
            break
        if "tests:" in line:
            _tests = line.split("tests: ")[1].split("/")[0]
            tests = int(_tests)
            _fuzzes = line.split("fuzzing: ")[1].split("/")[0]
            fuzzes = int(_fuzzes)
            if tests > max_value:
                if fuzzes == -1:
                    CryticPrint.print_information("* Reading initial bytecodes and slots..")
                elif max_value == -1:
                    CryticPrint.print_information("* Fuzzing campaign started!")
                max_value = tests
    if max_value == -1:  # pragma: no cover
        # Print Echidna error output before returning
        print_stderr(proc)
        return tests, fuzzes, results
    CryticPrint.print_information("* Terminating Echidna campaign!")
    proc.terminate()
    if max_value >= 0:
        # Read the final results of the campaign
        results = get_results_json(proc)
    return tests, fuzzes, results


def run_echidna_campaign(
    proc: Popen, min_tests: int = 1, max_len: int = 25000
) -> Tuple[int, int, dict | None]:
    keep_running = True
    fuzzes = -1
    max_value = -1
    results = None
    while keep_running:
        line = ""
        try:
            assert proc.stdout is not None
            line = proc.stdout.readline()
            print(line.strip())
        except UnsupportedOperation:
            pass
        if line == "":
            keep_running = proc.poll() is None
        elif "tests:" in line:
            _tests = line.split("tests: ")[1].split("/")[0]
            tests = int(_tests)
            _fuzzes = line.split("fuzzing: ")[1].split("/")[0]
            fuzzes = int(_fuzzes)
            keep_running = fuzzes <= max_len
            if tests > max_value:
                max_value = tests
                if fuzzes > 0:
                    CryticPrint.print_information("* Fuzzing campaign started!")
                if max_value >= min_tests:
                    CryticPrint.print_success(
                        f"* Failed {max_value} tests after {fuzzes} rounds of fuzzing!"
                    )
                    keep_running = (
                        False  # Useful for quick CI tests, but it will be removed in production
                    )
    if max_value == -1:  # pragma: no cover
        # Print Echidna error output before returning
        try:
            assert proc.stderr is not None
            line = proc.stderr.readline()
            print(line.strip())
        except UnsupportedOperation:
            line = ""
        while line != "":
            try:
                assert proc.stderr is not None
                line = proc.stderr.readline()
                print(line.strip())
            except UnsupportedOperation:
                line = ""

    CryticPrint.print_information("* Terminating Echidna campaign!")
    proc.terminate()
    if max_value >= 0:
        # Read the final results of the campaign
        results = get_results_json(proc)
    return max_value, fuzzes, results
