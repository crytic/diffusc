"""Module containing class for getting and storing network information."""

# pylint: disable= no-name-in-module
from time import sleep
from typing import Any, Tuple, List, Optional
from requests.exceptions import HTTPError
from web3 import Web3, logs
from web3.middleware import geth_poa_middleware
from web3.exceptions import ExtraDataLengthError, BadFunctionCallOutput, ABIEventFunctionNotFound
from slither.core.variables.state_variable import StateVariable
from slither.core.declarations.contract import Contract
from slither.tools.read_storage import SlitherReadStorage, RpcInfo
from slither.tools.read_storage.utils import get_storage_data
from slither.utils.upgradeability import get_proxy_implementation_slot
from eth_utils import is_address, to_checksum_address

from diffusc.utils.crytic_print import CryticPrint
from diffusc.utils.classes import ContractData, SlotInfo


class NetworkInfoProvider:
    """Class for getting and storing information from the network."""

    _w3: Web3
    _block: int
    _rpc_provider: str
    _is_poa: bool

    def __init__(self, rpc_provider: str, block: str | int, is_poa: bool = False) -> None:

        if rpc_provider != "":
            self._rpc_provider = rpc_provider
            self._w3 = Web3(Web3.HTTPProvider(rpc_provider))

        if not self._w3.is_connected():
            CryticPrint.print_error("* Could not connect to the provided RPC endpoint.")
            raise ValueError(f"Could not connect to the provided RPC endpoint: {rpc_provider}.")

        # Workaround for PoA networks
        if is_poa:
            self._is_poa = True
            self._w3.middleware_onion.inject(geth_poa_middleware, layer=0)
        else:
            self._is_poa = False

        try:
            if block in [0, ""]:
                self._block = int(self._w3.eth.get_block("latest")["number"])
            elif block in ["latest", "earliest", "pending", "safe", "finalized"]:
                self._block = int(self._w3.eth.get_block(block)["number"])  # type: ignore[arg-type]
            else:
                self._block = int(block)
        except ExtraDataLengthError as err:
            raise ValueError(
                f"Got ExtraDataLengthError when getting block {str(block)}."
                " Probably missing network value, if RPC url is for a POA chain."
            ) from err
        except ValueError as err:
            raise ValueError(
                f'"{block}" is not a valid block identifier. Use '
                '"latest", "earliest", "pending", "safe" or "finalized" if not specifying an integer block number'
            ) from err

    def get_block_timestamp(self) -> int:
        """Timestamp getter."""
        if self._block != 0:
            return self._w3.eth.get_block(self._block)["timestamp"]
        return 0  # pragma: no cover

    def get_block_number(self) -> int:
        """Block number getter."""
        return self._block

    def get_contract_variable_value(
        self, variable: StateVariable, address: str, contract: Optional[Contract] = None
    ) -> Any:
        """Get the value of a state variable from a contract's storage."""
        if contract is None:
            contract = variable.contract
        rpc_info = RpcInfo(self._rpc_provider, self._block)
        srs = SlitherReadStorage([contract], 20, rpc_info)
        # srs = SlitherReadStorage([contract], 20)

        srs.storage_address = address
        srs.block = self._block
        srs.rpc = self._rpc_provider
        # # No longer necessary because SlitherReadStorage now has native POA support
        # if self._is_poa:
        #     srs.web3.middleware_onion.inject(geth_poa_middleware, layer=0)  # pragma: no cover

        try:
            slot = srs.get_storage_slot(variable, contract)
            srs.get_slot_values(slot)
            return slot.value
        except (ValueError, TypeError, AssertionError, AttributeError):
            return ""

    def get_proxy_implementation(
        self, contract: Contract, contract_data: ContractData
    ) -> Tuple[str, ContractData]:
        """Get a proxy's implementation address from the proxy's storage."""

        assert contract_data["address"]
        address = contract_data["address"]
        CryticPrint.print_information(
            f"    * Getting proxy implementation from {contract.name} at {address}."
        )

        slot: SlotInfo = get_proxy_implementation_slot(contract)
        if slot is not None:
            slot_bytes = int.to_bytes(slot.slot, 32, byteorder="big")
            imp = get_storage_data(self._w3, to_checksum_address(address), slot_bytes, self._block)
            impl_address = "0x" + imp.hex()[-40:]

            if (
                impl_address != "0x0000000000000000000000000000000000000000"
                and self._w3.eth.get_code(to_checksum_address(impl_address), self._block)
            ):
                return impl_address, contract_data
            if impl_address == "0x0000000000000000000000000000000000000000":
                CryticPrint.print_warning(f"      * storage slot {slot.name} is zero")
            else:
                CryticPrint.print_warning(
                    f"      * storage slot {slot.name} does not contain a contract address"
                )

            raise ValueError("Proxy storage slot not found")
        try:
            # Start by reading EIP1967 storage slot keccak256('eip1967.proxy.implementation') - 1
            imp = get_storage_data(
                self._w3,
                to_checksum_address(address),
                int.to_bytes(
                    0x360894A13BA1A3210667C828492DB98DCA3E2076CC3735A920A3CA505D382BBC, 32, "big"
                ),
                self._block,
            )
            impl_address = "0x" + imp.hex()[-40:]

            if impl_address != "0x0000000000000000000000000000000000000000":
                contract_data["implementation_slot"] = SlotInfo(
                    name="IMPLEMENTATION_SLOT",
                    type_string="address",
                    slot=int(
                        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc",
                        16,
                    ),
                    size=160,
                    offset=0,
                )
                return impl_address, contract_data

            CryticPrint.print_warning("      * EIP1967 storage slot is zero")

            # Try slot keccak256('org.zeppelinos.proxy.implementation') used by early OZ proxies
            imp = get_storage_data(
                self._w3,
                to_checksum_address(address),
                int.to_bytes(
                    0x7050C9E0F4CA769C69BD3A8EF740BC37934F8E2C036E5A723FD8EE048ED3F8C3, 32, "big"
                ),
                self._block,
            )
            impl_address = "0x" + imp.hex()[-40:]

            if impl_address != "0x0000000000000000000000000000000000000000":
                contract_data["implementation_slot"] = SlotInfo(
                    name="IMPLEMENTATION_SLOT",
                    type_string="address",
                    slot=int(
                        "0x7050c9e0f4ca769c69bd3a8ef740bc37934f8e2c036e5a723fd8ee048ed3f8c3",
                        16,
                    ),
                    size=160,
                    offset=0,
                )
                return impl_address, contract_data

            CryticPrint.print_warning("      * OZ ZeppelinOS proxies storage slot is zero")

            raise ValueError("Proxy storage slot not found")

        except (ValueError, TypeError, AssertionError) as err:
            # Fallback: Try finding a state variable with "implementation" or "target" in its name
            implementation_var = []

            for var in contract.state_variables_ordered:
                if (
                    var.name.lower().find("implementation") >= 0
                    or var.name.lower().find("target") >= 0
                ):
                    implementation_var.append(var)

            if not implementation_var:  # pragma: no cover
                CryticPrint.print_warning(
                    "      * Couldn't find proxy implementation in contract storage"
                )
                raise ValueError("Couldn't find proxy implementation in contract storage") from err
            for imp in implementation_var:
                slot_value = self.get_contract_variable_value(imp, address)

                slot_value = "0x" + slot_value if slot_value[0:2] != "0x" else slot_value

                if (
                    is_address(slot_value)
                    and slot_value != "0000000000000000000000000000000000000000"
                ):
                    CryticPrint.print_warning(
                        "      * Proxy implementation address read from variable:"
                        f" {imp.type} {imp.name}"
                    )
                    srs = SlitherReadStorage(contract, 20)
                    slot_info = srs.get_storage_slot(imp, contract)
                    contract_data["implementation_slot"] = slot_info
                    return slot_value, contract_data

            CryticPrint.print_error("      * Proxy storage slot read is not an address")
            raise ValueError("Proxy storage slot read is not an address") from err

    # pylint: disable=too-many-locals
    def get_token_holders(
        self, min_token_amount: int, max_holders: int, address: str, abi: str
    ) -> List[str]:
        """Get a list of holder addresses for the token at the given address."""

        block_from = int(self._block) - 500
        block_to = int(self._block)
        max_retries = 50
        holders: List[str] = []
        seen: List[str] = []

        CryticPrint.print_information(f"* Looking for {max_holders} holders of token at {address}")

        contract = self._w3.eth.contract(address=to_checksum_address(address), abi=abi)

        while max_retries > 0 and len(holders) < max_holders:
            try:
                block_filter = contract.events.Transfer.create_filter(  # type: ignore[attr-defined]
                    fromBlock=block_from, toBlock=block_to
                )
                events = block_filter.get_all_entries()
                if not events:
                    max_retries -= 1
                    block_from -= 500
                    block_to -= 500
                    continue

                events.reverse()

                for event in events:
                    receipt = self._w3.eth.wait_for_transaction_receipt(event["transactionHash"])
                    results = contract.events.Transfer().process_receipt(
                        receipt, errors=logs.DISCARD
                    )
                    for result in results:
                        event_data = list(result["args"].values())
                        recipient = event_data[1]
                        if (
                            recipient in seen
                            or recipient == address
                            or result["event"] != "Transfer"
                        ):
                            continue
                        seen.append(recipient)
                        try:
                            balance = contract.functions.balanceOf(recipient).call(
                                block_identifier=int(self._block)
                            )
                        except BadFunctionCallOutput:  # pragma: no cover
                            continue
                        if balance < min_token_amount or self._w3.eth.get_code(
                            recipient, self._block
                        ):
                            continue
                        CryticPrint.print_information(
                            f"  * Found holder with balance of {balance} at {recipient}"
                        )
                        holders.append(recipient)
                        max_retries += 1
                        if len(holders) == max_holders:
                            return holders
                max_retries -= 1
                block_from -= 500
                block_to -= 500
            except HTTPError:  # pragma: no cover
                sleep(10)
                max_retries -= 1
                continue
            except ABIEventFunctionNotFound as err:
                CryticPrint.print_error(
                    f"Contract at {address} doesn't appear to be a token. It does not have a Transfer event."
                )
                raise ValueError(
                    f"Contract at {address} doesn't appear to be a token. It does not have a Transfer event."
                ) from err

        if len(holders) > 0:
            CryticPrint.print_warning(
                f"* {max_holders} token holders requested, but only {len(holders)} found."
            )
            return holders

        CryticPrint.print_error(
            f"* Could not find a token holder for {address}. "
            "Please use --token-holder to set it manually."
        )
        raise ValueError(
            "Could not find a token holder. Please use --token-holder to set it manually."
        )
