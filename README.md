**This work is pending a "Double-Anonymous" submission. Do not read the following to maintain the submission rules** 

# Diffusc: Differential Fuzzing of Upgradeable Smart Contract Implementations

`diffusc` is a tool for automatically generating differential fuzz testing contracts for comparing two smart contract implementations. It takes a generalized approach to detect discrepancies (hopefully unexpected) between any two implementation contracts, so as to prevent the introduction of bugs and vulnerabilities during a smart contract upgrade. 

The tool has three modes, '`standard mode`', '`fork mode`' and '`hybrid mode`', with the mode depending on how the input smart contracts are provided via the command line. 
- `Standard mode` works with file paths and deploys all target contracts in the test contract's constructor, though it may be necessary to add additional custom initialization logic by modifying the auto-generated code or using inheritance/overriding functions. 
- `Fork mode` works with addresses of contracts that have already been deployed to a network, and requires an RPC endpoint URL to create two forks of the network. This requires less custom initialization, though it is slower due to the need for RPC queries and may be less flexible than custom initialization in some cases.
- `Hybrid mode` works like `fork mode`, only the V2 is provided as a file path (for testing a deployed contract against one that is not deployed yet).

```
bin
└── echidna            # Echidna binary (copy to /usr/local/bin for fuzzing)
contracts
├── implementation     # Implementations to fuzz.
|   ├── compound       # Various versions of the Compound protocol.
|   |   ├── simplified-compound     # Compound with reduced functionality.
|   |   ├── compound-0.8.10         # V1/V2 contracts, updated to Solidity 0.8.10.
|   |   ├── Comptroller-before      # Original V1 contracts, using Solidity 0.5.16.
|   |   └── Comptroller-after       # Original V2 contracts, using Solidity 0.5.16.
|   ├── safemoon       # Safemoon contracts with several versions of the implementation.
|   └── @openzeppelin  # OpenZeppelin contracts used by Compound POC test contracts.
└── test               # Actual fuzzing testcases.
    ├── compound
    |   ├── simplified-compound     # Tests for the simplified Compound contracts.
    |   ├── DiffFuzzUpgrades.sol    # Auto-generated test contract for Compound.
    |   ├── DiffFuzzCustomInit.sol  # Inherits auto-generated contract and overrides functions.
    |   └── CryticConfig.yaml       # Auto-generated Echidna config file.
    └── safemoon
        └── DiffFuzzCustomInit.sol  # Inherits auto-generated contract and overrides functions.
diffusc
├── diffusc.py       # Main module for diffusc tool.
├── core
|   ├── analysis_mode.py              # Base class for fork-mode and path-mode modules.
|   ├── code_generation.py            # Code generation module.
|   ├── echidna.py                    # Fuzzing module.
|   ├── fork_mode.py                  # Main fork mode module.
|   ├── path_mode.py                  # Main standard mode module.
|   ├── hybrid_mode.py                # Main hybrid mode module.
|   └── report_generation.py          # Post-processing module.
├── tests/unit
|   ├── core
|   |   ├── test_data                 # Test contracts and expected outputs for core unit tests.
|   |   ├── test_code_generation.py   # Unit tests for the code generation module.
|   |   ├── test_fork_mode.py         # Unit tests for fork mode module.
|   |   └── test_path_mode.py         # Unit tests for standard mode module.
|   └── utils
|   |   ├── test_data
|   |   |   └── helpers               # Test contracts for the helper unit tests.
|   |   ├── test_helpers.py           # Unit tests for the helper functions.
|   |   ├── test_network_provider.py  # Unit tests for network info provider module.
|   |   └── test_slither_provider.py  # Unit tests for Slither provider module.
└── utils
    ├── classes.py                    # Helper classes.
    ├── crytic_print.py               # Printing to console.
    ├── from_address.py               # Address-related utilities.
    ├── from_path.py                  # Path-related utilities.
    ├── helpers.py                    # General-purpose helper functions.
    ├── network_info_provider.py      # Class for getting data from the network.
    ├── network_vars.py               # Lists and dicts of supported networks and env variables.
    └── slither_provider.py           # Classes for getting Slither objects.
```

## Setup

After cloning this repo, run the setup script (ideally in a virtual environment) and copy the `echidna-diffusc` binary to `/usr/local/bin`:
```bash
git clone https://github.com/crytic/diffusc.git
cd diffusc
pip3 install .
cp bin/echidna-diffusc /usr/local/bin
```

## Running Diffusc
The minimum required arguments for running Diffusc are two contracts, provided as either file paths or addresses:

`diffusc v1 v2 [ADDITIONAL_ARGS]`

