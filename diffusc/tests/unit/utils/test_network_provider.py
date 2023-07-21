import os
from time import sleep
from random import random
from pathlib import Path
from typing import Optional

# import pytest
from solc_select.solc_select import switch_global_version
from slither import Slither
from slither.exceptions import SlitherError
from diffusc.utils.network_info_provider import NetworkInfoProvider
from diffusc.core.code_generation import CodeGenerator

TEST_DATA_DIR = Path(__file__).resolve().parent / "test_data"


def test_bad_rpc_init() -> None:
    # Should fail due to bad RPC Url
    rpc_url = "https://mainnet.infura.io/v3/no_api_key"
    try:
        NetworkInfoProvider(rpc_url, "latest")
        assert False
    except ValueError as err:
        assert str(err) == f"Could not connect to the provided RPC endpoint: {rpc_url}."


def test_bad_poa_init() -> None:
    # Should fail because is_poa = True should be passed into NetworkInfoProvider for BSC
    rpc_url = os.getenv("BSC_RPC_URL")
    assert rpc_url is not None
    try:
        NetworkInfoProvider(rpc_url, "latest")
        assert False
    except ValueError as err:
        assert (
            str(err) == "Got ExtraDataLengthError when getting block latest. "
            "Probably missing network value, if RPC url is for a POA chain."
        )


def test_bad_block_init() -> None:
    # Should fail because "final" is not a valid block identifier (should be "finalized")
    rpc_url = os.getenv("BSC_RPC_URL")
    assert rpc_url is not None
    try:
        NetworkInfoProvider(rpc_url, "final", is_poa=True)
        assert False
    except ValueError as err:
        assert (
            str(err) == '"final" is not a valid block identifier. Use "latest", "earliest", '
            '"pending", "safe" or "finalized" if not specifying an integer block number'
        )


