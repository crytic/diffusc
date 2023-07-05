"""Module containing helper functions used in both path mode and fork mode."""

import os
import time
import difflib
from typing import TYPE_CHECKING, List, Optional, Tuple

# pylint: disable= no-name-in-module
from solc_select.solc_select import get_available_versions
from slither.utils.upgradeability import (
    compare,
    tainted_inheriting_contracts,
    TaintedExternalContract,
)
from slither.core.declarations import Function
from slither.core.variables.state_variable import StateVariable
from diffusc.utils.classes import ContractData, Diff
from diffusc.utils.crytic_print import CryticPrint

if TYPE_CHECKING:
    from slither import Slither


def get_compilation_unit_name(slither_object: "Slither") -> str:
    """Get the name of the compilation unit from Slither."""

    name = list(slither_object.crytic_compile.compilation_units.keys())[0]
    name = os.path.basename(name)
    if name.endswith(".sol"):
        name = os.path.splitext(name)[0]
    return name


# TODO: remove these disables if possible
# pylint: disable=too-many-locals,too-many-statements,too-many-branches
def get_pragma_versions_from_file(
    filepath: str, seen: Optional[List[str]] = None
) -> Tuple[str, str]:
    """Recursive function to determine minimum and maximum solc versions required by a Solidity file."""

    def is_higher_version(cur_vers: List[str], high_vers: List[str]) -> bool:
        if int(cur_vers[1]) > int(high_vers[1]) or (
            int(cur_vers[1]) == int(high_vers[1]) and int(cur_vers[2]) > int(high_vers[2])
        ):
            return True
        return False

    def is_lower_version(cur_vers: List[str], low_vers: List[str]) -> bool:
        if int(cur_vers[1]) < int(low_vers[1]) or (
            int(cur_vers[1]) == int(low_vers[1]) and int(cur_vers[2]) < int(low_vers[2])
        ):
            return True
        return False

    def next_version(cur_vers: List[str]) -> List[str]:
        ret_vers = ["0", "0", "0"]
        all_versions = list(get_available_versions().keys())
        all_versions.reverse()
        if ".".join(cur_vers) in all_versions:
            cur_index = all_versions.index(".".join(cur_vers))
            if cur_index + 1 != len(all_versions):
                return all_versions[cur_index + 1].split(".")
            return ret_vers
        if cur_vers[2] == "99":
            ret_vers[1] = str(int(cur_vers[1]) + 1)
        else:
            ret_vers[1] = cur_vers[1]
            ret_vers[2] = str(int(cur_vers[2]) + 1)
        return ret_vers

    def prev_version(cur_vers: List[str]) -> List[str]:
        ret_vers = ["0", "0", "0"]
        all_versions = list(get_available_versions().keys())
        all_versions.reverse()
        if ".".join(cur_vers) in all_versions:
            cur_index = all_versions.index(".".join(cur_vers))
            if cur_index - 1 >= 0:
                return all_versions[cur_index - 1].split(".")
            return ret_vers
        ret_vers[1] = cur_vers[1]
        ret_vers[2] = str(int(cur_vers[2]) - 1)
        return ret_vers

    def last_before_breaking(cur_vers: List[str]) -> List[str]:
        all_versions = list(get_available_versions().keys())
        last_vers = next(v for v in all_versions if v.split(".")[1] == cur_vers[1])
        return last_vers.split(".")

    if seen is None:
        seen = []
    # Read from the file and extract pragma solidity version statements
    try:
        with open(filepath, "r", encoding="utf-8") as file:
            lines = file.readlines()
    except FileNotFoundError:
        return "0.0.0", "0.0.0"
    versions = [
        line.split("solidity")[1].split(";")[0] for line in lines if "pragma solidity" in line
    ]
    versions_sublists = [
        v.replace("= ", "=").replace("> ", ">").replace("< ", "<").replace("^ ", "^").split()
        for v in versions
    ]
    versions = [item for sublist in versions_sublists for item in sublist]

    # Extract import statements from the file
    imports = [line for line in lines if "import" in line]
    files = [
        line.split()[1].split(";")[0].replace('"', "").replace("'", "")
        if line.startswith("import")
        else line.split()[1].replace('"', "").replace("'", "")
        for line in imports
    ]
    # Keep track of the version constraints imposed by imports
    max_version = ["0", "9", "99"]
    min_version = ["0", "0", "0"]
    # Recursively call this function for each imported file, and update max and min
    for path in files:
        if path.startswith("./"):
            path = os.path.join(os.path.dirname(filepath), path[2:])
        elif path.startswith("../"):
            path = os.path.join(os.path.dirname(os.path.dirname(filepath)), path[3:])
        if path not in seen:
            seen.append(path)
            file_versions = get_pragma_versions_from_file(path, seen)
            if is_higher_version(file_versions[0].split("."), min_version):
                min_version = file_versions[0].split(".")
            if is_lower_version(file_versions[1].split("."), max_version):
                max_version = file_versions[1].split(".")

    # Iterate over the versions found in this file, and update the version constraints accordingly
    for ver in versions:
        operator = ver.split("0.")[0]
        vers = ver.split(".")
        vers[0] = "0"
        if operator == ">=" and is_higher_version(vers, min_version):
            min_version = vers
        elif operator == ">" and is_higher_version(next_version(vers), min_version):
            min_version = next_version(vers)
        elif operator == "<=" and is_lower_version(vers, max_version):
            max_version = vers
        elif operator == "<" and is_lower_version(prev_version(vers), max_version):
            max_version = prev_version(vers)
        elif operator == "^" and is_higher_version(vers, min_version):
            min_version = vers
            max_version = last_before_breaking(vers)
        elif operator == "":
            min_version = vers
            max_version = vers
    # If one of the constraints has not been defined, pick a reasonable constraint
    if max_version == ["0", "9", "99"]:
        max_version = last_before_breaking(min_version)
    if min_version == ["0", "0", "0"]:
        min_version = [max_version[0], max_version[1], "0"]
    return ".".join(min_version), ".".join(max_version)


