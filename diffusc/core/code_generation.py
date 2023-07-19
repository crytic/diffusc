"""Module for generating test contract code."""
import os
from os.path import relpath
from typing import List, Tuple, Optional

# pylint: disable= no-name-in-module,too-many-lines
from solc_select.solc_select import (
    switch_global_version,
    installed_versions,
    get_installable_versions,
)
from slither import Slither
from slither.exceptions import SlitherError
from slither.utils.type import convert_type_for_solidity_signature_to_string
from slither.utils.code_generation import generate_interface, generate_struct_interface_str
from slither.utils.upgradeability import (
    get_proxy_implementation_slot,
    TaintedExternalContract,
    SlotInfo,
)
from slither.core.declarations.contract import Contract
from slither.core.variables.variable import Variable
from slither.core.variables.local_variable import LocalVariable
from slither.core.declarations.enum import Enum
from slither.core.solidity_types import (
    Type,
    ElementaryType,
    UserDefinedType,
    ArrayType,
    MappingType,
    TypeAlias,
)
from slither.core.declarations.structure_contract import Structure, StructureContract
from diffusc.utils.classes import FunctionInfo, ContractData, Diff
from diffusc.utils.crytic_print import CryticPrint
from diffusc.utils.network_info_provider import NetworkInfoProvider
from diffusc.utils.helpers import (
    get_pragma_versions_from_file,
    similar,
    camel_case,
)


