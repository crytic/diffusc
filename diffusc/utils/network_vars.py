"""Module containing supported networks and environment variables."""


SUPPORTED_NETWORKS = [
    "mainet",
    "optim",
    "ropsten",
    "kovan",
    "rinkeby",
    "goerli",
    "tobalaba",
    "bsc",
    "testnet.bsc",
    "arbi",
    "testnet.arbi",
    "poly",
    "mumbai",
    "avax",
    "testnet.avax",
    "ftm",
]
WEB3_RPC_ENV_VARS = ["WEB3_PROVIDER_URI", "ECHIDNA_RPC_URL", "RPC_URL"]
SUPPORTED_BLOCK_EXPLORER_ENV_VARS = {
    "mainet": "ETHERSCAN_API_KEY",
    "optim": "OPTIMISTIC_ETHERSCAN_API_KEY",
    "bsc": "BSCSCAN_API_KEY",
    "arbi": "ARBISCAN_API_KEY",
    "poly": "POLYGONSCAN_API_KEY",
    "avax": "SNOWTRACE_API_KEY",
    "ftm": "FTMSCAN_API_KEY",
}
SUPPORTED_RPC_ENV_VARS = {
    "mainet": "ECHIDNA_RPC_URL_MAINNET",
    "optim": "ECHIDNA_RPC_URL_OPTIMISM",
    "ropsten": "ECHIDNA_RPC_URL_ROPSTEN",
    "kovan": "ECHIDNA_RPC_URL_KOVAN",
    "rinkeby": "ECHIDNA_RPC_URL_RINKEBY",
    "goerli": "ECHIDNA_RPC_URL_GOERLI",
    "tobalaba": "ECHIDNA_RPC_URL_TOBALABA",
    "bsc": "ECHIDNA_RPC_URL_BSC",
    "testnet.bsc": "ECHIDNA_RPC_URL_BSC_TESTNET",
    "arbi": "ECHIDNA_RPC_URL_ARBI",
    "testnet.arbi": "ECHIDNA_RPC_URL_ARBI_TESTNET",
    "poly": "ECHIDNA_RPC_URL_POLY",
    "mumbai": "ECHIDNA_RPC_URL_MUMBAI",
    "avax": "ECHIDNA_RPC_URL_AVAX",
    "testnet.avax": "ECHIDNA_RPC_URL_AVAX_TESTNET",
    "ftm": "ECHIDNA_RPC_URL_FTM",
}
