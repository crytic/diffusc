"""Module with base class for ForkMode and PathMode."""

import time
import argparse
from os.path import commonpath
from typing import List, Optional
from diffusc.utils.classes import ContractData, Diff
from diffusc.utils.crytic_print import CryticPrint
from diffusc.utils.slither_provider import SlitherProvider
from diffusc.utils.network_info_provider import NetworkInfoProvider
from diffusc.core.code_generation import CodeGenerator


# pylint: disable=too-many-instance-attributes
class AnalysisMode:
    """Base class inherited by PathMode and ForkMode."""

    _mode: str
    _provider: Optional[SlitherProvider]
    net_info: Optional[NetworkInfoProvider]
    _v1: Optional[ContractData]
    _v2: Optional[ContractData]
    _proxy: Optional[ContractData]
    _targets: Optional[List[ContractData]]
    _diff: Optional[Diff]
    code_generator: Optional[CodeGenerator]
    out_dir: str
    version: str
    upgrade: bool
    protected: bool
    external_taint: bool
    ignore_diff: bool

    def __init__(self, args: argparse.Namespace) -> None:
        self._v1 = None
        self._v2 = None
        self._proxy = None
        self._targets = None
        self._diff = None
        self.code_generator = None
        try:
            self.parse_args(args)
        except ValueError as err:
            raise ValueError(str(err)) from err

    def parse_args(self, args: argparse.Namespace) -> None:
        """Parse arguments that are used in both analysis modes."""

        if args.output_dir:
            self.out_dir = args.output_dir
        else:
            self.out_dir = "./"

        if args.version:
            self.version = args.version
        else:
            self.version = "0.8.0"

        if args.fuzz_upgrade and not args.proxy:
            CryticPrint.print_warning(
                "  * Upgrade during fuzz sequence specified via command line parameter,"
                " but no proxy was specified. Ignoring...",
            )
            self.upgrade = False
        else:
            self.upgrade = bool(args.fuzz_upgrade)

        self.protected = bool(args.include_protected)
        self.external_taint = bool(args.external_taint)
        self.ignore_diff = bool(args.ignore_diff)

    def analyze_contracts(self) -> None:
        """
        Must be implemented by subclasses. Should get ContractData for all contracts and
        set self._v1 and self._v2, plus self._proxy and self._targets if necessary.
        """
        raise NotImplementedError()

    def dependencies_common_path(self) -> str:
        assert self._v1 and self._v2
        paths = [self._v1["path"], self._v2["path"]]
        if self._targets:
            paths.extend([target["path"] for target in self._targets])
        if self._proxy:
            paths.append(self._proxy["path"])
        return commonpath(paths)

    def write_test_contract(self) -> str:
        """
        Calls CodeGenerator.generate_test_contract and returns the generated contract code.
        :return: The test contract code as a string.
        """
        if not self._v1 or not self._v2:
            self.analyze_contracts()
        assert self._v1 and self._v2 and self._diff

        start_time = time.time()
        self.code_generator = CodeGenerator(
            self._v1,
            self._v2,
            self._mode,
            self.version,
            self.upgrade,
            self.protected,
            self.net_info,
            ignore_diff=self.ignore_diff,
        )
        self.code_generator.proxy = self._proxy
        if self._targets is not None:
            self.code_generator.targets = self._targets

        contract = self.code_generator.generate_test_contract(self._diff, output_dir=self.out_dir)
        end_time = time.time()
        CryticPrint.print_message(
            f"  * Contract generation completed in {end_time - start_time} seconds."
        )
        return contract
