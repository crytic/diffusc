"""Module containing classes common to path mode and fork mode."""

from typing import TypedDict, List, Optional

# pylint: disable= no-name-in-module
from slither import Slither
from slither.core.declarations.contract import Contract
from slither.core.declarations.function import Function
from slither.core.variables.variable import Variable
from slither.utils.upgradeability import TaintedExternalContract
from slither.tools.read_storage.read_storage import SlotInfo


class FunctionInfo(TypedDict):
    """Typed dictionary of function info"""

    name: str
    function: Function
    inputs: List[str]
    outputs: List[str]
    protected: bool


class ContractData(TypedDict):
    """Typed dictionary of contract data"""

    # Blockchain info
    address: Optional[str]
    valid_data: bool
    # File info
    path: str
    solc_version: str
    suffix: str
    # Contract info
    name: str
    interface: Optional[str]
    interface_name: Optional[str]
    functions: List[FunctionInfo]
    slither: Optional[Slither]
    contract_object: Optional[Contract]
    is_erc20: bool
    # Proxy info
    is_proxy: bool
    implementation_object: Optional[Contract]
    implementation_slither: Optional[Slither]
    implementation_slot: Optional[SlotInfo]


class Diff(TypedDict):
    """Typed dictionary of V1/V2 diff"""

    missing_variables: List[Variable]
    new_variables: List[Variable]
    tainted_variables: List[Variable]
    new_functions: List[Function]
    modified_functions: List[Function]
    tainted_functions: List[Function]
    tainted_contracts: List[TaintedExternalContract]
