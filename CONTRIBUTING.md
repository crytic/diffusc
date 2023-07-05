# Contributing to Slither

First, thanks for your interest in contributing to Slither! We welcome and appreciate all contributions, including bug reports, feature suggestions, tutorials/blog posts, and code improvements.

If you're unsure where to start, we recommend our [`good first issue`](https://github.com/crytic/diffusc/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22) and [`help wanted`](https://github.com/crytic/diffusc/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) issue labels.

## Bug reports and feature suggestions

Bug reports and feature suggestions can be submitted to our issue tracker. For bug reports, attaching the contracts that caused the bug will help us in debugging and resolving the issue quickly. If you find a security vulnerability, do not open an issue; email opensource@trailofbits.com instead.

## Questions

Questions can be submitted to the "Discussions" page, and you may also join our [chat room](https://empireslacking.herokuapp.com/) (in the #ethereum channel).

## Code

Slither uses the pull request contribution model. Please make an account on Github, fork this repo, and submit code contributions via pull request. For more documentation, look [here](https://guides.github.com/activities/forking/).

Some pull request guidelines:

- Work from the [`dev`](https://github.com/crytic/diffusc/tree/dev) branch. We performed extensive tests prior to merging anything to `main`, working from `dev` will allow us to merge your work faster.
- Minimize irrelevant changes (formatting, whitespace, etc) to code that would otherwise not be touched by this patch. Save formatting or style corrections for a separate pull request that does not make any semantic changes.
- When possible, large changes should be split up into smaller focused pull requests.
- Fill out the pull request description with a summary of what your patch does, key changes that have been made, and any further points of discussion, if applicable.
- Title your pull request with a brief description of what it's changing. "Fixes #123" is a good comment to add to the description, but makes for an unclear title on its own.

## Directory Structure

Below is a rough outline of the diffusc repo:

```text
bin
└── echidna            # Echidna binary (copy to /usr/local/bin for fuzzing)
contracts
├── implementation     # Implementations to fuzz.
└── test               # Actual fuzzing testcases.
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

## Developer Installation

Diffusc currently requires at least Python3.8 so make sure you have a sufficiently up-to-date installation by running `python --version`. We recommend [pyenv](https://github.com/pyenv/pyenv) to manage python versions.

To start working on modifications to Diffusc locally, run:
```shell
git clone https://github.com/crytic/diffusc
cd diffusc
git checkout dev
make dev
```

This will create a virtual environment, `./env/`, in the root of the repo.

To run commands using your development version of Diffusc, run:

```shell
source ./env/bin/activate
```

### Setting up IDE-based debugging
1. Configure your IDE to use `./env/bin/python` as the interpreter.
2. Use `diffusc` as the entrypoint for the debugger.
3. Pycharm specific: Set the environment working directory to `./env/bin/`

### Linters

Several linters are run on the PRs.

To run them locally in the root dir of the repository:

- `make lint`

> Note, this only validates but does not modify the code.

To automatically reformat the code:

- `make reformat`

We use pylint `2.13.4`, black `22.3.0`.

### Testing

Diffusc's test suite is divided into two categories: end-to-end (`diffusc/tests/e2e`) and unit (`diffusc/tests/unit`).

How do I know what kind of test(s) to write?

- End-to-end: functionality that requires invoking `diffusc` and inspecting some output such as generated code or fuzzing results.
- Unit: additions and modifications to individual components should be accompanied by a unit test that defines the expected behavior. Aim to write functions in as pure a way as possible such that they are easier to test.

In addition, we run `diffusc` on several example contracts in both standard and fork mode as part of our CI workflow. You can find these CI tests in `.github/workflows/ci-fork-mode.yml` and `.github/workflows/ci-path-mode.yml`.