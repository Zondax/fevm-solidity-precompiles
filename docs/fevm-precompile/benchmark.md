---
title: "Benchmarks"
sidebar_position: 4
---

## Milestone 1 

This benchmark compares gas used for CBOR serialization written in solidity with other calls like a simple transfer of FIL or a ERC20 transfer call written using [AssemblyScript SDK](https://github.com/Zondax/fvm-as-sdk/) developed by Zondax.

## Benchmarks

The complete delivery plan can be found [here](https://github.com/filecoin-project/ref-fvm/issues/692).

### Talc [:link:](https://github.com/filecoin-project/ref-fvm/issues/691)

This benchmark shows the progression in the initial FEVM implementation.

```
|------------------------------------|----------------------|
| Call                               | Gas used             |
|------------------------------------|----------------------|
| serializeAddSigner (CBOR contract) | 107,072,567          |
| serializeAddress (CBOR contract)   |  82,175,116          |
| serializeBool (CBOR contract)      |  14,151,467          |
| getBalance (SimpleCoin contract)   |   9,321,353          |
| ERC20 send (assemblyscript native) |     697,452          |
| Simple send (native)               |     413,868          |
|------------------------------------|----------------------|
```


### Selenium [:link:](https://github.com/filecoin-project/ref-fvm/issues/801)

This benchmark shows the progression after FEVM optimizations.

```
|------------------------------------|----------------------|
| Call                               | Gas used             |
|------------------------------------|----------------------|
| serializeAddSigner (CBOR contract) |  13,922,379          |
| serializeAddress (CBOR contract)   |  11,341,547          |
| serializeBool (CBOR contract)      |   3,719,855          |
| getBalance (SimpleCoin contract)   |   3,356,533          |
|------------------------------------|----------------------|
```

### Copper [:link:](https://github.com/filecoin-project/ref-fvm/issues/830)

## Milestone 2

This benchmark shows the progression after FEVM optimizations.

```
|------------------------------------|----------------------|
| Call                               | Gas used             |
|------------------------------------|----------------------|
| serializeAddSigner (CBOR contract) |  14,602,887          |
| serializeAddress (CBOR contract)   |  11,930,295          |
| serializeBool (CBOR contract)      |   4,042,787          |
| getBalance (SimpleCoin contract)   |   3,665,937          |
|------------------------------------|----------------------|
```


This benchmark compares gas used for CBOR serialization using precompiled contracts with other calls like a simple transfer of FIL or a ERC20 transfer call written using [AssemblyScript SDK](https://github.com/Zondax/fvm-as-sdk/) developed by Zondax. It also includes Milestone 1 benchmark result.

## Benchmarks

```
|------------------------------------|----------------------|
| Call                               | Gas used             |
|------------------------------------|----------------------|
| serializeAddSigner (CBOR contract) |  14,602,887          |
| serializeAddress (CBOR contract)   |  11,930,295          |
| serializeBool (CBOR contract)      |   4,042,787          |
| test (precompiled contract)        |   2,474,315          |
| sha256 (precompiled contract)      |   2,171,066          |
| cborBoolean (precompiled contract) |   2,507,039          |
| cborAddress (precompiled contract) |   2,059,723          |
| ERC20 send (assemblyscript native) |     697,452          |
| Simple send (native)               |     413,868          |
|------------------------------------|----------------------|
```