# pylint: disable=too-many-locals
def do_diff(
    v_1: ContractData,
    v_2: ContractData,
    additional_targets: Optional[List[ContractData]] = None,
    include_external: bool = False,
) -> Diff:
    """Use slither.utils.upgradeability to perform a diff between two contract versions."""
    assert v_1["valid_data"] and v_2["valid_data"]
    start_time = time.time()
    CryticPrint.print_message("* Performing diff of V1 and V2")
    (
        missing_vars,
        new_vars,
        tainted_vars,
        new_funcs,
        modified_funcs,
        tainted_funcs,
        tainted_contracts,
    ) = compare(v_1["contract_object"], v_2["contract_object"], include_external)
    if additional_targets:
        tainted_contracts = tainted_inheriting_contracts(
            tainted_contracts,
            [
                t["contract_object"]
                for t in additional_targets
                if t["contract_object"]
                not in [c.contract for c in tainted_contracts]
                + [v_1["contract_object"], v_2["contract_object"]]
            ],
        )
    diff = Diff(
        missing_variables=missing_vars,
        new_variables=new_vars,
        tainted_variables=tainted_vars,
        new_functions=new_funcs,
        modified_functions=modified_funcs,
        tainted_functions=tainted_funcs,
        tainted_contracts=tainted_contracts,
    )
    end_time = time.time()
    CryticPrint.print_message(f"  * Diff analysis completed in {end_time - start_time} seconds")
    for key, lst in diff.items():
        if isinstance(lst, list) and len(lst) > 0:
            CryticPrint.print_warning(f'  * {str(key).replace("-", " ")}:')
            for obj in lst:
                if isinstance(obj, StateVariable):
                    CryticPrint.print_warning(f"      * {obj.full_name}")
                elif isinstance(obj, Function):
                    CryticPrint.print_warning(f"      * {obj.signature_str}")
                elif isinstance(obj, TaintedExternalContract):
                    CryticPrint.print_warning(f"      * {obj.contract.name}")
                    for taint in obj.tainted_functions:
                        CryticPrint.print_warning(f"        * {taint.signature_str}")
                    for taint in obj.tainted_variables:
                        CryticPrint.print_warning(f"        * {taint.signature_str}")
    return diff


def similar(name1: str, name2: str) -> bool:
    """
    Test the name similarity
    Two names are similar if difflib.SequenceMatcher on the lowercase
    version of the name is greater than 0.90
    See: https://docs.python.org/2/library/difflib.html
    Args:
        name1 (str): first name
        name2 (str): second name
    Returns:
        bool: true if names are similar
    """

    val = difflib.SequenceMatcher(a=name1.lower(), b=name2.lower()).ratio()
    ret = val > 0.90
    return ret


def camel_case(name: str) -> str:
    """Convert a string to camel case."""

    parts = name.replace("_", " ").replace("-", " ").split()
    name = parts[0][0].lower() + parts[0][1:]
    if len(parts) > 1:
        for i in range(1, len(parts)):
            name += parts[i][0].upper() + parts[i][1:]
    return name


def write_to_file(filename: str, content: str) -> None:
    """Write content to a file. If the parent directory doesn't exist, create it."""

    base_dir = os.path.dirname(filename)
    if not os.path.exists(base_dir):
        os.makedirs(base_dir, exist_ok=True)

    with open(filename, "wt", encoding="utf-8") as out_file:
        out_file.write(content)