# pylint: disable=too-many-instance-attributes,too-many-public-methods
class CodeGenerator:
    """Class for generating test contract code."""

    # pylint: disable=too-many-arguments
    def __init__(
        self,
        v_1: ContractData,
        v_2: ContractData,
        mode: str,
        version: str,
        upgrade: bool,
        protected: bool,
        net_info: NetworkInfoProvider = None,
        ignore_diff: bool = False,
    ):
        assert mode in ["path", "fork", "hybrid"]

        self._v_1: ContractData = v_1
        self._v_2: ContractData = v_2
        self._proxy: Optional[ContractData] = None
        self._targets: List[ContractData] = []
        self._fork: bool = mode in ["fork", "hybrid"]
        self._hybrid: bool = mode == "hybrid"
        self._version: str = version
        self._upgrade: bool = upgrade
        self._protected: bool = protected
        self._ignore_diff: bool = ignore_diff
        self._network_info: Optional[NetworkInfoProvider] = net_info
        self._new_func_wrappers: List[str] = []

    @property
    def v_1(self) -> ContractData:
        """V1 ContractData getter"""
        return self._v_1

    @property
    def v_2(self) -> ContractData:
        """V2 ContractData getter"""
        return self._v_2

    @property
    def proxy(self) -> Optional[ContractData]:
        """Proxy ContractData getter"""
        return self._proxy

    @proxy.setter
    def proxy(self, _proxy: ContractData) -> None:
        """Proxy ContractData setter"""
        self._proxy = _proxy

    @property
    def targets(self) -> List[ContractData]:
        """Additional targets ContractData list getter"""
        return self._targets

    @targets.setter
    def targets(self, _targets: List[ContractData]) -> None:
        """Additional targets ContractData list setter"""
        self._targets = _targets

    @property
    def new_func_wrappers(self) -> List[str]:
        return self._new_func_wrappers

    @staticmethod
    def generate_config_file(
        corpus_dir: str,
        campaign_length: int,
        contract_addr: str,
        seq_len: int,
        block: str | int = 0,
        rpc_url: str = "",
        senders: List[str] = None,
        output_dir: str = "",
    ) -> str:
        """Generate an Echidna config file."""
        if senders is None:
            senders = []
        CryticPrint.print_information(
            f"* Generating Echidna configuration file with campaign limit {campaign_length}"
            f" and corpus directory {corpus_dir}",
        )
        config_file = "testMode: assertion\n"
        config_file += f"testLimit: {campaign_length}\n"
        if corpus_dir != "":
            config_file += "corpusDir: "
            config_file += (
                f"{relpath(corpus_dir, output_dir)}\n" if output_dir != "" else corpus_dir
            )
        config_file += "codeSize: 0xffff\n"
        config_file += f"seqLen: {seq_len}\n"
        if contract_addr != "":
            config_file += f"contractAddr: '{contract_addr}'\n"
        if str(block) != "0":
            config_file += f"rpcBlock: {block}\n"
        if rpc_url != "":
            config_file += f"rpcUrl: {rpc_url}\n"
        if len(senders) > 0:
            config_file += "sender: ['" + "','".join(sender for sender in senders) + "']\n"
        return config_file

    # pylint: disable=too-many-branches
    @staticmethod
    def get_solidity_function_parameters(parameters: List[LocalVariable]) -> List[str]:
        """Get function parameters as solidity types."""
        inputs = []

        for inp in parameters:
            if isinstance(inp.type, ElementaryType):
                base_type = inp.type.name
                if inp.type.is_dynamic:
                    base_type += " memory"

            elif isinstance(inp.type, UserDefinedType):
                if isinstance(inp.type.type, Structure):
                    base_type = f"{inp.type.type.name} {inp.location}"
                else:
                    base_type = convert_type_for_solidity_signature_to_string(inp.type)

            elif isinstance(inp.type, ArrayType):
                if isinstance(inp.type.type, UserDefinedType):
                    if isinstance(inp.type.type.type, Structure):
                        base_type = f"{inp.type.type.type.name}[]"
                    else:
                        base_type = (
                            f"{convert_type_for_solidity_signature_to_string(inp.type.type)}[]"
                        )
                else:
                    base_type = convert_type_for_solidity_signature_to_string(inp.type)
                if inp.type.is_dynamic:
                    base_type += f" {inp.location}"

            elif isinstance(inp.type, TypeAlias):
                base_type = convert_type_for_solidity_signature_to_string(inp.type)

            inputs.append(base_type)

        return inputs

    @staticmethod
    def get_solidity_function_returns(return_type: List[Type]) -> List[str]:
        """Get function return types as solidity types."""
        outputs: List[str] = []

        if not return_type:
            return outputs

        if len(return_type) > 0:
            for out in return_type:
                if isinstance(out, ElementaryType):
                    base_type = convert_type_for_solidity_signature_to_string(out)
                    if out.is_dynamic:
                        base_type += " memory"
                elif isinstance(out, ArrayType):
                    if isinstance(out.type, UserDefinedType) and isinstance(
                        out.type.type, Structure
                    ):
                        base_type = f"{out.type.type.name}[] memory"
                    else:
                        base_type = convert_type_for_solidity_signature_to_string(out)
                        base_type += " memory"
                elif isinstance(out, UserDefinedType):
                    if isinstance(out.type, Structure):
                        base_type = f"{out.type.name} memory"
                    elif isinstance(out.type, (Contract, Enum)):
                        base_type = convert_type_for_solidity_signature_to_string(out)
                elif isinstance(out, TypeAlias):
                    base_type = convert_type_for_solidity_signature_to_string(out)
                outputs.append(base_type)

        return outputs

    @staticmethod
    def get_contract_interface(
        contract_data: ContractData, net_info: Optional[NetworkInfoProvider] = None
    ) -> ContractData:
        """Populate ContractData with contract interface and function info from Slither"""

        contract: Contract = contract_data["contract_object"]
        suffix: str = contract_data["suffix"]

        if not contract.functions_entry_points:
            raise ValueError("Contract has no public or external functions")

        contract_data["functions"] = []

        entry_points = contract.functions_entry_points
        entry_points.sort(key=lambda func: func.canonical_name)
        for i in entry_points:

            # Interface won't need constructor or fallbacks
            if i.is_constructor or i.is_fallback or i.is_receive:
                continue

            # Get info for interface and wrapper
            name = i.name
            inputs = CodeGenerator.get_solidity_function_parameters(i.parameters)
            outputs = CodeGenerator.get_solidity_function_returns(i.return_type)
            protected = i.is_protected()

            contract_data["functions"].append(
                FunctionInfo(
                    name=name,
                    function=i,
                    inputs=inputs,
                    outputs=outputs,
                    protected=protected,
                )
            )

        contract_data["name"] = contract.name
        if contract_data["is_erc20"] and contract_data["address"] and net_info:
            erc_name = net_info.get_contract_variable_value(
                contract.get_state_variable_from_name("symbol"), contract_data["address"], contract
            )
            if erc_name != "":
                contract_data["name"] = erc_name
        contract_data["interface"] = generate_interface(
            contract, unroll_structs=False, include_errors=False, include_events=False
        ).replace(f"interface I{contract.name}", f"interface I{contract.name}{suffix}")
        contract_data["interface_name"] = f"I{contract.name}{suffix}"

        return contract_data

    @staticmethod
    def get_contract_data(
        contract: Contract, suffix: str = "", out_dir: str = "./"
    ) -> ContractData:
        """Get ContractData object from Contract object."""

        CryticPrint.print_message(f"  * Getting contract data from {contract.name}")

        version = get_pragma_versions_from_file(contract.file_scope.filename.absolute)[0]
        contract_data = ContractData(
            contract_object=contract,
            suffix=suffix,
            path=os.path.relpath(contract.file_scope.filename.absolute, out_dir),
            solc_version=version,
            address="",
            valid_data=False,
            name="",
            interface=None,
            interface_name=None,
            functions=[],
            slither=None,
            is_proxy=False,
            is_erc20=False,
            implementation_slither=None,
            implementation_slot=None,
            implementation_object=None,
        )
        if version in installed_versions() or version in get_installable_versions():
            switch_global_version(version, True)

        try:
            contract_data["slither"] = Slither(contract.compilation_unit.crytic_compile)
            contract_data["valid_data"] = True
        except SlitherError:
            contract_data["slither"] = None
            contract_data["valid_data"] = False

        if contract_data["valid_data"]:
            contract_data = CodeGenerator.get_valid_contract_data(contract_data)

        return contract_data

    @staticmethod
    def get_valid_contract_data(contract_data: ContractData) -> ContractData:
        """Complete the ContractData object after getting valid data from Slither."""

        assert contract_data["valid_data"]
        assert isinstance(contract_data["contract_object"], Contract)

        if contract_data["contract_object"].is_upgradeable_proxy:
            contract_data["is_proxy"] = True
            contract_data["implementation_slot"] = get_proxy_implementation_slot(
                contract_data["contract_object"]
            )
            contract_data["is_erc20"] = False  # Assume false, since we have no impl contract object
        else:
            contract_data["is_proxy"] = False
            contract_data["is_erc20"] = contract_data["contract_object"].is_erc20()
        contract_data = CodeGenerator.get_contract_interface(contract_data)

        return contract_data

    @staticmethod
    def get_args_and_returns_for_wrapping(
        func: FunctionInfo,
    ) -> Tuple[str, str, List[str], List[str]]:
        """Get function arguments and return value types for wrapper functions."""

        args = "("
        call_args = "("
        return_vals: List[str] = []
        returns_to_compare: List[str] = []
        counter = 0
        if len(func["inputs"]) == 0:
            args += ")"
            call_args += ")"
        else:
            for i in func["inputs"]:
                args += f"{i} {chr(ord('a') + counter)}, "
                call_args += f"{chr(ord('a') + counter)}, "
                counter += 1
            args = f"{args[0:-2]})"
            call_args = f"{call_args[0:-2]})"
        if len(func["outputs"]) == 0:
            return_vals = [""]
        elif len(func["outputs"]) == 1:
            for j in range(0, 2):
                return_vals.append(f"{func['outputs'][0]} {chr(ord('a') + counter)}")
                returns_to_compare.append(f"{chr(ord('a') + counter)}")
                counter += 1
        else:
            for j in range(0, 2):
                return_vals.append("(")
                returns_to_compare.append("(")
                for i in func["outputs"]:
                    return_vals[j] += f"{i} {chr(ord('a') + counter)}, "
                    returns_to_compare[j] += f"{chr(ord('a') + counter)}, "
                    counter += 1
                return_vals[j] = f"{return_vals[j][0:-2]})"
                returns_to_compare[j] = f"{returns_to_compare[j][0:-2]})"
        return args, call_args, return_vals, returns_to_compare

    def wrap_additional_target_functions(
        self,
        tainted: List[TaintedExternalContract] = None,
    ) -> str:
        """Create wrapper functions for a list of additional target contracts."""

        protected_mods = [
            "onlyOwner",
            "onlyAdmin",
            "ifOwner",
            "ifAdmin",
            "adminOnly",
            "ownerOnly",
        ]
        wrapped = ""

        targets = self.targets
        proxy = self.proxy
        if targets is None or len(targets) == 0:
            return wrapped
        if tainted is None:
            tainted = []
        if proxy is None:
            proxy = ContractData(name="")  # type: ignore[typeddict-item]
        tainted_contracts = [taint.contract for taint in tainted]
        CryticPrint.print_information("  * Adding wrapper functions for additional targets.")

        wrapped += "\n    /*** Additional Targets ***/ \n\n"
        for target in targets:
            contract: Contract = target["contract_object"]
            if contract.name in [t.name for t in tainted_contracts] + [proxy["name"]]:
                # already covered by wrap_diff_functions
                continue
            functions_to_wrap: List[FunctionInfo] = target["functions"]
            functions_to_wrap.sort(key=lambda info: info["name"])
            for func in functions_to_wrap:
                mods = [m.name for m in func["function"].modifiers]
                if not self._protected and any(m in protected_mods for m in mods):
                    continue
                target_2 = target.copy()
                if not self._fork:
                    target["suffix"] = "V1"
                    target_2["suffix"] = "V2"
                if len(tainted) > 0:
                    if any(
                        func["function"].signature_str == f.signature_str
                        for taint in tainted
                        for f in taint.tainted_functions
                    ):
                        wrapped += self.wrap_diff_function(target, target_2, func)
                else:
                    wrapped += self.wrap_diff_function(target, target_2, func)
        return wrapped

    def wrap_low_level_call(
        self,
        c_data: ContractData,
        func: FunctionInfo,
        suffix: str,
        proxy: ContractData = None,
    ) -> str:
        """Generate code for a low-level call to use in wrapper functions."""

        if proxy is None:
            target = camel_case(c_data["name"])
        else:
            target = camel_case(proxy["name"])
        if not self._fork:
            target += c_data["suffix"]
        _, call_args, _, _ = self.get_args_and_returns_for_wrapping(func)
        wrapped = ""
        wrapped += (
            f"        (bool success{suffix}, bytes memory output{suffix}) = "
            f"address({target}).call(\n"
        )
        wrapped += "            abi.encodeWithSignature(\n"
        name, params, _ = func["function"].signature
        signature = f"{name}({','.join(params)})"
        wrapped += f"                '{signature}'{call_args.replace('()', '').replace('(', ', ').replace(')', '')}\n"
        wrapped += "            )\n"
        wrapped += "        );\n"
        return wrapped

    # pylint: disable=too-many-arguments
    def wrap_diff_function(
        self,
        v_1: ContractData,
        v_2: ContractData,
        func: FunctionInfo,
        func2: FunctionInfo = None,
        proxy: ContractData = None,
    ) -> str:
        """Create wrapper function for comparing V1 and V2."""

        wrapped = ""
        if func2 is None:
            func2 = func
        args, _, _, _ = self.get_args_and_returns_for_wrapping(func2)

        wrapped += f"    function {v_2['name']}_{func2['name']}{args} public virtual {{\n"
        if self._fork:
            wrapped += "        hevm.selectFork(fork1);\n"
            wrapped += "        emit SwitchedFork(fork1);\n"
        if not func["protected"]:
            wrapped += "        hevm.prank(msg.sender);\n"
        wrapped += self.wrap_low_level_call(v_1, func, "V1", proxy)
        if self._fork:
            wrapped += "        hevm.selectFork(fork2);\n"
            wrapped += "        emit SwitchedFork(fork2);\n"
        if not func2["protected"]:
            wrapped += "        hevm.prank(msg.sender);\n"
        wrapped += self.wrap_low_level_call(v_2, func2, "V2", proxy)
        wrapped += "        assert(successV1 == successV2); \n"
        wrapped += "        if(successV1 && successV2) {\n"
        wrapped += "            assert(keccak256(outputV1) == keccak256(outputV2));\n"
        wrapped += "        }\n"
        wrapped += "    }\n\n"
        return wrapped

    def wrap_replacement_function(
        self,
        v_1: ContractData,
        v_2: ContractData,
        old_func: FunctionInfo,
        new_func: FunctionInfo,
        proxy: ContractData,
    ) -> str:
        """Create wrapper function for new function in V2 replacing one in V1."""

        wrapped = ""
        assert isinstance(proxy["implementation_slot"], SlotInfo)

        new_args, _, _, _ = self.get_args_and_returns_for_wrapping(new_func)
        old_args, _, _, _ = self.get_args_and_returns_for_wrapping(old_func)
        args = new_args if len(new_args) > len(old_args) else old_args

        wrapped += f"    function {v_2['name']}_{new_func['name']}{args} public virtual {{\n"
        if self._fork:
            wrapped += "        hevm.selectFork(fork1);\n"
            wrapped += "        emit SwitchedFork(fork1);\n"
        if not old_func["protected"]:
            wrapped += "        hevm.prank(msg.sender);\n"
        wrapped += self.wrap_low_level_call(v_1, old_func, "V1", proxy)
        if self._fork:
            wrapped += "        hevm.selectFork(fork2);\n"
            wrapped += "        emit SwitchedFork(fork2);\n"
        impl_slot = int.to_bytes(proxy["implementation_slot"].slot, 32, "big").hex()
        wrapped += (
            "        address impl = address(uint160(uint256(\n"
            f"            hevm.load(address({camel_case(proxy['name'])}{v_2['suffix'] if not self._fork else ''}),"
            f"0x{impl_slot})\n"
            "        )));\n"
        )
        if not new_func["protected"]:
            wrapped += "        hevm.prank(msg.sender);\n"
        wrapped += "        bool successV2;\n"
        wrapped += "        bytes memory outputV2;\n"
        wrapped += f"        if(impl == address({camel_case(v_2['name'])}{v_2['suffix']})) {{\n"
        wrapped += (
            self.wrap_low_level_call(v_2, new_func, "V2", proxy)
            .replace("bool ", "")
            .replace("bytes memory ", "")
            .replace("        ", "            ")
        )
        wrapped += "        } else {\n"
        wrapped += (
            self.wrap_low_level_call(v_1, old_func, "V2", proxy)
            .replace("bool ", "")
            .replace("bytes memory ", "")
            .replace("        ", "            ")
        )
        wrapped += "        }\n"
        wrapped += "        assert(successV1 == successV2); \n"
        wrapped += "        if(successV1 && successV2) {\n"
        wrapped += "            assert(keccak256(outputV1) == keccak256(outputV2));\n"
        wrapped += "        }\n"
        wrapped += "    }\n\n"
        return wrapped

    def wrap_new_function(
        self, v_2: ContractData, new_func: FunctionInfo, proxy: ContractData = None
    ) -> str:
        """Create wrapper function for new function in V2."""

        wrapped = ""
        args, _, _, _ = self.get_args_and_returns_for_wrapping(new_func)

        wrapped += f"    function {v_2['name']}_{new_func['name']}{args} public virtual {{\n"
        wrapped += f"        // This function does nothing with the V1, since {new_func['name']} is new in the V2\n"
        if self._fork:
            wrapped += "        hevm.selectFork(fork2);\n"
            wrapped += "        emit SwitchedFork(fork2);\n"

        if proxy is not None and proxy["implementation_slot"] is not None:

            try:
                impl_slot = int.to_bytes(proxy["implementation_slot"].slot, 32, "big").hex()
            except AttributeError:
                impl_slot = "<INSERT_IMPL_SLOT_HERE>"
            wrapped += (
                "        address impl = address(uint160(uint256(\n"
                f"            hevm.load(address({camel_case(proxy['name'])}{v_2['suffix'] if not self._fork else ''}),"
                f"0x{impl_slot})\n"
                "        )));\n"
            )
            wrapped += (
                f"        require(impl == address({camel_case(v_2['name'])}{v_2['suffix']}));\n"
            )
        if not new_func["protected"]:
            wrapped += "        hevm.prank(msg.sender);\n"
        wrapped += self.wrap_low_level_call(v_2, new_func, "V2", proxy)
        if self._fork:
            wrapped += "        // Keep the forks in sync\n"
            wrapped += "        uint blockNo = block.number;\n"
            wrapped += "        uint blockTime = block.timestamp;\n"
            wrapped += "        hevm.selectFork(fork1);\n"
            wrapped += "        emit SwitchedFork(fork1);\n"
            wrapped += "        hevm.roll(blockNo);\n"
            wrapped += "        hevm.warp(blockTime);\n"
        wrapped += "        // Never fail assertion, since there is nothing to compare\n"
        wrapped += "        assert(true);\n"
        wrapped += "    }\n\n"
        return wrapped

    # pylint: disable=too-many-branches,too-many-statements
    def wrap_tainted_vars(
        self,
        variables: List[Variable],
    ) -> str:
        """Create wrapper functions for comparing tainted state variables."""

        v_1 = self.v_1
        v_2 = self.v_2
        proxy = self.proxy
        fork = self._fork

        wrapped = "\n    /*** Tainted Variables ***/ \n\n"
        for var in variables:
            if isinstance(var.type, UserDefinedType) and isinstance(var.type.type, Structure):
                continue
            if proxy is None:
                target_v1 = camel_case(v_1["name"]) + v_1["suffix"]
                target_v2 = camel_case(v_2["name"]) + v_2["suffix"]
            elif fork:
                target_v1 = f"{v_1['interface_name']}(address({camel_case(proxy['name'])}))"
                target_v2 = f"{v_2['interface_name']}(address({camel_case(proxy['name'])}))"
            else:
                target_v1 = (
                    f"{v_1['interface_name']}(address({camel_case(proxy['name'])}{v_1['suffix']}))"
                )
                target_v2 = (
                    f"{v_2['interface_name']}(address({camel_case(proxy['name'])}{v_2['suffix']}))"
                )
            if var.visibility in ["internal", "private"]:
                continue
            if var.type.is_dynamic:
                if isinstance(var.type, MappingType):
                    base_type = var.type.type_to
                    if isinstance(base_type, UserDefinedType) and isinstance(
                        base_type.type, Structure
                    ):
                        continue
                    if isinstance(base_type, (MappingType, ArrayType)):
                        continue
                    type_from = convert_type_for_solidity_signature_to_string(var.type.type_from)
                    type_to = convert_type_for_solidity_signature_to_string(var.type.type_to)
                    if var.type.type_from.is_dynamic:
                        type_from += " memory"
                    wrapped += f"    function {v_1['name']}_{var.name}({type_from} a) public virtual returns ({type_to}) {{\n"
                    if fork:
                        wrapped += "        hevm.selectFork(fork1);\n"
                        wrapped += "        emit SwitchedFork(fork1);\n"
                        wrapped += f"        {type_to} a1 = {target_v1}.{var.name}(a);\n"
                        wrapped += "        hevm.selectFork(fork2);\n"
                        wrapped += "        emit SwitchedFork(fork2);\n"
                        wrapped += f"        {type_to} a2 = {target_v2}.{var.name}(a);\n"
                        wrapped += "        assert(a1 == a2);\n"
                        wrapped += "        return a1;\n"
                    else:
                        wrapped += f"        assert({target_v1}.{var.name}(a) == {target_v2}.{var.name}(a));\n"
                        wrapped += f"        return {target_v1}.{var.name}(a);\n"
                elif isinstance(var.type, ArrayType):
                    base_type = var.type.type
                    if isinstance(base_type, UserDefinedType):
                        if isinstance(base_type.type, Structure):
                            continue
                        if isinstance(base_type.type, Contract):
                            base_type = "address"
                    wrapped += f"    function {v_1['name']}_{var.name}(uint i) public virtual returns ({base_type}) {{\n"
                    if fork:
                        wrapped += "        hevm.selectFork(fork1);\n"
                        wrapped += "        emit SwitchedFork(fork1);\n"
                        wrapped += f"        {base_type} a1 = {target_v1}.{var.name}(i);\n"
                        wrapped += "        hevm.selectFork(fork2);\n"
                        wrapped += "        emit SwitchedFork(fork2);\n"
                        wrapped += f"        {base_type} a2 = {target_v2}.{var.name}(i);\n"
                        wrapped += "        assert(a1 == a2);\n"
                        wrapped += "        return a1;\n"
                    else:
                        wrapped += f"        assert({target_v1}.{var.name}(i) == {target_v2}.{var.name}(i));\n"
                        wrapped += f"        return {target_v1}.{var.name}(i);\n"
                else:
                    continue
            else:
                ret_type = var.type
                if isinstance(var.type, UserDefinedType) and isinstance(var.type.type, Contract):
                    ret_type = ElementaryType("address")
                wrapped += f"    function {v_1['name']}_{var.full_name} public virtual returns ({ret_type}) {{\n"
                if fork:
                    wrapped += "        hevm.selectFork(fork1);\n"
                    wrapped += "        emit SwitchedFork(fork1);\n"
                    wrapped += f"        {ret_type} a1 = {target_v1}.{var.full_name};\n"
                    wrapped += "        hevm.selectFork(fork2);\n"
                    wrapped += "        emit SwitchedFork(fork2);\n"
                    wrapped += f"        {ret_type} a2 = {target_v2}.{var.full_name};\n"
                    wrapped += "        assert(a1 == a2);\n"
                    wrapped += "        return a1;\n"
                else:
                    wrapped += f"        assert({target_v1}.{var.full_name} == {target_v2}.{var.full_name});\n"
                    wrapped += f"        return {target_v1}.{var.full_name};\n"
            wrapped += "    }\n\n"
        return wrapped

    # pylint: disable=too-many-branches,too-many-statements,too-many-locals
    def wrap_diff_functions(
        self,
        diff: Diff,
        external_taint: List[ContractData] = None,
    ) -> str:
        """Create wrapper functions based on the diff between V1 and V2, including tainted contracts."""

        v_1 = self.v_1
        v_2 = self.v_2
        proxy = self.proxy
        fork = self._fork
        protected = self._protected
        seen: List[str] = []

        assert isinstance(v_1["contract_object"], Contract) and isinstance(
            v_2["contract_object"], Contract
        )

        protected_mods = [
            "onlyOwner",
            "onlyAdmin",
            "ifOwner",
            "ifAdmin",
            "adminOnly",
            "ownerOnly",
        ]

        wrapped = "\n    /*** Modified Functions ***/ \n\n"
        for diff_func in diff["modified_functions"]:
            if diff_func.canonical_name in seen or not diff_func.is_implemented:
                continue
            seen.append(diff_func.canonical_name)
            mods = [m.name for m in diff_func.modifiers]
            if not protected and any(m in protected_mods for m in mods):
                continue
            if diff_func.visibility in ["internal", "private"]:
                continue
            try:
                func = next(
                    func
                    for func in v_2["functions"]
                    if func["function"].canonical_name == diff_func.canonical_name
                    and len(func["inputs"]) == len(diff_func.parameters)
                )
            except StopIteration:
                continue
            if proxy is not None:
                wrapped += self.wrap_diff_function(v_1, v_2, func, proxy=proxy)
            else:
                wrapped += self.wrap_diff_function(v_1, v_2, func)

        wrapped += "\n    /*** Tainted Functions ***/ \n\n"
        for diff_func in diff["tainted_functions"]:
            if diff_func.canonical_name in seen or not diff_func.is_implemented:
                continue
            seen.append(diff_func.canonical_name)
            mods = [m.name for m in diff_func.modifiers]
            if not protected and any(m in protected_mods for m in mods):
                continue
            if diff_func.visibility in ["internal", "private"]:
                continue
            try:
                func = next(
                    func
                    for func in v_2["functions"]
                    if func["function"].canonical_name == diff_func.canonical_name
                    and len(func["inputs"]) == len(diff_func.parameters)
                )
            except StopIteration:
                continue
            if proxy is not None:
                wrapped += self.wrap_diff_function(v_1, v_2, func, proxy=proxy)
            else:
                wrapped += self.wrap_diff_function(v_1, v_2, func)

        wrapped += "\n    /*** New Functions ***/ \n\n"
        for diff_func in diff["new_functions"]:
            if diff_func.canonical_name in seen or not diff_func.is_implemented:
                continue
            if diff_func.is_constructor or diff_func.is_fallback or diff_func.is_receive:
                continue
            seen.append(diff_func.canonical_name)
            mods = [m.name for m in diff_func.modifiers]
            if not protected and any(m in protected_mods for m in mods):
                continue
            if diff_func.visibility in ["internal", "private"]:
                continue
            replacement = False
            func2 = next(
                func
                for func in v_2["functions"]
                if func["function"].canonical_name == diff_func.canonical_name
            )
            for func_0 in v_1["contract_object"].functions_entry_points:
                if similar(diff_func.name, func_0.name):
                    # Treat this as a replacement function
                    replacement = True
                    try:
                        func = next(
                            func
                            for func in v_1["functions"]
                            if func["function"].canonical_name == func_0.canonical_name
                        )
                        wrapped += "    // TODO: Double-check this function for correctness\n"
                        wrapped += f"    // {diff_func.canonical_name}\n"
                        wrapped += "    // is a new function which appears to replace a function with a similar name,\n"
                        wrapped += f"    // {func_0.canonical_name}.\n"
                        wrapped += "    // If the functions have different arguments this function may be incorrect.\n"
                    except StopIteration:
                        continue
                    if proxy is not None and isinstance(proxy["implementation_slot"], SlotInfo):
                        wrapped += self.wrap_replacement_function(v_1, v_2, func, func2, proxy)
                    else:
                        wrapped += self.wrap_diff_function(v_1, v_2, func, func2)
                    break
            if not replacement:
                # Treat this as a new function
                if len(diff_func.all_state_variables_written()) > 0:
                    self._new_func_wrappers.append(f"{v_2['name']}_{func2['name']}")
                wrapped += self.wrap_new_function(v_2, func2, proxy)

        wrapped += self.wrap_tainted_vars(diff["tainted_variables"])

        if external_taint:
            wrapped += "\n    /*** Tainted External Contracts ***/ \n\n"
            tainted_contracts = diff["tainted_contracts"]
            tainted_contracts.sort(key=lambda item: item.contract.name)
            for tainted in tainted_contracts:
                contract: Contract = tainted.contract
                contract_data = next(
                    (t for t in external_taint if t["name"] == contract.name), None
                )
                if contract_data:
                    contract_data_2 = contract_data.copy()
                    if not fork:
                        contract_data["suffix"] = "V1"
                        contract_data_2["suffix"] = "V2"
                    tainted_functions = tainted.tainted_functions
                    tainted_functions.sort(key=lambda tainted_func: tainted_func.canonical_name)
                    for diff_func in tainted_functions:
                        if diff_func.canonical_name in seen:
                            continue
                        seen.append(diff_func.canonical_name)
                        mods = [m.name for m in diff_func.modifiers]
                        if not protected and any(m in protected_mods for m in mods):
                            continue
                        if diff_func.visibility in ["internal", "private"] or any(
                            [diff_func.is_constructor, diff_func.is_fallback, diff_func.is_receive]
                        ):
                            continue
                        try:
                            func = next(
                                func
                                for func in contract_data["functions"]
                                if func["function"].canonical_name == diff_func.canonical_name
                                and len(func["inputs"]) == len(diff_func.parameters)
                            )
                        except StopIteration:
                            continue
                        wrapped += self.wrap_diff_function(contract_data, contract_data_2, func)

        return wrapped

    def wrap_all_functions(self) -> str:
        v_1 = self.v_1
        v_2 = self.v_2
        proxy = self.proxy

        assert isinstance(v_1["contract_object"], Contract) and isinstance(
            v_2["contract_object"], Contract
        )

        wrapped = "\n    /*** All V2 Functions ***/ \n\n"
        for func in v_2["functions"]:
            if f"{v_2['name']}_{func['name']}" in wrapped:
                continue
            if func["name"] in [
                v.name for v in v_2["contract_object"].state_variables_entry_points
            ]:
                continue
            if proxy is not None:
                wrapped += self.wrap_diff_function(v_1, v_2, func, proxy=proxy)
            else:
                wrapped += self.wrap_diff_function(v_1, v_2, func)
        wrapped += "\n    /*** All V2 Public Variables ***/ \n\n"
        wrapped += self.wrap_tainted_vars(v_2["contract_object"].state_variables_entry_points)

        wrapped += "\n    /*** Additional Targets ***/ \n\n"
        wrapped += self.wrap_additional_target_functions()
        return wrapped

    # pylint: disable=too-many-branches,too-many-statements,too-many-locals
    def generate_test_contract(self, diff: Diff, output_dir: str = "./") -> str:
        """Main function for generating a diff fuzzing test contract."""

        v_1 = self.v_1
        v_2 = self.v_2
        proxy = self.proxy
        targets = self.targets
        version = self._version
        fork = self._fork
        hybrid = self._hybrid
        upgrade = self._upgrade

        assert v_1["contract_object"] and v_2["contract_object"]

        targets.sort(key=lambda target: target["name"])

        final_contract = ""
        tainted_contracts: List[TaintedExternalContract] = diff["tainted_contracts"]
        tainted_contracts = [
            t
            for t in tainted_contracts
            if t.contract not in [v_1["contract_object"], v_2["contract_object"]]
        ]
        tainted_contracts.sort(key=lambda taint: taint.contract.name)
        CryticPrint.print_information("* Getting contract data for tainted contracts.")
        tainted_targets = [
            self.get_contract_data(t.contract, out_dir=output_dir)
            if t.contract.name
            not in [
                target["contract_object"].name if target["contract_object"] is not None else ""
                for target in targets
            ]
            + [
                proxy["contract_object"].name
                if proxy is not None and proxy["contract_object"] is not None
                else ""
            ]
            else next(
                target
                for target in targets + [proxy]
                if target is not None and t.contract.name == target["name"]
            )
            for t in tainted_contracts
        ]
        tainted_targets = [t for t in tainted_targets if t["valid_data"]]
        tainted_targets.sort(key=lambda target: target["name"])
        other_targets = list(targets)
        if proxy:
            other_targets.append(proxy)

        CryticPrint.print_information("\n* Generating exploit contract...")
        # Add solidity pragma and SPDX to avoid warnings
        final_contract += f"// SPDX-License-Identifier: AGPLv3\npragma solidity >={version};\n\n"
        try:
            # Check the major version number, and include abi encoder if below 0.8.0
            major_version = int(self._version.split(".")[1])
            minor_version = int(self._version.split(".")[2])
            if major_version == 7 and minor_version >= 4:
                final_contract += "pragma abicoder v2;\n\n"
            elif major_version < 7 or (major_version == 7 and minor_version < 4):
                final_contract += "pragma experimental ABIEncoderV2;\n\n"
        except ValueError:
            pass

        if not fork:
            final_contract += (
                f'import {{ {v_1["name"]} as {v_1["name"]}_V1 }} '
                f'from "{v_1["path"].replace(os.sep, "/")}";\n'
            )
            final_contract += (
                f'import {{ {v_2["name"]} as {v_2["name"]}_V2 }} '
                f'from "{v_2["path"].replace(os.sep, "/")}";\n'
            )
            if proxy:
                final_contract += (
                    f'import {{ {proxy["name"]} }} '
                    f'from "{proxy["path"].replace(os.sep, "/")}";\n'
                )
            for target in targets:
                final_contract += (
                    f'import {{ {target["name"]} }} '
                    f'from "{target["path"].replace(os.sep, "/")}";\n'
                )
            if tainted_targets is not None:
                for tainted in tainted_targets:
                    contract: Contract = tainted["contract_object"]
                    if contract.name not in (t["name"] for t in other_targets):
                        final_contract += (
                            f"import {{ {contract.name} }} from "
                            f'"{tainted["path"].replace(os.sep, "/")}";\n'
                        )
            final_contract += "\n"
        elif hybrid:
            final_contract += (
                f'import {{ {v_2["name"]} }} ' f'from "{v_2["path"].replace(os.sep, "/")}";\n'
            )

        # Add all interfaces first
        CryticPrint.print_information("  * Adding interfaces.")
        final_contract += str(v_1["interface"])
        final_contract += str(v_2["interface"])

        for target in targets:
            if str(target["interface"]) not in final_contract:
                final_contract += str(target["interface"])
        for target in tainted_targets:
            if (
                target["name"]
                not in (t["contract_object"].name for t in other_targets if t["contract_object"])
                and str(target["interface"]) not in final_contract
            ):
                final_contract += str(target["interface"])
        if proxy is not None:
            final_contract += str(proxy["interface"])

        # Add the hevm interface
        final_contract += "interface IHevm {\n"
        final_contract += "    function warp(uint256 newTimestamp) external;\n"
        final_contract += "    function roll(uint256 newNumber) external;\n"
        final_contract += (
            "    function load(address where, bytes32 slot) external returns (bytes32);\n"
        )
        final_contract += (
            "    function store(address where, bytes32 slot, bytes32 value) external;\n"
        )
        final_contract += (
            "    function sign(uint256 privateKey, bytes32 digest) "
            "external returns (uint8 r, bytes32 v, bytes32 s);\n"
        )
        final_contract += "    function addr(uint256 privateKey) external returns (address add);\n"
        final_contract += (
            "    function ffi(string[] calldata inputs) external returns "
            "(bytes memory result);\n"
        )
        final_contract += "    function prank(address newSender) external;\n"
        final_contract += "    function createFork() external returns (uint256 forkId);\n"
        final_contract += "    function selectFork(uint256 forkId) external;\n}\n\n"

        # Create the exploit contract
        CryticPrint.print_information("  * Creating the exploit contract.")
        final_contract += "contract DiffFuzzUpgrades {\n"

        # State variables
        CryticPrint.print_information("  * Adding state variables declarations.")

        final_contract += "    IHevm hevm = IHevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);\n\n"
        final_contract += f"    {v_1['interface_name']} {camel_case(v_1['name'])}V1;\n"
        final_contract += f"    {v_2['interface_name']} {camel_case(v_2['name'])}V2;\n"

        structs: List[Structure] = v_2["contract_object"].structures
        if v_2["slither"] is not None:
            structs.extend(v_2["slither"].compilation_units[0].structures_top_level)

        if not fork:
            if proxy is not None:
                assert proxy["contract_object"]
                final_contract += f"    {proxy['interface_name']} {camel_case(proxy['name'])}V1;\n"
                final_contract += f"    {proxy['interface_name']} {camel_case(proxy['name'])}V2;\n"
                structs.extend(proxy["contract_object"].structures)

            for target in targets:
                assert target["contract_object"]
                final_contract += (
                    f"    {target['interface_name']} {camel_case(target['name'])}V1;\n"
                )
                final_contract += (
                    f"    {target['interface_name']} {camel_case(target['name'])}V2;\n"
                )
                structs.extend(target["contract_object"].structures)

            for target in tainted_targets:
                assert target["contract_object"]
                if target["name"] not in [t["name"] for t in other_targets]:
                    final_contract += (
                        f"    {target['interface_name']} {camel_case(target['name'])}V1;\n"
                    )
                    final_contract += (
                        f"    {target['interface_name']} {camel_case(target['name'])}V2;\n"
                    )
                    structs.extend(target["contract_object"].structures)
        else:
            if proxy is not None:
                assert proxy["contract_object"]
                final_contract += f"    {proxy['interface_name']} {camel_case(proxy['name'])};\n"
                structs.extend(proxy["contract_object"].structures)

            for target in targets:
                assert target["contract_object"]
                final_contract += f"    {target['interface_name']} {camel_case(target['name'])};\n"
                structs.extend(target["contract_object"].structures)

            for target in tainted_targets:
                assert target["contract_object"]
                if target["name"] not in [t["name"] for t in other_targets]:
                    final_contract += (
                        f"    {target['interface_name']} {camel_case(target['name'])};\n"
                    )
                    structs.extend(target["contract_object"].structures)
            final_contract += "    uint256 fork1;\n    uint256 fork2;\n"
            final_contract += "\n    event SwitchedFork(uint256 forkId);\n\n"

        # Copy structs
        seen = []
        for st in structs:
            if st.name not in seen:
                seen.append(st.name)
                final_contract += generate_struct_interface_str(st, indent=4)
                for elem in st.elems_ordered:
                    if (
                        isinstance(elem.type, UserDefinedType)
                        and isinstance(elem.type.type, StructureContract)
                        and elem.type.type not in structs
                    ):
                        structs.append(elem.type.type)

        # Constructor
        CryticPrint.print_information("  * Generating constructor.")

        if not fork:
            final_contract += self.generate_deploy_constructor(tainted_targets)
        else:
            final_contract += self.generate_fork_constructor(tainted_targets)

        # Upgrade function
        if upgrade and proxy is not None:
            CryticPrint.print_information("  * Adding upgrade function.")
            final_contract += "    /*** Upgrade Function ***/ \n\n"
            final_contract += (
                "    // TODO: Consider replacing this with the actual upgrade method\n"
            )
            final_contract += "    function upgradeV2() external virtual {\n"
            if fork:
                final_contract += "        hevm.selectFork(fork2);\n"
            if proxy["implementation_slot"] is not None:
                final_contract += "        hevm.store(\n"
                final_contract += (
                    f"            address({camel_case(proxy['name'])}"
                    f"{v_2['suffix'] if not fork else ''}),\n"
                )
                final_contract += (
                    f"            bytes32(uint({proxy['implementation_slot'].slot})),\n"
                )
                final_contract += (
                    "            bytes32(uint256(uint160(address("
                    f"{camel_case(v_2['name'])}{v_2['suffix']}))))\n"
                )
                final_contract += "        );\n"
            else:
                final_contract += (
                    "        // TODO: add upgrade logic here "
                    "(implementation slot could not be found automatically)\n"
                )
            if fork:
                final_contract += "        hevm.selectFork(fork1);\n"
                if proxy["implementation_slot"] is not None:
                    final_contract += "        bytes32 impl1 = hevm.load(\n"
                    final_contract += f"            address({camel_case(proxy['name'])}"
                    final_contract += f"{v_2['suffix'] if not fork else ''}),\n"
                    final_contract += (
                        f"            bytes32(uint({proxy['implementation_slot'].slot}))\n"
                    )
                    final_contract += "        );\n"
                    final_contract += "        bytes32 implV1 = bytes32(uint256(uint160(address("
                    final_contract += f"{camel_case(v_1['name'])}{v_1['suffix']}))));\n"
                    final_contract += "        assert(impl1 == implV1);\n"
            final_contract += "    }\n\n"

        # Wrapper functions for V1/V2
        CryticPrint.print_information("  * Adding wrapper functions for V1/V2.")

        if self._ignore_diff:
            final_contract += self.wrap_all_functions()
        else:
            final_contract += self.wrap_diff_functions(diff, tainted_targets)

        # Wrapper functions for additional targets
        if targets is not None and not self._ignore_diff:
            final_contract += self.wrap_additional_target_functions(tainted_contracts)

        # End of contract
        final_contract += "}\n"

        return final_contract

    def generate_deploy_constructor(
        self,
        tainted_targets: List[ContractData] = None,
    ) -> str:
        """Generate constructor code for path mode, including contract deployment."""
        v_1 = self.v_1
        v_2 = self.v_2
        proxy = self.proxy
        targets = self.targets
        upgrade = self._upgrade

        constructor = "\n    constructor() public {\n"
        constructor += (
            f"        {camel_case(v_1['name'])}{v_1['suffix']} = "
            f"{v_1['interface_name']}(address(new {v_1['name']}_V1()));\n"
        )
        constructor += (
            f"        {camel_case(v_2['name'])}{v_2['suffix']} = "
            f"{v_2['interface_name']}(address(new {v_2['name']}_V2()));\n"
        )
        if proxy:
            constructor += (
                f"        {camel_case(proxy['name'])}{v_1['suffix']} = "
                f"{proxy['interface_name']}(address(new {proxy['name']}()));\n"
            )
            constructor += (
                f"        {camel_case(proxy['name'])}{v_2['suffix']} = "
                f"{proxy['interface_name']}(address(new {proxy['name']}()));\n"
            )
            if proxy["implementation_slot"] is not None:
                constructor += "        // Store the implementation addresses in the proxy.\n"
                constructor += "        hevm.store(\n"
                constructor += f"            address({camel_case(proxy['name'])}{v_1['suffix']}),\n"
                constructor += f"            bytes32(uint({proxy['implementation_slot'].slot})),\n"
                constructor += (
                    "            bytes32(uint256(uint160(address("
                    f"{camel_case(v_1['name'])}{v_1['suffix']}))))\n"
                )
                constructor += "        );\n"
                constructor += "        hevm.store(\n"
                constructor += f"            address({camel_case(proxy['name'])}{v_2['suffix']}),\n"
                constructor += f"            bytes32(uint({proxy['implementation_slot'].slot})),\n"
                v2_impl = (
                    camel_case(v_1["name"]) + v_1["suffix"]
                    if upgrade
                    else camel_case(v_2["name"]) + v_2["suffix"]
                )
                constructor += f"            bytes32(uint256(uint160(address({v2_impl}))))\n"
                constructor += "        );\n"
            else:
                constructor += (
                    "        // TODO: Set proxy implementations "
                    "(proxy implementation slot not found).\n"
                )
        for target in targets:
            constructor += (
                f"        {camel_case(target['name'])}{v_1['suffix']} = "
                f"{target['interface_name']}(address(new {target['name']}()));\n"
            )
            constructor += (
                f"        {camel_case(target['name'])}{v_2['suffix']} = "
                f"{target['interface_name']}(address(new {target['name']}()));\n"
            )
        other_targets = targets
        if proxy:
            other_targets.append(proxy)
        if tainted_targets is not None:
            for target in tainted_targets:
                if target["name"] not in (
                    other["contract_object"].name
                    for other in other_targets
                    if other["contract_object"]
                ):
                    constructor += (
                        f"        {camel_case(target['name'])}{v_1['suffix']} = "
                        f"{target['interface_name']}(address(new {target['name']}()));\n"
                    )
                    constructor += (
                        f"        {camel_case(target['name'])}{v_2['suffix']} = "
                        f"{target['interface_name']}(address(new {target['name']}()));\n"
                    )
        constructor += "    }\n\n"
        return constructor

    def generate_fork_constructor(
        self,
        tainted_targets: List[ContractData] = None,
    ) -> str:
        """Generate constructor code for fork mode."""
        v_1 = self.v_1
        v_2 = self.v_2
        proxy = self.proxy
        targets = self.targets
        upgrade = self._upgrade
        network_info = self._network_info

        constructor = "\n    constructor() public {\n"
        if network_info is not None:
            constructor += f"        hevm.roll({network_info.get_block_number()});\n"
            constructor += f"        hevm.warp({network_info.get_block_timestamp()});\n"
        constructor += "        fork1 = hevm.createFork();\n        fork2 = hevm.createFork();\n"
        # TODO: Remove once Artur fixes the createFork() return value
        constructor += "        fork1 = 1;\n        fork2 = 2;\n"
        constructor += (
            f"        {camel_case(v_1['name'])}{v_1['suffix']} = "
            f"{v_1['interface_name']}({v_1['address']});\n"
        )
        constructor += (
            f"        {camel_case(v_2['name'])}{v_2['suffix']} = "
            f"{v_2['interface_name']}({v_2['address']});\n"
        )
        if proxy:
            constructor += (
                f"        {camel_case(proxy['name'])} = "
                f"{proxy['interface_name']}({proxy['address']});\n"
            )
            if proxy["implementation_slot"] is not None:
                constructor += "        // Store the implementation addresses in the proxy.\n"
                constructor += "        hevm.selectFork(fork1);\n"
                constructor += "        hevm.store(\n"
                constructor += f"            address({camel_case(proxy['name'])}),\n"
                constructor += f"            bytes32(uint({proxy['implementation_slot'].slot})),\n"
                constructor += (
                    "            bytes32(uint256(uint160(address("
                    f"{camel_case(v_1['name'])}{v_1['suffix']}))))\n"
                )
                constructor += "        );\n"
                constructor += "        hevm.selectFork(fork2);\n"
                constructor += "        hevm.store(\n"
                constructor += f"            address({camel_case(proxy['name'])}),\n"
                constructor += f"            bytes32(uint({proxy['implementation_slot'].slot})),\n"
                v2_impl = (
                    camel_case(v_1["name"]) + v_1["suffix"]
                    if upgrade
                    else camel_case(v_2["name"]) + v_2["suffix"]
                )
                constructor += f"            bytes32(uint256(uint160(address({v2_impl}))))\n"
                constructor += "        );\n"
            else:
                constructor += (
                    "        // TODO: Set proxy implementations "
                    "(proxy implementation slot not found).\n"
                )
        for target in targets:
            if target["address"] != "":
                constructor += (
                    f"        {camel_case(target['name'])} = "
                    f"{target['interface_name']}({target['address']});\n"
                )
            else:
                constructor += (
                    "        // TODO: Fill in target address below "
                    "(address not found automatically)\n"
                )
                constructor += (
                    f"        {camel_case(target['name'])} = "
                    f"{target['interface_name']}(MISSING_TARGET_ADDRESS);\n"
                )
        other_targets = targets
        if proxy:
            other_targets.append(proxy)
        if tainted_targets is not None:
            for target in tainted_targets:
                if target["name"] not in (
                    other["contract_object"].name
                    for other in other_targets
                    if other["contract_object"]
                ):
                    if target["address"] != "":
                        constructor += (
                            f"        {camel_case(target['name'])} = "
                            f"{target['interface_name']}({target['address']});\n"
                        )
                    else:
                        constructor += (
                            "        // TODO: Fill in target address below "
                            "(address not found automatically)\n"
                        )
                        constructor += (
                            f"        {camel_case(target['name'])} = "
                            f"{target['interface_name']}(MISSING_TARGET_ADDRESS);\n"
                        )
        constructor += "    }\n\n"
        return constructor
