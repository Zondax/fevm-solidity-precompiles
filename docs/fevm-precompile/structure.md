---
title: "Project structure"
sidebar_position: 3
---

## Milestone 1

This project has only one main folder called `contracts`. There are a few other folders less important, but quite relevant.

### Contracts

Inside this folder two solidity smart contracts are located. The first one is used as reference regarding gas consumption. It implements a coin, like an ERC20, but in a few lines of code. The second one is where the cbor proof of concept is implemented.
Different methods were created in order to measure and compare the gas consumption generated by the execution of them. Each method serialize a different type of data.

### Other folders

Inside `docs` you will find information relevant to this project. Everything you need to know in order to be ready to understand it is there.

Inside `.github/workflows` you will find some CI jobs, relevant to any user who wants to run the smart contracts. These jobs work as examples on how to build and run the reference and poc smart contracts.

## Milestone 2

The project is composed of this repository and the [builtin-actors repository](https://github.com/Zondax/builtin-actors/tree/misc/precompiles)

### Contract

The contract is called `Precompile.sol`. It is a contract to test calling precompiled contract in FEVM.

Available functions:
    * `test` - Call the `test` precompiled contract which take no argument and return an empty buffer.
    * `cborBoolean` - Call the `cbor_boolean` precompiled contract which take as an argument a boolean and return its CBOR encoded value.
    * `cborAddress` - Call the `cbor_address` precompiled contract which take as an argument an address and return its CBOR encoded value.
    * `subSha256` - Call the `sha256` precompiled contract. It shows how to use precompiled contract.

### `builtin-actors` Repository

The `builtin-actors` repo contains the precompiled contracts. They are inside the EVM actor.

The contracts are defined in the [precompiles.rs file](https://github.com/Zondax/builtin-actors/blob/misc/precompiles/actors/evm/src/interpreter/precompiles.rs#L70-L73)