def test_block_timestamp() -> None:
    rpc_url = os.getenv("BSC_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, 26857408, is_poa=True)
    assert net_info.get_block_timestamp() == 1680008936


def test_block_number() -> None:
    rpc_url = os.getenv("BSC_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, 26857408, is_poa=True)
    assert net_info.get_block_number() == 26857408
    net_info = NetworkInfoProvider(rpc_url, 0, is_poa=True)
    assert net_info.get_block_number() != 0


def _retry_slither_etherscan(
    address: str, prefix: str, api_key: str, retries: int
) -> Optional[Slither]:
    sl: Optional[Slither] = None
    while sl is None and retries > 0:
        try:
            sl = Slither(f"{prefix}:{address}", etherscan_api_key=api_key)
        except SlitherError:
            retries -= 1
            sleep(random() * 3)
    return sl


def test_contract_variable_value() -> None:
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0xDc0Da9E56d7AEaA47b0f4913bAbb467b6E0C81cB"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract = sl.get_contract_from_name("BadProxy")[0]
    state_var = contract.get_state_variable_from_name("stateVar1")
    assert net_info.get_contract_variable_value(state_var, contract_addr) == 1
    state_var = contract.get_state_variable_from_name("_IMPLEMENTATION_SLOT")
    # Should return empty string because slither-read-storage can't get the value of a constant
    assert net_info.get_contract_variable_value(state_var, contract_addr) == ""


def test_empty_proxy_implementation() -> None:
    # Should fail because the BadProxy I deployed has no address stored in _IMPLEMENTATION_SLOT
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0xDc0Da9E56d7AEaA47b0f4913bAbb467b6E0C81cB"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract_obj = sl.get_contract_from_name("BadProxy")[0]
    contract_data = CodeGenerator.get_contract_data(contract_obj)
    contract_data["address"] = contract_addr
    try:
        net_info.get_proxy_implementation(contract_obj, contract_data)
        assert False
    except ValueError as err:
        assert str(err) == "Proxy storage slot not found"


def test_proxy_missing_slot_info() -> None:
    # Should fail because the BadProxy I deployed overrides the fallback and breaks the data dependency
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0x5a763c928430bc5742A144358B68CD8E14243030"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract_obj = sl.get_contract_from_name("BadProxy")[0]
    contract_data = CodeGenerator.get_contract_data(contract_obj)
    contract_data["address"] = contract_addr
    try:
        net_info.get_proxy_implementation(contract_obj, contract_data)
    except ValueError as err:
        assert str(err) == "Proxy storage slot read is not an address"


def test_proxy_backup_slot_info() -> None:
    # Should not fail, because even though this BadProxy doesn't use _IMPLEMENTATION_SLOT in its fallback,
    # there is still an address stored in that slot, so the backup method in get_proxy_implementation works
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0x95315eae9e96d8603e12e2d84c5458e85b1a6a0d"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract_obj = sl.get_contract_from_name("BadProxy")[0]
    contract_data = CodeGenerator.get_contract_data(contract_obj)
    contract_data["address"] = contract_addr
    impl_addr, contract_data = net_info.get_proxy_implementation(contract_obj, contract_data)
    assert impl_addr == "0x5a763c928430bc5742a144358b68cd8e14243030"
    assert contract_data["implementation_slot"] is not None
    assert contract_data["implementation_slot"].name == "IMPLEMENTATION_SLOT"
    assert (
        contract_data["implementation_slot"].slot
        == 24440054405305269366569402256811496959409073762505157381672968839269610695612
    )


def test_proxy_legacy_slot_info() -> None:
    # Should not fail, because even though this BadProxy doesn't use _IMPLEMENTATION_SLOT in its fallback, there is
    # an address stored in the old ZeppelinOS slot, so the second backup method in get_proxy_implementation works
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0xa5D39EB3F17D43BC1e7Ded5BFA6cD61EceF2C5f0"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract_obj = sl.get_contract_from_name("BadProxy")[0]
    contract_data = CodeGenerator.get_contract_data(contract_obj)
    contract_data["address"] = contract_addr
    impl_addr, contract_data = net_info.get_proxy_implementation(contract_obj, contract_data)
    assert impl_addr == "0x5a763c928430bc5742a144358b68cd8e14243030"
    assert contract_data["implementation_slot"] is not None
    assert contract_data["implementation_slot"].name == "IMPLEMENTATION_SLOT"
    assert (
        contract_data["implementation_slot"].slot
        == 50801780122331352337026042894847907698553222651959119521779622085092237899971
    )


def test_proxy_state_var_slot_info() -> None:
    # Should not fail, because even though this BadProxy doesn't use _IMPLEMENTATION_SLOT in its fallback, there is an
    # address stored in a state var called implementation, so the last backup method in get_proxy_implementation works
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0x22F550d4B1986075088CDa550fA57B241B993AA8"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract_obj = sl.get_contract_from_name("BadProxy")[0]
    contract_data = CodeGenerator.get_contract_data(contract_obj)
    contract_data["address"] = contract_addr
    impl_addr, contract_data = net_info.get_proxy_implementation(contract_obj, contract_data)
    assert impl_addr == "0x5a763c928430bc5742A144358B68CD8E14243030"
    assert contract_data["implementation_slot"] is not None
    assert contract_data["implementation_slot"].name == "implementation"
    assert contract_data["implementation_slot"].slot == 1


def test_missing_transfer_event() -> None:
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0xDc0Da9E56d7AEaA47b0f4913bAbb467b6E0C81cB"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract = sl.get_contract_from_name("BadProxy")[0]
    abi = contract.file_scope.abi(
        sl.compilation_units[0].crytic_compile_compilation_unit, contract.name
    )
    try:
        net_info.get_token_holders(1000, 1, contract_addr, abi)
    except ValueError as err:
        assert (
            str(err) == f"Contract at {contract_addr} doesn't appear to be a token. "
            "It does not have a Transfer event."
        )


def test_missing_token_holders() -> None:
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, "latest")
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0xe1185049a764faa013b3b398beb4defb4e47bab0"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract = sl.get_contract_from_name("TestToken")[0]
    abi = contract.file_scope.abi(
        sl.compilation_units[0].crytic_compile_compilation_unit, contract.name
    )
    try:
        net_info.get_token_holders(1000, 1, contract_addr, abi)
    except ValueError as err:
        assert (
            str(err)
            == "Could not find a token holder. Please use --token-holder to set it manually."
        )


def test_few_token_holders() -> None:
    rpc_url = os.getenv("GOERLI_RPC_URL")
    assert rpc_url is not None
    net_info = NetworkInfoProvider(rpc_url, 9029011)
    api_key = os.getenv("GOERLI_API_KEY")
    assert api_key is not None
    contract_addr = "0xae4c231A9e2D5db591540e59d6374C3D2c1a2e04"
    switch_global_version("0.8.18", always_install=True)
    sl = _retry_slither_etherscan(contract_addr, "goerli", api_key, 5)
    assert sl is not None
    contract = sl.get_contract_from_name("TestToken")[0]
    abi = contract.file_scope.abi(
        sl.compilation_units[0].crytic_compile_compilation_unit, contract.name
    )
    token_holders = net_info.get_token_holders(1000, 5, contract_addr, abi)
    assert len(token_holders) == 1
    assert token_holders[0] == "0x4E39DCdac1DCa1694897B5CB783Ab52683586962"
