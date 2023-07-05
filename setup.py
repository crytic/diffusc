# pylint: disable=all

from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as f:
    long_description = f.read()

setup(
    name="diffusc",
    description="Diffusc automatically generates differential fuzz testing contracts for use with Echidna.",
    url="https://github.com/webthethird/solidity-diff-fuzz-upgrades",
    author="Trail of Bits",
    version="0.1.0",
    packages=find_packages(),
    python_requires=">=3.8",
    install_requires=[
        "colorama==0.4.4",
        "packaging",
        "eth_typing>=3.0.0",
        "eth_utils>=2.1.0",
        # "slither_analyzer==0.9.3",
        "slither-analyzer@git+https://github.com/webthethird/slither.git@dev-diffusc-testing",
        "crytic-compile>=0.3.1,<0.4.0",
        # "crytic-compile@git+https://github.com/crytic/crytic-compile.git@master#egg=crytic-compile",
        "web3>=6.0.0",
    ],
    extras_require={
        "lint": [
            "black==22.3.0",
            "pylint==2.13.4",
            "mypy==1.2.0",
        ],
        "test": [
            "pytest",
            "pytest-cov",
            "pytest-xdist",
            "deepdiff",
            "numpy",
            "coverage[toml]",
        ],
        "dev": [
            "diffusc[lint,test]",
        ],
    },
    license="AGPL-3.0",
    long_description=long_description,
    long_description_content_type="text/markdown",
    entry_points={
        "console_scripts": [
            "diffusc = diffusc.diffusc:main",
        ]
    },
)