For example, to test Compound in standard mode with the minimum of arguments:
```bash
diffusc ./contracts/implementation/compound/compound-0.8.10/ComptrollerV1.sol ./contracts/implementation/compound/compound-0.8.10/ComptrollerV2.sol
echidna DiffFuzzUpgrades.sol --contract DiffFuzzUpgrades --config CryticConfig.yaml
```
Or you can provide additional arguments for more effective testing:
```bash
diffusc ./contracts/implementation/compound/compound-0.8.10/ComptrollerHarnessV1.sol ./contracts/implementation/compound/compound-0.8.10/ComptrollerHarnessV2.sol -d ./contracts/test/compound/ -t ./contracts/implementation/compound/compound-0.8.10/CErc20.sol,./contracts/implementation/compound/compound-0.8.10/CompHarness.sol -p ./contracts/implementation/compound/compound-0.8.10/Unitroller.sol -u -V 0.8.10 --run-custom ./contracts/test/compound/DiffFuzzCustomInit.sol DiffFuzzCustomInit
```
Similarly, to test fuzzing Compound in fork mode, try:
```bash
diffusc 0x75442Ac771a7243433e033F3F8EaB2631e22938f 0x374ABb8cE19A73f2c4EFAd642bda76c797f19233 -t 0x12392F67bdf24faE0AF363c24aC620a2f67DAd86:0xa035b9e130f2b1aedc733eefb1c67ba4c503491f,0xc00e94Cb662C3520282E6f5717214004A7f26888 -p 0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B -u -V 0.8.10 -T --token-holder 0x309d413391e975B553B7B8D19bC11F8a6c2eB889 -r
```

### Command Line Arguments
Additional options unlock greater functionality:
* `-p, --proxy`: Specifies the proxy to use (either a file path or an address, same mode as V1/V2).
* `-t, --targets`: Comma separated list of additional target contracts (either file paths or addresses, same as V1/V2). For additional targets that are also upgradeable, you can provide the proxy's implementation address in the following format: `<PROXY_ADDR>:<IMPL_ADDR>`
* `-d, --output-dir`: Directory to store the test contract and config file in.
* `-A, --contract-addr`: Address to which to deploy the test contract.
* `-L, --campaign-length`: The campaign length to use with Echidna (default 1000000000000).
* `-l, --seq-len`: Transaction sequence length for Echidna fuzzing (default 100).
* `-n, --network`: The network the contracts are deployed on (for fork mode). This parameter should have the same name as Slither supported networks. The current list of supported network prefixes is:
  * `mainet` for Ethereum main network (default if no `--network` is specified)
  * `optim` for Optimism
  * `bsc` for Binance Smart Chain
  * `arbi` for Arbitrum
  * `poly` for Polygon
  * `avax` for Avalanche
  * `ftm` for Fantom
  
  Also, the following test networks are supported:
  * `ropsten` for Ropsten (deprecated)
  * `kovan` for Kovan (deprecated)
  * `rinkeby` for Rinkeby (deprecated)
  * `goerli` for Goerli
  * `testnet.bsc` for Binance Smart Chain
  * `testnet.arbi` for Arbitrum
  * `mumbai` for Polygon
  * `testnet.avax` for Avalanche
  * `tobalaba` for Energy Web
* `-b, --block`: The block to use (for fork mode). Can also be set using the `ECHIDNA_RPC_BLOCK` environment variable.
* `-R, --network-rpc`: The RPC node URL to use (for fork mode). Can also be set using the `ECHIDNA_RPC_URL` environment variable.
* `-K, --etherscan-key`: The block explorer API key to use (for fork mode). Can also be set using the `ETHERSCAN_API_KEY` environment variable.
* `-T, --token-holders`: Flag to search for token holders (in fork mode) for any targets that implement ERC20 (default false).
* `--token-holder`: Explicitly specify a token holder address to use as a sender (in fork mode).
* `--senders`: Explicitly specify a list of sender addresses to use (in fork mode). Echidna defaults to `0x1000`, `0x2000` and `0x3000`.
* `--min-token-balance`: The minimum token balance required when searching for holders (default 10000).
* `--max-token-holders`: The maximum number of holders to find per token (default 5).
* `-V, --solc-version`: The solc compiler version to use (default 0.8.0).
* `-v, --version`: The current version of Diffusc.
* `-u, --fuzz-upgrade`: Flag to include an upgrade function in test contract, to upgrade to V2 mid-transaction sequence (default false).
* `-P, --protected`: Flag to include test wrappers for protected functions, i.e., with modifier like `onlyOwner` (default false).
* `-x, --external-taint`: Flag to analyze external calls to find tainted external contracts (default false).
* `-r, --run`: Flag to run Echidna on the generated test contract before terminating (default false).
* `-W, --workers`: Specify how many workers (cores) Echidna should use in run mode (default 1).
* `--run-custom <CONTRACT_PATH> <CONTRACT_NAME>`: Runs Echidna on the given contract (i.e., one which inherits the generated test contract).
* `--ignore-diff`: Flag to ignore the diff and include wrappers for all functions, not just those affected by the change (default false). Mostly useful for tool evaluation.
